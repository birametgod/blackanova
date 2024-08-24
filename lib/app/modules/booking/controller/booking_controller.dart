import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/service_model.dart';
import '../../../models/user_model.dart';
import '../../../services/booking_service.dart';
import '../view/confirmation.dart';
import '../../../services/user_service.dart';

class BookingController extends GetxController {
  final String id;

  BookingController({required this.id}){
    Get.put(UserService());
  }

  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime?> selectedDay = DateTime.now().obs;
  Rx<DateTime> serviceDate = DateTime.now().obs;
  RxList services = [].obs;
  RxInt selectedServiceIndex = (-1).obs ;
  RxString serviceName = ''.obs;
  RxInt selectedSlotIndex = (-1).obs;
  RxString serviceTime = ''.obs;
  RxString userId = ''.obs;
  RxList serviceTypes = [].obs;
  RxString type = ''.obs;
  static BookingController get to => Get.find();

  RxList<String> timeSlot = <String>[].obs;

  final  nameController = TextEditingController();
  final  emailController = TextEditingController();
  final  phoneNumberController = TextEditingController();

  final _status = Rx<RxStatus>(RxStatus.empty());
  var barberName = ''.obs;
  var barberLocation = ''.obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
  }

  List<Map<String, dynamic>> getSubServices(List<Map<String, dynamic>> services) {
    List<Map<String, dynamic>> subServices = [];

    for (var service in services) {
      if (service.containsKey('subService')) {
        subServices.addAll(service['subService']);
      }
    }
    update();
    return subServices;
  }


  @override
  Future<void> onInit() async {
    String userId = id;
    final UserService userService = Get.find<UserService>();
    User? userInfo = await userService.getUserInfo(userId);
    if (userInfo != null) {
      barberName.value = userInfo.name;
      barberLocation.value = userInfo.address;
    } else {
    print('Failed to fetch user info for ID: $userId');
    }
    DateTime today = DateTime(2024, 9, 4); //DateTime.now();
    BookingService bookingService = BookingService();
    bookingService.getAvailabilityByUserIdAndDate(userId, today)
        .then((availability) {
      if (availability != null) {
        //print("Available times on $today: $availability");
        timeSlot.addAll(availability);
        update();
      } else {
        print("No availability found for $today");
        timeSlot.clear();
      }
    });

    //UserService userService = UserService();
    //userService.getUserServices(userId).then((service) {
    //  services.addAll(service);
    //  update();
    //});
    var listService = await getServicesByUserId(userId);
    services.value = getSubServices(listService);
    super.onInit();
    update();
  }

  void onDaySelected(DateTime? selectedDay, DateTime focusedDay) async {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
    //serviceDate.value = selectedDay ?? focusedDay;
    serviceDate.value = selectedDay!;
    // Fetch availability for the selected day
    String userId = "8IihfI6zhUb78zSCIZO6";
    BookingService bookingService = BookingService();
    try {
      var availability = await bookingService.getAvailabilityByUserIdAndDate(userId, selectedDay);
      if (availability != null) {
        //print("Available times on $selectedDay: $availability");
        timeSlot.clear(); // Clear existing time slots
        timeSlot.assignAll(availability); // Update with new time slots using assignAll
        selectedSlotIndex.value = -1;
      } else {
        print("No availability found for $selectedDay");
        timeSlot.clear(); // Clear time slots if none available
      }
      update();
    } catch (e) {
      print("Error fetching availability: $e");
    }
  }

  void onPageChanged(DateTime focusedDay) {
    this.focusedDay.value = focusedDay;
    serviceDate.value = focusedDay;
  }

  void updateTimeSlot(int index) {
    serviceTime.value = timeSlot.elementAt(index);
    selectedSlotIndex.value = index;
    update();
  }

  void onServiceNameChanged(int index) {
    selectedServiceIndex.value = index;
    serviceName.value = services.elementAt(index)['title'];
    serviceTypes.value = services.elementAt(index)['types'];
    update();
  }



  void addBookingInfo() async{
    //add custumer info from the form
    String barberId = "8IihfI6zhUb78zSCIZO6";
    String customerId = "8IihfI6zhUb78zSCIZO6";
    String customerName = nameController.text;
    String customerEmail = emailController.text;
    String customerPhone = phoneNumberController.text;
    String service = serviceName.value;
    DateTime dateTime = serviceDate.value;
    String timeSlot = serviceTime.value;
    String serviceType = type.value;
    BookingService bookingService = BookingService();
    try {
      print("$barberId,$customerId,$service,$dateTime,$timeSlot,$serviceType");
      bookingService.addBooking(
          customerId,customerName,customerEmail,customerPhone, barberId, service, timeSlot, dateTime, serviceType);
    } catch(e){print("error : $e");}

  }

  Future<void> onBookNow() async {
    if (_isValid()) {
      _status.value = RxStatus.loading();
      try {
        addBookingInfo();
        Get.to(() => Confirmation());
        Get.snackbar('Success', 'confirm successful',
            backgroundColor: Colors.green, colorText: Colors.white);
        _status.value = RxStatus.success();
      } catch (e) {
        e.printError();
        Get.snackbar('Error', e.toString(),
            backgroundColor: Colors.red, colorText: Colors.white);
        _status.value = RxStatus.error(e.toString());
      }
    }
  }

  bool _isValid() {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Enter your name',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    if (emailController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Enter email ',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    if (!emailController.text.trim().isEmail) {
      Get.snackbar('Error', 'Enter valid email ',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    if (phoneNumberController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Enter phone number',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    return true;
  }



}