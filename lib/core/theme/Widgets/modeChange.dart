// ignore_for_file: file_names

import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          return const CircularProgressIndicator(); // Loading indicator while fetching data
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

                return SizedBox(
                  height: 120,
                  width: size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: !isSecurityMode
                                ? const Color.fromARGB(50, 255, 255, 255)
                                : Colors.transparent,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(18),
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: SvgPicture.asset(
                                  'assets/images/driver.svg',
                                ),
                              ),
                              const SizedBox(height: 5),
                              Expanded(
                                child: text400normal(
                                  text: "User Mode",
                                  color: white,
                                  fontsize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSecurityMode
                                ? const Color.fromARGB(50, 255, 255, 255)
                                : Colors.transparent,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(18),
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: SvgPicture.asset(
                                  'assets/images/security.svg',
                                ),
                              ),
                              const SizedBox(height: 5),
                              Expanded(
                                child: text400normal(
                                  text: "Security Mode",
                                  color: white,
                                  fontsize: 16,
                                ),
                              ),
                            ],
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
