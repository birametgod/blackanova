import 'package:blackanova/all_imprts.dart';
import 'package:flutter/material.dart';

class AppDecorations {
  static OnBoarding onBoarding = OnBoarding();
}

class OnBoarding {
  BoxDecoration onBoardingDecoration = BoxDecoration(
      color: AppColors.blackanova.background,
      border: Border.all(
        width: 0.0,
        color: AppColors.blackanova.background,
      ));
}