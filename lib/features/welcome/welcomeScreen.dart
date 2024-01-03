// ignore_for_file: camel_case_types,file_names

import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:cartheftsafety/features/login/loginScreen.dart';
import 'package:flutter/material.dart';

class welcomeScreen extends StatefulWidget {
  const welcomeScreen({super.key});

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: black,
      body: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: (size.height) / 2,
            width: (size.width),
            alignment: Alignment.center,
            child: Image.asset('assets/images/car.jpg'),
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
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const loginScreen();
                    }));
                  },
                  child: const text400normal(
                    text: 'Sign in',
                    color: Colors.white,
                    fontsize: 20,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    //navigate to sign up
                  },
                  child: const text400normal(
                      text: 'Create an Account',
                      color: Colors.white,
                      fontsize: 20),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
