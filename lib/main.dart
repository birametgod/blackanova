import 'package:blackanova/all_imprts.dart';
import 'package:blackanova/app/modules/root/controllers/root_controller.dart';
import 'package:blackanova/app/providers/firebase_api_provider.dart';
import 'package:blackanova/app/providers/firebase_provider.dart';
import 'package:blackanova/app/routes/theme1_app_pages.dart';
import 'package:blackanova/app/services/auth_service_blackanova.dart';
import 'package:blackanova/app/services/global_service.dart';
import 'package:get_storage/get_storage.dart';
import 'app/services/auth_service.dart';
import 'app/providers/base_model.dart';
import 'app/providers/hairdresser_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'app/services/settings_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Get.putAsync(() => GlobalService().init());
  await Firebase.initializeApp();
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => FirebaseProvider().init());
  await Get.putAsync(() => AuthServiceBlackanova().init());
  await Get.putAsync(() => SettingsService().init());
  await Get.putAsync(() => FirebaseApiClient().init());


  runApp(
      const MyApp()
  );
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RootController());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => BaseModel()),
          ChangeNotifierProvider(create: (context) => HairdresserProvider()),
        ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blackanova',
        initialBinding: InitialBinding(),
        initialRoute: Theme1AppPages.INITIAL,
        themeMode: Get.find<SettingsService>().getThemeMode(),
        theme: Get.find<SettingsService>().getLightTheme(),
        darkTheme: Get.find<SettingsService>().getDarkTheme(),
        getPages: Theme1AppPages.routes,
      )
    );
  }
}
