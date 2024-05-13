import 'package:blackanova/all_imprts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/ui.dart';
import '../models/address_model.dart';
import '../models/setting_model.dart';

class SettingsService extends GetxService {

  final setting = Setting().obs;
  final address = Address().obs;
  late GetStorage _box;
  late ThemeMode _themeMode;



  SettingsService() {
    _box = GetStorage();
    _themeMode = ThemeMode.light;
  }

  Future<SettingsService> init() async {
    address.listen((Address address) {
      _box.write('current_address', address.toJson());
    });
    return this;
  }


  static Color parseColor(String? hexCode, {double? opacity}) {
    try {
      return Color(int.tryParse(hexCode!.replaceAll("#", "0xFF")) ?? 0).withOpacity(opacity ?? 1);
    } catch (e) {
      return Color(0xFFCCCCCC).withOpacity(opacity ?? 1);
    }
  }


  ThemeData getLightTheme() {
    // TODO change font dynamically
    return ThemeData(
        primaryColor: Colors.black,
        floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0, foregroundColor: Colors.white),
        brightness: Brightness.light,
        dividerColor: parseColor(setting.value.accentColor, opacity: 0.1),
        //focusColor: parseColor(setting.value.accentColor),
        focusColor: Colors.black,
        hintColor: Colors.black,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Ui.parseColor("setting.value.mainColor")),
        ),
        colorScheme: ColorScheme.light(
          primary: Ui.parseColor(setting.value.mainColor),
          secondary: Ui.parseColor(setting.value.mainColor),
        ),
        textTheme: GoogleFonts.getTextTheme(
          _getLocale().startsWith('ar') ? 'Cairo' : 'Poppins',
          TextTheme(
             titleLarge: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.black,)),
            //titleLarge: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: Ui.parseColor(setting.value.mainColor), height: 1.2),
            headlineSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: Ui.parseColor(setting.value.secondColor), height: 1.2),
            headlineMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: Ui.parseColor(setting.value.secondColor), height: 1.3),
            displaySmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: Ui.parseColor(setting.value.secondColor), height: 1.3),
            displayMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: Ui.parseColor(setting.value.mainColor), height: 1.4),
            displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w300, color: Ui.parseColor(setting.value.secondColor), height: 1.4),
            titleSmall: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: Ui.parseColor(setting.value.secondColor), height: 1.2),
            //titleMedium: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w400, color: Ui.parseColor(setting.value.mainColor), height: 1.2),
            titleMedium: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black,)),
            //bodyMedium: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: Ui.parseColor(setting.value.secondColor), height: 1.2),
            bodyMedium: GoogleFonts.poppins(textStyle:  TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: AppColors.blackanova.blackanovaGrey, height: 1.2)),
            bodyLarge: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w400, color: Colors.black, height: 1.2)),
            //bodyLarge: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: Ui.parseColor(setting.value.secondColor), height: 1.2),
            bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300, color: Ui.parseColor(setting.value.accentColor), height: 1.2),
          ),
        ));
  }

  ThemeData getDarkTheme() {
    // TODO change font dynamically
    return ThemeData(
        primaryColor:  Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0),
        scaffoldBackgroundColor: Color(0xFF2C2C2C),
        brightness: Brightness.dark,
        dividerColor: Ui.parseColor(setting.value.accentDarkColor, opacity: 0.1),
        focusColor: AppColors.blackanova.blackanovaTurquoiseSecond,
        hintColor: Colors.white,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Ui.parseColor(setting.value.mainColor)),
        ),
        colorScheme: ColorScheme.dark(
          primary: Ui.parseColor(setting.value.mainDarkColor),
          secondary:  AppColors.blackanova.blackanovaGrey,
        ),
        textTheme: GoogleFonts.getTextTheme(
            _getLocale().startsWith('ar') ? 'Cairo' : 'Poppins',
            TextTheme(
              titleLarge: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white,)),
              headlineSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: Ui.parseColor(setting.value.secondDarkColor), height: 1.2),
              headlineMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: Ui.parseColor(setting.value.secondDarkColor), height: 1.3),
              displaySmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: Ui.parseColor(setting.value.secondDarkColor), height: 1.3),
              displayMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: Ui.parseColor(setting.value.mainDarkColor), height: 1.4),
              displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w300, color: Ui.parseColor(setting.value.secondDarkColor), height: 1.4),
              titleSmall: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: Ui.parseColor(setting.value.secondDarkColor), height: 1.2),
              titleMedium: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white,)),
              bodyMedium: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: Colors.white, height: 1.2)),
              bodyLarge: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w400, color: Colors.white, height: 1.2)),
              bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300, color: Ui.parseColor(setting.value.accentDarkColor), height: 1.2),
            )));
  }

  String _getLocale() {
    String _locale = GetStorage().read<String>('language') ?? '';
    if (_locale.isEmpty) {
      _locale = setting.value.mobileLanguage ?? 'en';
    }
    return _locale;
  }

  // Add a method to the SettingsService class to toggle between light and dark themes
  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    Get.changeThemeMode(_themeMode); // Apply the new theme mode using GetX
  }

  ThemeMode getThemeMode() {
    String? _themeMode = GetStorage().read<String>('theme_mode') ?? '';
    switch (_themeMode) {
      case 'ThemeMode.light':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: Colors.white),
        );
        return ThemeMode.light;
      case 'ThemeMode.dark':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.dark.copyWith(systemNavigationBarColor: Colors.black87),
        );
        return ThemeMode.dark;
      case 'ThemeMode.system':
        return ThemeMode.system;
      default:
        if (setting.value.defaultTheme == "dark") {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.dark.copyWith(systemNavigationBarColor: Colors.black87),
          );
          return ThemeMode.dark;
        } else {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: Colors.white),
          );
          return ThemeMode.light;
        }
    }
  }
}
