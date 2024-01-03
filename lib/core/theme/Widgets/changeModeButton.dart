// ignore_for_file: camel_case_types,file_names, must_be_immutable

import 'package:cartheftsafety/core/theme/Widgets/text400normal.dart';
import 'package:cartheftsafety/core/theme/colors/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class changeModeButton extends StatelessWidget {
  Size size;
  changeModeButton({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: InkWell(
        onTap: () {},
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          child: Container(
            width: size.width,
            height: 70,
            decoration: BoxDecoration(
              color: white,
              borderRadius: const BorderRadius.all(Radius.circular(14)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: SvgPicture.asset('assets/images/change.svg'),
                ),
                Expanded(
                    child: text400normal(
                        text: 'Switch Current Mode',
                        color: black,
                        fontsize: 18))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
