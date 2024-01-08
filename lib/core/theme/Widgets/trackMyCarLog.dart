// ignore_for_file: must_be_immutable, camel_case_types, file_names

import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class trackMyCarLog extends StatelessWidget {
  Size size;
  Function onTap;
  trackMyCarLog({super.key, required this.size, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: size.width,
      margin: const EdgeInsets.only(top: 30),
      decoration: const BoxDecoration(
          color: Color.fromARGB(50, 255, 255, 255),
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          )),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        onTap: () {
          onTap();
        },
        child: Row(
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SvgPicture.asset('assets/images/logswhite.svg'))),
            const Expanded(
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        text400normal(
                          text: 'Recents Location ',
                          color: Colors.white,
                          fontsize: 16,
                          weight: FontWeight.w500,
                        ),
                        text400normal(
                          text: 'Your Last Locations visited are saved daily ',
                          color: Colors.white,
                          fontsize: 13,
                          align: TextAlign.center,
                          weight: FontWeight.w400,
                        ),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
