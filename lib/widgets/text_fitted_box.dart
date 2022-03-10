import 'package:flutter/material.dart';
import 'package:blackanova/widgets/google_font_one.dart';

class TextFittedBox extends StatelessWidget {

  TextFittedBox({ required this.text});

  final Widget text;


  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit:BoxFit.fitWidth,
      child: text,
    );
  }
}