/*
 * File name: forgot_password_view.dart
 * Last modified: 2023.02.09 at 15:50:05
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2023
 */

import 'package:blackanova/app/modules/global_widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/setting_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/auth_controller.dart';

class ForgotPasswordView extends GetView<AuthController> {
  final Setting _settings = Get.find<SettingsService>().setting.value;

  @override
  Widget build(BuildContext context) {
    controller.forgotPasswordFormKey = new GlobalKey<FormState>();
    return Scaffold(
        body: Background(
          element: Form(
            key: controller.forgotPasswordFormKey,
            child: ListView(
              primary: true,
              children: [
                Obx(() {
                  if (controller.loading.isTrue)
                    return CircularLoadingWidget(height: 300);
                  else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Forgot Password".tr,
                            style: Get.textTheme.titleLarge?.merge(TextStyle(color: context.theme.primaryColor)),
                          ),
                          TextFieldWidget(
                            labelText: "Email Address".tr,
                            hintText: "johndoe@gmail.com".tr,
                            initialValue: controller.currentUser.value.email,
                            onSaved: (input) => controller.currentUser.value.email = input,
                            validator: (input) => !GetUtils.isEmail(input!) ? "Should be a valid email".tr : null,
                            iconData: Icons.alternate_email,
                          ),
                          BlockButtonWidget(
                            onPressed: controller.sendResetLink,
                            color: Get.theme.colorScheme.secondary,
                            text: Text(
                              "Send Reset Link".tr,
                              style: Get.textTheme.titleLarge?.merge(TextStyle(color: Get.theme.primaryColor)),
                            ),
                          ).paddingSymmetric(vertical: 35, horizontal: 20),
                          TextButton(
                            onPressed: () {
                              Get.offAllNamed(Routes.REGISTER);
                            },
                            child: Text("You don't have an account?".tr),
                          ),
                        ],
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ));
  }
}
