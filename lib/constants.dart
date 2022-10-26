import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Color gradientZero = const Color(0xFF8A4F19);
Color gradientFirst = const Color(0xFFAA5401);
Color gradientSecond = const Color(0xFFBD702B);
Color gradientThird = const Color(0xFFD1C9C1);
Color gradientFourth = const  Color(0xFFF4EEEB);
Color gradientEnd =  const Color(0xFFF0F1F5);
Color facebookColor = const Color(0xFF3b5998);
Color facebookColorLight =  const Color(0xFF526898);

BoxDecoration homeBodyDecoration = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          gradientFirst,
          gradientSecond,
          gradientThird,
          gradientFourth,
          gradientEnd
        ])
);

BoxDecoration identificationBodyDecoration = const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFF646464),
        Color(0xFF717271),
        Color(0xFF737473),
        Color(0xFFA2A5A2),
        Color(0xFFE7E7E7),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      //stops: [0.1, 0.3, 0.5, 0.7, 0.9],
    ));


// Repeated code for TextField in login section
const kTextFiledInputDecoration = InputDecoration(
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 2),
  ),
  labelText: " Email address",
  labelStyle:
  TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400),
);

//constants for new login page
// Colors
const kBackgroundColor = Color(0xff191720);
const kTextFieldFill = Color(0xff1E1C24);
// TextStyles
const kHeadline = TextStyle(
  color: Colors.white,
  fontSize: 34,
  fontWeight: FontWeight.bold,
);

const kBodyText = TextStyle(
  color: Colors.grey,
  fontSize: 15,
);

const kButtonText = TextStyle(
  color: Colors.black87,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const kBodyText2 = TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Colors.white);
