// ignore_for_file: camel_case_types,file_names, use_build_context_synchronously

import 'dart:io';

import 'package:cartheftsafety/core/theme/Widgets/MyNavigationBar.dart';
import 'package:cartheftsafety/core/theme/Widgets/mySnackbar.dart';
import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class alertScreen extends StatefulWidget {
  const alertScreen({super.key});

  @override
  State<alertScreen> createState() => _alertScreenState();
}

class _alertScreenState extends State<alertScreen> {
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        shadowColor: black,
        centerTitle: true,
        elevation: 0,
        leading: Container(),
        title: text400normal(
            text: '',
            color: blue,
            weight: FontWeight.w700,
            fontsize: size.width * 0.05),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: black,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                child: const text400normal(
                    text: 'An Unknown Action Detected In Your Car',
                    color: Colors.red,
                    align: TextAlign.center,
                    weight: FontWeight.w300,
                    fontsize: 25)),
            Lottie.asset('assets/animation/alert.json',
                height: 250, width: 250),
            Container(
              height: 120,
              width: double.infinity,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                children: [
                  InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                    onTap: () async {
                      //Stop The Engine Here
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      try {
                        FirebaseDatabase.instance
                            .ref()
                            .child((prefs.getString('deviceId')) ?? '')
                            .update({'engine-on': 0}).then((value) {
                          mySnackbar.showSnackbar(
                              context, 'Engine Desabled Success');
                        });
                        await Future.delayed(const Duration(seconds: 3), () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyNavigationBar(
                                index: 1,
                              ),
                            ),
                          );
                        });
                      } on SocketException {
                        mySnackbar.showSnackbar(
                            context, 'Check Your Internet Connection');
                      } catch (e) {
                        mySnackbar.showSnackbar(context, 'Unknown Error');
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/engine.svg',
                            height: 42,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const text400normal(
                              text: 'Stop Engine',
                              color: Colors.white,
                              fontsize: 18),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                    onTap: () {
                      //Track the car go to the map Widget
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyNavigationBar(
                            index: 1,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.all(5),
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/gps.svg',
                            height: 42,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const text400normal(
                              text: 'Track My Car',
                              color: Colors.green,
                              align: TextAlign.center,
                              fontsize: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
