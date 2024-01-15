// ignore_for_file: must_be_immutable, camel_case_types

import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class logoutContainer extends StatelessWidget {
  Size size;
  Function onTap;
  logoutContainer({super.key, required this.onTap, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: size.width,
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
          color: blue,
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          )),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        onTap: () {
          onTap();
        },
        child: Row(
          children: [
            Expanded(child: SvgPicture.asset('assets/images/logout.svg')),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: const text400normal(
                      text: 'Sign Out',
                      color: Colors.black,
                      fontsize: 20,
                      weight: FontWeight.w500,
                    ))),
          ],
        ),
      ),
    );
  }
}
