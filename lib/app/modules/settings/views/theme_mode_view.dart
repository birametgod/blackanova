/*
 * File name: theme_mode_view.dart
 * Last modified: 2023.02.09 at 15:51:14
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2023
 */

import 'package:blackanova/app/modules/global_widgets/background.dart';
import 'package:blackanova/app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../controllers/theme_mode_controller.dart';

class ThemeModeView extends GetView<ThemeModeController> {
  final bool hideAppBar;

  ThemeModeView({this.hideAppBar = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Background(
          element: SafeArea(
            child: ListView(
              primary: true,
              children: [
                AppBar(
                  title: Text(
                    "Theme Mode".tr,
                    style: context.textTheme.titleLarge,
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
                    onPressed: () => Get.back(),
                  ),
                  elevation: 0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      RadioListTile(
                        value: ThemeMode.light,
                        groupValue: controller.selectedThemeMode.value,
                        activeColor: Get.theme.colorScheme.secondary,
                        onChanged: (value) {
                          debugPrint("$value");
                          controller.changeThemeMode(value!);
                        },
                        title: Text("Light Theme".tr, style: Get.textTheme.bodyMedium),
                      ),
                      RadioListTile(
                        value: ThemeMode.dark,
                        groupValue: controller.selectedThemeMode.value,
                        activeColor: Get.theme.colorScheme.secondary,
                        onChanged: (value) {
                          controller.changeThemeMode(value!);
                        },
                        title: Text("Dark Theme".tr, style: Get.textTheme.bodyMedium),
                      ),
                      RadioListTile(
                        value: ThemeMode.system,
                        groupValue: controller.selectedThemeMode.value,
                        activeColor: Get.theme.colorScheme.secondary,
                        onChanged: (value) {
                          controller.changeThemeMode(value!);
                        },
                        title: Text("System Theme".tr, style: Get.textTheme.bodyMedium),
                      ),
                      /*GestureDetector(
                        onTap: () {
                          Get.find<AuthService>().removeCurrentUser();
                        },
                        child: Text(
                          'Sign Out',
                          style: TextStyle(
                            color: Colors.red
                          ),
                        ),
                      )*/
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
