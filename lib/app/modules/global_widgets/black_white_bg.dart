import 'package:blackanova/app/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlackWhiteBg extends StatelessWidget {
  final Widget element;
  final AppBar bar;

  BlackWhiteBg({Key? key, required this.element, required this.bar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = Get.find<SettingsService>().getThemeMode();
    return themeMode == ThemeMode.dark? Scaffold(
      backgroundColor: Colors.black,
      appBar: bar,
      body: element,
    ) : Scaffold(
      backgroundColor: Color(0xFFFFFEF2),
      appBar: bar,
      body: element,
    );
  }
}
