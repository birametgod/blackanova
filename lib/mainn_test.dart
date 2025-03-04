import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('availabilityCache');
  await Hive.openBox('serviceCache');

  //final bookingService = Get.put(BookingService());
  //await bookingService.preloadBookingData();

  //runApp(MyApp());
}