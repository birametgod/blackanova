import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blackanova/app/services/settings_service.dart'; // Ensure this import is correct based on your project structure

class VectorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = Get.find<SettingsService>().getThemeMode();

    // Define colors for light and dark themes
    List<Color> gradient1 = themeMode == ThemeMode.dark
        ? [Color(0xFF8F65F4), Color(0xFF5F53F7)]
        : [Color(0xFFE66D38), Color(0xFFE95919)];
    Color color1 = themeMode == ThemeMode.dark ? Color(0xFF1E232D) : Color(0xFFA2BAA2);
    Color color2 = themeMode == ThemeMode.dark ? Color(0xFF22A6B6) : Color(0xFFAFB19B);
    List<Color> gradient2 = themeMode == ThemeMode.dark
        ? [Color(0xFFF9814E), Color(0xFFF3804E)]
        : [Color(0xFFF58351), Color(0xFFED7745)];
    Color color3 = themeMode == ThemeMode.dark ? Color(0xFF9AC3C6) : Color(0xFFA2BAA2);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: MediaQuery.of(context).size.width * 0.5109,
            top: MediaQuery.of(context).size.height * 0.1893,
            child: Transform(
              transform: Matrix4(0.03, -1, 0, 0, 1, 0.03, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1),
              child: Container(
                width: MediaQuery.of(context).size.width * (1 - 0.3136 - 0.5109),
                height: MediaQuery.of(context).size.height * (1 - 0.1893 - 0.6723),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradient1,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 265.07,
            top: 78.64,
            child: Transform(
              transform: Matrix4(0.03, 1, 0, 0, -1, 0.03, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1),
              child: Container(
                width: 115.45,
                height: 92.73,
                color: color1,
              ),
            ),
          ),
          Positioned(
            left: 139.7,
            top: 251.37,
            child: Transform(
              transform: Matrix4(-0.84, -0.55, 0, 0, 0.55, -0.84, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1),
              child: Container(
                width: 73.22,
                height: 76.39,
                color: color2,
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.6868,
            top: MediaQuery.of(context).size.height * 1.6613,
            child: Transform(
              transform: Matrix4(-0.54, -0.84, 0, 0, 0.85, -0.53, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: gradient2,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.1802,
            top: MediaQuery.of(context).size.height * 0.4487,
            child: Transform(
              transform: Matrix4(0.96, -0.29, 0, 0, 0.29, 0.96, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1),
              child: Container(
                width: 100,
                height: 100,
                color: color3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}