import 'package:flutter/material.dart';
//import 'package:blackanova/screens/availibility.dart';
import 'package:blackanova/screens/profile_page.dart';
import 'package:blackanova/modules/booking/view/booking_v2.dart';
import 'package:blackanova/modules/profile/view/profile.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // Replace with your desired text direction
      child: GetMaterialApp(
        home: Scaffold(
          body: SafeArea(
              top: false,
          bottom: false,
              child: Profile()),
        ),
      ),
    );
  }
}