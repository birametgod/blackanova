import 'package:blackanova/app/services/auth_service_blackanova.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../services/auth_service.dart';

class SalonOwnerMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthServiceBlackanova>();
    if (!authService.user.value.isSalonOwner) {
      return RouteSettings(name: Routes.SALONS);
    }
    return null;
  }
}
