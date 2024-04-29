import 'package:flutter/material.dart';
import 'package:blackanova/modules/booking/controller/booking_v2_controller.dart';
import 'package:blackanova/modules/booking/widget/profile_information.dart';
import 'package:blackanova/modules/booking/widget/calendarV2.dart';
import 'package:blackanova/modules/booking/widget/time_slots.dart';
import 'package:blackanova/modules/booking/widget/service.dart';
import 'package:get/get.dart';
import 'package:blackanova/modules/booking/view/summary.dart';

class Booking extends StatelessWidget {
  final BookingController bookingController = Get.put(BookingController());
  Booking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      body: Stack(
        children: [
          Image.asset('assets/images/img_afro.jpeg'),
          AnimatedBuilder(
            animation: bookingController.topPosition,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, bookingController.topPosition.value),
                child: GestureDetector(
                  onPanUpdate: (details) {
                    bookingController.updateTopPosition(details.delta);
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFEF2),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(52.0),
                              topRight: Radius.circular(52.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: const Color(0xFF3A5160).withOpacity(0.2),
                                offset: const Offset(1.1, 1.1),
                                blurRadius: 10.0,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const ProfileInformationWidget(
                                name: "Oulimata Niang",
                                location: "0.2 Km - 123 Avenue Salside, Dkr",
                                price: "15.000",
                                rating: "5.0",
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Calendar(),
                              ),
                              TimeSlot(),
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
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => Summary(
              serviceDate: bookingController.serviceDate.value,
              serviceTime: bookingController.serviceTime.value,
              serviceName: bookingController.serviceName.value,
            ));
          },
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFFFFFEF2),
            onPrimary: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 130),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: Colors.black, width: 2),
            ),
          ),
          child: const Text("Continue", style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
