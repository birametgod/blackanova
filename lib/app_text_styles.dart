import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static BlackanovaStyles blackanova = BlackanovaStyles();
  static Title title = Title();
}

class Title {
  TextStyle headTitle = const TextStyle(
    color: Colors.white,
    fontSize: 34,
    fontWeight: FontWeight.bold,
  );

  TextStyle bottomTitle = const TextStyle(
    color: Colors.grey,
    fontSize: 15,
  );

  TextStyle nameButtonTitle = const TextStyle(
    color: Colors.black87,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  TextStyle subTitle = const TextStyle(
      fontSize: 28, fontWeight: FontWeight.w500, color: Colors.white);
}

class BlackanovaStyles {
  TextStyle poppinsFieldTitle = GoogleFonts.poppins(
      textStyle: const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ));

  TextStyle poppinsSubTitle = GoogleFonts.poppins(
      textStyle: const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ));

  TextStyle poppinsTitleForCard = GoogleFonts.poppins(
      textStyle: const TextStyle(
        color:  Color(0xFFFFFFFF), // Equivalent to --white-100 in CSS
        fontFamily: 'Poppins',
        fontSize: 16.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        height: 1.33, // Equivalent to line-height 16px / font-size 12px
      ));

  TextStyle poppinsForButtonCard = GoogleFonts.poppins(
    textStyle: const TextStyle(
      color:  Color(0xFFFFFFFF), // Equivalent to --white-100 in CSS
      fontFamily: 'Poppins',
      fontSize: 16.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      height: 1.33, // Equivalent to line-height 16px / font-size 12px
    ));

  TextStyle poppinsForDescriptionCard = GoogleFonts.poppins(
      textStyle: const TextStyle(
        color:  Color(0xFFFFFFFF), // Equivalent to --white-100 in CSS
        fontFamily: 'Poppins',
        fontSize: 14.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w300,
        height: 1.0, // Equivalent to line-height 16px / font-size 12px
      ));

  TextStyle alegreyaSubTitleForAlertDialog = GoogleFonts.poppins(
      textStyle: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ));

  TextStyle regularPoppins = GoogleFonts.poppins(
      textStyle: const TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ));

  TextStyle poppinsTitle = GoogleFonts.poppins(
      textStyle: const TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ));

  TextStyle alegreyaTitleButton = GoogleFonts.poppins(
      textStyle: const TextStyle(
        fontSize: 25.0,
        wordSpacing: 1,
        letterSpacing: 1.2,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ));


  TextStyle alegreya = GoogleFonts.poppins(
      textStyle: const TextStyle(
    fontSize: 25.0,
    wordSpacing: 1,
    letterSpacing: 1.2,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ));

  TextStyle poppinsDescription = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 14.0,
      color: Colors.white,
    ),
  );
}
