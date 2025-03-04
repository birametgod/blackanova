import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../services/booking_service.dart';
import '../../../models/booking.dart';

class BookingListController extends GetxController {
  final BookingService _bookingService = BookingService();
  var bookings = <Booking>[].obs;
  var isLoading = false.obs;
  final RxString selectedTab = 'pending'.obs;

  @override
  void onInit() {
    fetchBookings_v2();
    super.onInit();
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
    fetchBookings_v2();
  }

  Future<void> fetchBookings_v2() async {
    try {
      isLoading.value = true;
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        var allBookings = await _bookingService.getBookingsByUserId("8IihfI6zhUb78zSCIZO6");//user.uid);
        bookings.value = allBookings.where((booking) =>
          booking.status?.toLowerCase() == selectedTab.value.toLowerCase()
        ).toList();
        print(bookings.value);
      } else {
        print('No user is currently signed in.');
      }
    } catch (e) {
      print('Error fetching bookings: ' + e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
