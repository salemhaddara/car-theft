// ignore_for_file: file_names

import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:flutter/material.dart';

SnackBar showSnackbar(String text, Size size) {
  return SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        constraints:
            const BoxConstraints(maxHeight: 100, minHeight: 50, maxWidth: 500),
        decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.all(Radius.circular(25))),
        alignment: Alignment.center,
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: text400normal(
            text: text,
            align: TextAlign.center,
            color: white,
            fontsize: 16,
          )),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 150,
            height: 5,
            margin: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                color: black),
          )
        ]),
      ));
}
