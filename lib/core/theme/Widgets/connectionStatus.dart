// ignore_for_file: camel_case_types, file_names, must_be_immutable

import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class connectionStatus extends StatelessWidget {
  Size size;
  String status;
  connectionStatus({
    super.key,
    required this.size,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: size.width,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: Color.fromARGB(50, 255, 255, 255),
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          )),
      child: Row(
        children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SvgPicture.asset('assets/images/carConnected.svg'))),
          Expanded(
              child: Column(
            children: [
              text400normal(
                  text: status,
                  color: Colors.white,
                  fontsize: size.width * 0.04),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: text400normal(
                      text:
                          'Your Appereil is Already Connected with Your Device all Features Are enabled',
                      color: Colors.white,
                      align: TextAlign.center,
                      fontsize: size.width * 0.03))
            ],
          ))
        ],
      ),
    );
  }
}
