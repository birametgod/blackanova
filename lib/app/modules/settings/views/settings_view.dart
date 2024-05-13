/*
 * File name: settings_view.dart
 * Last modified: 2023.02.09 at 15:49:28
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2023
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../global_widgets/tab_bar_widget.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  final _navigatorKey = Get.nestedKey(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Settings".tr,
            style: context.textTheme.titleLarge,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading:  IconButton(
            icon:  Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
            onPressed: () => Get.back(),
          ),
          elevation: 0,
          bottom: TabBarWidget(
            initialSelectedId: 0,
            tag: 'settings',
            tabs: [
              ChipWidget(
                tag: 'settings',
                text: "Profile".tr,
                id: 0,
                onSelected: (id) {
                  controller.changePage(id);
                },
              ),
              ChipWidget(
                tag: 'settings',
                text: "Languages".tr,
                id: 1,
                onSelected: (id) {
                  controller.changePage(id);
                },
              ),
              ChipWidget(
                tag: 'settings',
                text: "Theme Mode".tr,
                id: 2,
                onSelected: (id) {
                  controller.changePage(id);
                },
              )
            ],
          )),
      body: WillPopScope(
        onWillPop: () async {
          if (_navigatorKey!.currentState!.canPop()) {
            _navigatorKey!.currentState!.pop();
            return false;
          }
          return true;
        },
        child: Navigator(
          key: _navigatorKey,
          initialRoute: Routes.PROFILE,
          onGenerateRoute: controller.onGenerateRoute,
        ),
      ),
    );
  }
}
