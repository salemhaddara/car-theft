import 'package:cartheftsafety/core/theme/Widgets/mySnackbar.dart';
import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeModeButton extends StatelessWidget {
  final Size size;

  const ChangeModeButton({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          SharedPreferences prefs = snapshot.data!;
          String? deviceId = prefs.getString('deviceId');

          if (deviceId != null) {
            return Padding(
              padding: const EdgeInsets.only(top: 30),
              child: StreamBuilder(
                stream: FirebaseDatabase.instance
                    .ref()
                    .child(deviceId)
                    .child('user-theft')
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    int? userTheftValue = snapshot.data?.snapshot.value as int;
                    return Container(
                      width: size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () {
                            userTheftValue = (userTheftValue == 0) ? 1 : 0;
                            FirebaseDatabase.instance
                                .ref()
                                .child(deviceId)
                                .update({'user-theft': userTheftValue}).then(
                                    (value) {
                              mySnackbar.showSnackbar(
                                  context, 'Mode Changing Success');
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SvgPicture.asset(
                                      'assets/images/change.svg'),
                                ),
                                const Expanded(
                                  child: Text(
                                    'Switch Current Mode',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    mySnackbar.showSnackbar(
                        context, 'Check Your Internet Connection');
                  } else {
                    return Container(
                      width: size.width,
                      height: 100,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(color: white),
                    );
                  }
                  return Container();
                },
              ),
            );
          } else {
            return const Text('Device ID not found in SharedPreferences');
          }
        } else {
          return const Text('Error retrieving SharedPreferences');
        }
      },
    );
  }
}
