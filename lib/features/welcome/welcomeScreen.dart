// ignore_for_file: camel_case_types,file_names

import 'package:cartheftsafety/core/theme/Widgets/mySnackbar.dart';
import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:cartheftsafety/features/login/loginScreen.dart';
import 'package:cartheftsafety/features/signup/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/notificationsService.dart';

class welcomeScreen extends StatefulWidget {
  const welcomeScreen({super.key});

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  late Size size;
  String? token;

  @override
  void initState() {
    super.initState();
    _setupFirebaseMessaging();
  }

  _setupFirebaseMessaging() async {
    NotificationService service = NotificationService();
    service.initializeFirebaseApp(context);
    service.requestNotificationPermission();
    service.getDeviceToken().then((value) => token = value);
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: black,
      statusBarIconBrightness: Brightness.light,
    ));
    size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: black,
        body: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: (size.height),
              width: (size.width),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(0),
              child: Image.asset(
                'assets/images/car.jpg',
                fit: BoxFit.cover,
                height: size.height,
                width: size.width,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: size.height / 3,
              width: size.width,
              child: Image.asset(
                'assets/images/logotransparent.png',
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: (size.height) / 4,
              width: (size.width),
              alignment: Alignment.center,
              child: Column(
                children: [
                  InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    onTap: () {
                      //navigate user to sign up
                      if (token != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const SignUpScreen();
                            },
                            settings: RouteSettings(arguments: token)));
                      } else {
                        mySnackbar.showSnackbar(
                            context, 'Check Your Internet Connection');
                      }
                    },
                    child: Container(
                      width: 250,
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: text400normal(
                          text: 'Create an Account',
                          color: blue,
                          align: TextAlign.center,
                          weight: FontWeight.w400,
                          fontsize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    onTap: () {
                      //navigate user to login screen
                      if (token != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const loginScreen();
                            },
                            settings: RouteSettings(arguments: token)));
                      } else {
                        mySnackbar.showSnackbar(
                            context, 'Check Your Internet Connection ');
                      }
                    },
                    child: Container(
                      width: 250,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                          color: blue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7))),
                      child: text400normal(
                        text: 'Sign in',
                        color: black,
                        weight: FontWeight.w400,
                        fontsize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
