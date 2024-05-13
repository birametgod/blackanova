/*
 * File name: login_view.dart
 * Last modified: 2023.02.09 at 15:50:05
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2023
 */

import 'package:blackanova/app/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../../../models/setting_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/background.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  final Setting _settings = Get.find<SettingsService>().setting.value;

  @override
  Widget build(BuildContext context) {
    controller.loginFormKey = new GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Background(
          element: SafeArea(
            child: Form(
              key: controller.loginFormKey,
              child: ListView(
                primary: true,
                children: [
                  Obx(() {
                    if (controller.loading.isTrue) {
                      return CircularLoadingWidget(height: 300);
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Welcome back!",
                              style: Get.textTheme.titleLarge,
                            ),
                            Text(
                              "We missed you ... ",
                              style: Get.textTheme.titleMedium,
                            ),

                            const SizedBox(
                              height: 60,
                            ),
                            TextFieldWidget(
                              labelText: "Email Address".tr,
                              hintText: "johndoe@gmail.com".tr,
                              initialValue: controller.currentUser.value.email,
                              onSaved: (input) => controller.currentUser.value.email = input,
                              validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                              iconData: Icons.alternate_email,
                            ),
                            Obx(() {
                              return TextFieldWidget(
                                labelText: "Password".tr,
                                hintText: "••••••••••••".tr,
                                initialValue: controller.currentUser.value.password ?? '',
                                onSaved: (input) => controller.currentUser.value.password = input,
                                validator: (input) => input!.length < 3 ? "Should be more than 3 characters".tr : null,
                                obscureText: controller.hidePassword.value,
                                iconData: Icons.lock_outline,
                                keyboardType: TextInputType.visiblePassword,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.hidePassword.value = !controller.hidePassword.value;
                                  },
                                  color: Theme.of(context).focusColor,
                                  icon: Icon(controller.hidePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                ),
                              );
                            }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.FORGOT_PASSWORD);
                                  },
                                  child: Text("Forgot Password?".tr),
                                ),
                              ],
                            ).paddingSymmetric(horizontal: 20),
                            BlockButtonWidget(
                              onPressed: () {
                                controller.login();
                              },
                              color: Get.theme.colorScheme.secondary,
                              text: Text(
                                "Login".tr,
                                style: Get.textTheme.titleLarge?.merge(TextStyle(color: Get.theme.primaryColor)),
                              ),
                            ).paddingSymmetric(vertical: 10, horizontal: 20),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.REGISTER);
                              },
                              child: Text("You don't have an account?".tr),
                            ).paddingOnly(top: 20),
                            const SizedBox(
                              height: 15,
                            ),
                            BottomBar(
                              parentContext: context,
                            )
                          ],
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
