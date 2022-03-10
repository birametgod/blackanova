import 'dart:ui';
import 'package:flutter/material.dart';

class ButtonRadius extends StatelessWidget {

  ButtonRadius({ required this.colorShadowBox, required this.colorDecorationBox, required this.element });

  final Color colorShadowBox;
  final Color colorDecorationBox;
  final Widget element;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 30, vertical: 10),
          decoration: BoxDecoration(
            color: colorDecorationBox,
            borderRadius:
            BorderRadius.all(Radius.circular(30.0)),
            boxShadow: [
              new BoxShadow(
                color: colorShadowBox,
                offset: new Offset(0.0, 6.0),
              )
            ],
          ),
          child: element
      ),
    );
  }
}