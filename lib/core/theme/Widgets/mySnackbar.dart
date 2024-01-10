// ignore_for_file: file_names, camel_case_types

import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:flutter/material.dart';

class mySnackbar {
  static showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(formSnackbar(text, MediaQuery.of(context).size));
  }

  static SnackBar formSnackbar(String text, Size size) {
    return SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          width: size.width,
          constraints: const BoxConstraints(maxHeight: 100, minHeight: 50),
          decoration: const BoxDecoration(
              color: Color.fromARGB(99, 0, 0, 0),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: text400normal(
              text: text,
              align: TextAlign.center,
              color: blue,
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
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.white),
            )
          ]),
        ));
  }
}
