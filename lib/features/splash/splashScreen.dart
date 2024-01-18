// ignore_for_file: camel_case_types,file_names

import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:cartheftsafety/features/welcome/welcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  _navigate() async {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const welcomeScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: black,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      backgroundColor: black,
      body: Stack(
        children: [
          Align(
            child: Container(
              alignment: Alignment.center,
              child: Image.asset('assets/images/logotransparent.png'),
            ),
          ),
        ],
      ),
    );
  }
}
