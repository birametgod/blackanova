import 'package:flutter/material.dart';
import '../controller/booking_controller.dart';
import '../widget/profile_information.dart';
import '../widget/calendar.dart';
import '../widget/time_slots.dart';
import '../widget/service.dart';
import 'package:get/get.dart';
import 'summary.dart';
import '../../global_widgets/booking_container.dart';

class Booking extends StatelessWidget {
  final BookingController bookingController = Get.put(BookingController());
  Booking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BookingContainer(
      element: Column(
        children: [
          const ProfileInformationWidget(
            name: "Oulimata Niang",
            location: "0.2 Km - 123 Avenue Salside, Dkr",
            price: "15.000",
            rating: "5.0",
          ),
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
              Get.to(() => Summary(
                serviceDate: bookingController.serviceDate.value,
                serviceTime: bookingController.serviceTime.value,
                serviceName: bookingController.serviceName.value,
                serviceTypes: bookingController.serviceTypes.value,
              ));
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
