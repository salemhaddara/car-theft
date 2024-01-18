// ignore_for_file: camel_case_types, file_names

import 'package:cartheftsafety/core/theme/Widgets/changeModeButton.dart';
import 'package:cartheftsafety/core/theme/Widgets/modeChange.dart';
import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
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
  void initState() {
    super.initState();
  }

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
            text: 'CAR CONTROL',
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
            Expanded(child: Image.asset('assets/images/carback.png')),
            modechange(
              size: size,
            ),
            ChangeModeButton(size: size),
          ],
        ),
      ),
    );
  }
}
