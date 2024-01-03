import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class text400normal extends StatelessWidget {
  final String text;
  final Color color;
  final double fontsize;
  final TextAlign? align;
  final TextDecoration? decoration;
  final FontWeight? weight;
  const text400normal(
      {super.key,
      required this.text,
      required this.color,
      required this.fontsize,
      this.decoration,
      this.weight,
      this.align});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align ?? TextAlign.start,
      style: GoogleFonts.nunitoSans(
          fontSize: fontsize,
          fontWeight: weight ?? FontWeight.w700,
          fontStyle: FontStyle.normal,
          decoration: decoration ?? TextDecoration.none,
          color: color),
    );
  }
}
