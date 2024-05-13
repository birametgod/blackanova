import 'dart:async';

import 'package:blackanova/app/repositories/user_repository_blackanova.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/user_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service_blackanova.dart';
import '../../../services/firebase_messaging_service.dart';

class AuthController extends GetxController {
  final Rx<User> currentUser = Get.find<AuthServiceBlackanova>().user;
  late GlobalKey<FormState> loginFormKey;
  late GlobalKey<FormState> registerFormKey;
  late GlobalKey<FormState> forgotPasswordFormKey;
  final hidePassword = true.obs;
  final loading = false.obs;
  final smsSent = ''.obs;
  late UserRepositoryBlackanova _userRepository;

  AuthController() {
    loginFormKey = GlobalKey<FormState>();
    registerFormKey = GlobalKey<FormState>();
    forgotPasswordFormKey = GlobalKey<FormState>();
    _userRepository = UserRepositoryBlackanova();
  }

  void login() async {
    if ((loginFormKey.currentState != null) && (loginFormKey.currentState?.validate() ?? false)) {
      loginFormKey.currentState!.save();
      loading.value = true;
      try {
        currentUser.value = await _userRepository.login(currentUser.value);
        await Get.offAndToNamed(Routes.ROOT,);
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    }
  }

  void register() async {
    Get.focusScope?.unfocus();
    if (registerFormKey.currentState!.validate()) {
      registerFormKey.currentState!.save();
      loading.value = true;
      try {
          currentUser.value = await _userRepository.register(currentUser.value);
          loading.value = false;
          await Get.offAndToNamed(Routes.ROOT);
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    }
  }

  Future<void> verifyPhone() async {
    try {
      loading.value = true;
      await _userRepository.verifyPhone(smsSent.value);
      await Get.find<FireBaseMessagingService>().setDeviceToken();
      await _userRepository.signUpWithEmailAndPassword(currentUser.value.email, currentUser.value.apiToken);
      loading.value = false;
      await Get.toNamed(Routes.SALONS);
    } catch (e) {
      loading.value = false;
      Get.toNamed(Routes.REGISTER);
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      loading.value = false;
    }
  }

  Future<void> resendOTPCode() async {
    await _userRepository.sendCodeToPhone();
  }

  void sendResetLink() async {
    Get.focusScope?.unfocus();
    if (forgotPasswordFormKey.currentState!.validate()) {
      forgotPasswordFormKey.currentState!.save();
      loading.value = true;
      try {
        _userRepository.sendResetLinkEmail(currentUser.value);
        loading.value = false;
        Get.showSnackbar(Ui.SuccessSnackBar(message: "The Password reset link has been sent to your email: ".tr + currentUser.value.email));
        Timer(const Duration(seconds: 5), () {
          Get.offAndToNamed(Routes.LOGIN);
        });
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    }
  }
}
