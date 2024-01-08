// ignore_for_file: camel_case_types, file_names

import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:cartheftsafety/features/profile/widgets/profileCard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({super.key});

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
                child: Stack(
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
                _detailsCard(size),
              ],
            ))
          ],
        )));
  }

  _detailsCard(Size size) {
    return FutureBuilder(
      future: _getDataFromSharedPreferences(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loader while fetching data
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Map<String, String>? userData = snapshot.data;

            return userData != null
                ? profileCard(
                    username: userData['fullName'] ?? 'N/A',
                    phoneNumber: userData['deviceId'] ?? 'N/A',
                    emailAddress: userData['email'] ?? 'N/A',
                    password: '',
                    size: size,
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: white,
                    ),
                  );
          }
        }
      },
    );
  }

  Future<Map<String, String>?> _getDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? fullName = prefs.getString('fullName');
    String? email = prefs.getString('email');
    String? deviceId = prefs.getString('deviceId');

    if (fullName != null && email != null && deviceId != null) {
      return {'fullName': fullName, 'email': email, 'deviceId': deviceId};
    } else {
      return null;
    }
  }
}
