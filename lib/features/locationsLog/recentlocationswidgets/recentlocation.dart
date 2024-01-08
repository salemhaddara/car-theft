// ignore_for_file: camel_case_types

import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class recentLocation extends StatelessWidget {
  Size size;
  LatLng position;
  String time;
  Function onTap;
  recentLocation(
      {super.key,
      required this.size,
      required this.position,
      required this.time,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
                    child: SvgPicture.asset('assets/images/carlocation.svg'))),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const text400normal(
                          text: 'Tap For show the place',
                          color: Colors.white,
                          fontsize: 14,
                          weight: FontWeight.w500,
                        ),
                        const Spacer(),
                        text400normal(
                          text: time,
                          color: Colors.white,
                          fontsize: 12,
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
