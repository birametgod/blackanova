import 'package:flutter/material.dart';
import '../controllers/booking_controller.dart';
import '../widgets/profile_information.dart';
import '../widgets/calendar.dart';
import '../widgets/time_slots.dart';
import '../widgets/service.dart';
import 'package:get/get.dart';
import 'summary.dart';
import '../../global_widgets/booking_container.dart';

class Booking extends StatelessWidget {
  final String id;
  Booking({Key? key, required this.id}) : super(key: key) {
    // Initialize the controller with the id
    Get.put(BookingController(id: id));
  }

  @override
  Widget build(BuildContext context) {
    final BookingController bookingController = Get.find<BookingController>();
    return BookingContainer(
      element: Column(
        children: [
          Obx(() => ProfileInformationWidget(
            price: "15.000",
            rating: "5.0",
            barberName: bookingController.barber.value,
            barberLocation: bookingController.barberLocation.value,
          )),
          Calendar(),
          TimeSlot(),
          // To-Do display the service once a timeslot is selected
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              " Select Service",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          Service(),
        ],
      ),
      button: Container(
        padding: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Get.theme.canvasColor,
            shape: BoxShape.rectangle),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            onPressed: () {
              if (bookingController.serviceName.value.isNotEmpty && bookingController.serviceTime.value.isNotEmpty) {
                print("bookingController.serviceName.value.length ");
                Get.to(() => Summary(
                  serviceDate: bookingController.serviceDate.value,
                  serviceTime: bookingController.serviceTime.value,
                  serviceName: bookingController.serviceName.value,
                  serviceTypes: bookingController.serviceTypes.value,
                ));
              } else {
                // Show a message to the user indicating that all fields must be filled
                Get.snackbar(
                  "Incomplete Information",
                  "Please select a date, time, and service before continuing.",
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Get.theme.canvasColor,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 130),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: Get.theme.primaryColor, width: 2),
              ),
            ),
            child: Text("Continue", style: Get.textTheme.bodyMedium),
          ),
        ),
      ),
    );
  }
}