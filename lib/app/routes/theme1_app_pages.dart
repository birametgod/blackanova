import 'package:blackanova/app/middlewares/auth_middleware.dart';
import 'package:blackanova/app/middlewares/salon_owner_middleware.dart';
import 'package:blackanova/app/modules/authByBlackanova/bindings/auth_binding.dart';
import 'package:blackanova/app/modules/authByBlackanova/views/login_view.dart';
import 'package:blackanova/app/modules/authByBlackanova/views/register_view.dart';
import 'package:blackanova/app/modules/authByBlackanova/views/phone_verification_view.dart';
import 'package:blackanova/app/modules/root/bindings/root_binding.dart';
import 'package:blackanova/app/modules/root/views/root_view.dart';
import 'package:get/get.dart';
import '../modules/authByBlackanova/views/forgot_password_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/settings/views/theme_mode_view.dart';
import '../services/auth_service.dart';
import 'app_routes.dart';

class Theme1AppPages {
  static final INITIAL = Get.find<AuthService>().user.value.auth! ? Routes.ROOT : Routes.LOGIN;

  static final routes = [
    GetPage(name: Routes.SETTINGS, page: () => SettingsView(), binding: SettingsBinding()),
    GetPage(name: Routes.SETTINGS_THEME_MODE, page: () => ThemeModeView(), binding: SettingsBinding()),
    GetPage(name: Routes.ROOT, page: () => const RootView(), binding: RootBinding(), middlewares: [AuthMiddleware()] ),
    //GetPage(name: Routes.LOGIN, page: () => LoginView(), binding: AuthBinding()),
    GetPage(name: Routes.LOGIN, page: () => LoginView(), binding: AuthBinding()),
    GetPage(name: Routes.REGISTER, page: () => RegisterView(), binding: AuthBinding()),
    GetPage(name: Routes.PHONE_VERIFICATION, page: () => PhoneVerificationView(), binding: AuthBinding()),
    GetPage(name: Routes.FORGOT_PASSWORD, page: () => ForgotPasswordView(), binding: AuthBinding()),


  ];
}
