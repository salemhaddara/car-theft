import 'package:cartheftsafety/features/locationsLog/recentlocationswidgets/recentlocation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationsLog extends StatefulWidget {
  const LocationsLog({Key? key}) : super(key: key);

  @override
  _LocationsLogState createState() => _LocationsLogState();
}

class _LocationsLogState extends State<LocationsLog> {
  late Size size;
  late List<LogItem> logItems = [];

  @override
  void initState() {
    super.initState();
    fetchLogs();
  }

  Future<void> fetchLogs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('deviceId');

    if (deviceId != null) {
      // Assuming 'record-deviceId' is your Firestore collection
      CollectionReference<Map<String, dynamic>> logsCollection =
          FirebaseFirestore.instance.collection('record-$deviceId');

      // Fetch logs from Firestore based on deviceId
      QuerySnapshot<Map<String, dynamic>> snapshot = await logsCollection.get();

      if (snapshot.docs.isNotEmpty) {
        List<LogItem> fetchedLogs = snapshot.docs.map((doc) {
          return LogItem.fromSnapshot(doc);
        }).toList();

        setState(() {
          logItems = fetchedLogs;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        shadowColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        leading: Container(),
        title: Text(
          'Recent Location',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: size.width * 0.05),
        ),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.2,
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Image.asset(
                'assets/images/carback.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: logItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: recentLocation(
                    size: size,
                    onTap: () {
                      launchURL(
                          logItems[index]); // Handle URL launching on item tap
                    },
                    position: LatLng(
                        logItems[index].latitude, logItems[index].longitude),
                    time: logItems[index].formattedTime,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void launchURL(LogItem logItem) {
    String url =
        'https://www.google.com/maps?q=${logItem.latitude},${logItem.longitude}';
    launchUrl(Uri.parse(url));
  }
}

class LogItem {
  final double latitude;
  final double longitude;
  final Timestamp timestamp;

  LogItem({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  factory LogItem.fromSnapshot(DocumentSnapshot snapshot) {
    return LogItem(
      latitude: snapshot['lat'] ?? 0.0,
      longitude: snapshot['long'] ?? 0.0,
      timestamp: snapshot['timestamp'] ?? 0,
    );
  }

  String get formattedTime {
    // Format timestamp to display 'Yesterday' or 'Today' if applicable
    final DateTime now = DateTime.now();
    final DateTime logTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm a');

    if (now.year == logTime.year &&
        now.month == logTime.month &&
        now.day == logTime.day) {
      return 'Today, ${formatter.format(logTime)}';
    } else if (now.year == logTime.year &&
        now.month == logTime.month &&
        now.day - logTime.day == 1) {
      return 'Yesterday, ${formatter.format(logTime)}';
    } else {
      return formatter.format(logTime);
    }
  }
}
// https://www.google.com/maps?q=${widget.lattitude},${widget.longitude}'