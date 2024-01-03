// ignore_for_file: must_be_immutable, camel_case_types, file_names

import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class modechange extends StatelessWidget {
  Size size;
  modechange({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: size.width,
      decoration: const BoxDecoration(
          color: Color.fromARGB(50, 255, 255, 255),
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          )),
      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: SvgPicture.asset('assets/images/driver.svg')),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: text400normal(
                        text: "User Mode", color: white, fontsize: 16)),
              ],
            ),
          )),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: Color.fromARGB(50, 255, 255, 255),
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                )),
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: SvgPicture.asset('assets/images/security.svg')),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: text400normal(
                        text: "Security Mode", color: white, fontsize: 16)),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
