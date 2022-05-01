import 'package:flutter/cupertino.dart';

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

