import 'package:blackanova/app/services/auth_service_blackanova.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthServiceBlackanova>();
    print('my isAuth value : ${authService.isAuth}');

    if (!authService.isAuth) {
      return const RouteSettings(name: Routes.LOGIN);
    }

    return null;
  }
}
