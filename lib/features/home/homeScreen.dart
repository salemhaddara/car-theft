// ignore_for_file: camel_case_types, file_names

import 'package:cartheftsafety/core/theme/Widgets/changeModeButton.dart';
import 'package:cartheftsafety/core/theme/Widgets/connectionStatus.dart';
import 'package:cartheftsafety/core/theme/Widgets/modeChange.dart';
import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
import 'package:cartheftsafety/core/theme/Widgets/trackMyCarLog.dart';
import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
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
            text: 'Car Control',
            color: white,
            weight: FontWeight.w700,
            fontsize: size.width * 0.05),
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  connectionStatus(size: size, status: 'Connected'),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: text400normal(
                        text: 'Change Safety Mode', color: white, fontsize: 16),
                  ),
                  modechange(
                    size: size,
                  ),
                  ChangeModeButton(size: size),
                  trackMyCarLog(
                      size: size,
                      onTap: () {
                        print('object');
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
