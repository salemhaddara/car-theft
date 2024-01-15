// ignore_for_file: camel_case_types, unnecessary_nullable_for_final_variable_declarations, file_names, library_private_types_in_public_api

import 'dart:async';
import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mapScreen extends StatefulWidget {
  const mapScreen({Key? key}) : super(key: key);

  @override
  _mapScreenState createState() => _mapScreenState();
}

class _mapScreenState extends State<mapScreen> {
  late Size size;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late DatabaseReference _databaseReference;
  late StreamSubscription<DatabaseEvent> _subscription;
  LatLng? _customerLocation;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    addCustomIcon();
    _retrieveDeviceIDAndFetchLocation();
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/images/carmarker.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> _retrieveDeviceIDAndFetchLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('deviceId');

    if (deviceId != null) {
      _databaseReference = FirebaseDatabase.instance.ref().child(deviceId);
      _subscription = _databaseReference.onValue.listen((DatabaseEvent event) {
        if (event.snapshot.value != null) {
          try {
            Map<Object?, Object?> map =
                event.snapshot.value as Map<Object?, Object?>;
            double latitude = map['lat'] as double;
            double longitude = map['long'] as double;
            setState(() {
              _customerLocation = LatLng(latitude, longitude);
            });
            _moveToCustomerLocation();
          } catch (e) {
            print(e);
          }
        }
      }, onError: (Object? error) {
        print('Error: $error');
      });
    } else {
      print('Device ID not found in SharedPreferences.');
    }
  }

  void _moveToCustomerLocation() {
    if (_customerLocation != null && _controller.isCompleted) {
      _controller.future.then((controller) {
        controller.animateCamera(
          CameraUpdate.newLatLngZoom(
            _customerLocation!,
            15.0,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _moveToCustomerLocation,
        backgroundColor: white,
        child: SvgPicture.asset('assets/images/carlocation.svg'),
      ),
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        shadowColor: black,
        centerTitle: true,
        elevation: 0,
        leading: Container(),
        title: text400normal(
            text: 'CAR LOCATION',
            color: blue,
            weight: FontWeight.w700,
            fontsize: size.width * 0.05),
      ),
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.all(16),
          ),
          _customerLocation != null
              ? GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: _customerLocation!,
                    zoom: 14.0,
                  ),
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  markers: {
                    Marker(
                        markerId: const MarkerId('customer_location'),
                        position: _customerLocation!,
                        icon: markerIcon),
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }
}
