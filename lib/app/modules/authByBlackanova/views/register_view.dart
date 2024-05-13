import 'package:blackanova/app/modules/authByBlackanova/widgets/bottom_bar.dart';
import 'package:blackanova/app/modules/global_widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../../../models/setting_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/phone_field_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../../root/controllers/root_controller.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  final Setting _settings = Get.find<SettingsService>().setting.value;

  @override
  Widget build(BuildContext context) {
    controller.registerFormKey = new GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Background(
          element: SafeArea(
            child: Form(
              key: controller.registerFormKey,
              child: ListView(
                primary: true,
                children: [
                  Obx(() {
                    if (controller.loading.isTrue) {
                      return CircularLoadingWidget(height: 300);
                    } else {
                      print(controller.currentUser.value);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Register",
                              style: Get.textTheme.titleLarge,
                            ),
                            Text(
                              "Create new account to get started.",
                              style: Get.textTheme.titleMedium,
                            ),
                            TextFieldWidget(
                              labelText: "Full Name",
                              hintText: "John Doe",
                              initialValue: controller.currentUser.value.name,
                              onSaved: (input) => controller.currentUser.value.name = input,
                              validator: (input) => input!.length < 3 ? "Should be more than 3 characters".tr : null,
                              iconData: Icons.person_outline,
                              isFirst: true,
                              isLast: false,
                            ),
                            TextFieldWidget(
                              labelText: "Email Address".tr,
                              hintText: "johndoe@gmail.com".tr,
                              initialValue: controller.currentUser.value.email,
                              onSaved: (input) => controller.currentUser.value.email = input,
                              validator: (input) => !input!.contains('@') ? "Should be a valid email".tr : null,
                              iconData: Icons.alternate_email,
                              isFirst: false,
                              isLast: false,
                            ),
                            PhoneFieldWidget(
                              labelText: "Phone Number".tr,
                              hintText: "223 665 7896".tr,
                              initialCountryCode: '',
                              initialValue: '',
                              onSaved: (phone) {
                                 controller.currentUser.value.phoneNumber = phone!.completeNumber;
                              },
                              isLast: false,
                              isFirst: false,
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
                                isLast: true,
                                isFirst: false,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.hidePassword.value = !controller.hidePassword.value;
                                  },
                                  color: Theme.of(context).focusColor,
                                  icon: Icon(controller.hidePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                ),
                              );
                            }),
                            SizedBox(
                              width: Get.width,
                              child: BlockButtonWidget(
                                onPressed: () {
                                  controller.register();
                                },
                                color: Get.theme.colorScheme.secondary,
                                text: Text(
                                  "Register".tr,
                                  style: Get.textTheme.titleLarge?.merge(TextStyle(color: Get.theme.primaryColor)),
                                ),
                              ).paddingOnly(top: 15, bottom: 5, right: 20, left: 20),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.LOGIN);
                              },
                              child: Text("You already have an account?".tr),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            BottomBar(parentContext: context,),
                          ],
                        ),
                      );
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
