// ignore_for_file: file_names

import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class modechange extends StatelessWidget {
  final Size size;
  const modechange({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          SharedPreferences prefs = snapshot.data!;
          String? deviceId = prefs.getString('deviceId') ?? '';

          return StreamBuilder(
            stream: FirebaseDatabase.instance
                .ref()
                .child(deviceId)
                .child('user-theft')
                .onValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(
                  color: white,
                );
              } else if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data!.snapshot.value != null) {
                bool isSecurityMode = snapshot.data!.snapshot.value == 1;

                return Container(
                  height: 50,
                  width: size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: blue, width: 1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(14))),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: !isSecurityMode ? blue : Colors.transparent,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          child: Expanded(
                            child: text400normal(
                              text: "User Mode",
                              color: !isSecurityMode ? black : Colors.white,
                              fontsize: 16,
                              weight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSecurityMode ? blue : Colors.transparent,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(14),
                            ),
                          ),
                          child: Expanded(
                            child: text400normal(
                              text: "Security Mode",
                              color: !isSecurityMode ? Colors.white : black,
                              fontsize: 16,
                              weight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Text(
                    'No data available'); // Handle case where data isn't available
              }
            },
          );
        } else {
          return const Text('No SharedPreferences found');
        }
      },
    );
  }
}
