import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blackanova/constants.dart';

class GoogleFontOne extends StatelessWidget {

  const GoogleFontOne({
    required this.textValue,
    required this.size,
    this.spacing,
    this.weight,
    this.height}) ;

  final String textValue;
  final double size;
  final double? spacing;
  final FontWeight? weight;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      style: GoogleFonts.poppins(
          color: gradientEnd,
          fontSize: size,
          fontWeight: weight,
          letterSpacing: spacing,
          height: height
      ),
    );
  }
}