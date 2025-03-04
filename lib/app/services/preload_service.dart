import 'package:get/get.dart';
import 'user_service_v2.dart';
import 'booking_service_v2.dart';

class PreloadService extends GetxService {
  final UserService _userService = Get.find<UserService>();
  final BookingService _bookingService = Get.find<BookingService>();
  // Add other services as needed

  Future<void> preloadData() async {
    await Future.wait([
      _preloadUserData(),
      _preloadBookingData(),
      // Add other preload methods
    ]);
  }

  Future<void> _preloadUserData() async {
    // Fetch and cache user data
    await _userService.preloadUsers();
  }

  Future<void> _preloadBookingData() async {
    // Fetch and cache booking data
    await _bookingService.preloadBookingData();
  }

}