import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blackanova/modules/booking/controller/booking_v2_controller.dart';

class TimeSlot extends StatelessWidget {

  TimeSlot({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            " Available Slot",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          BookingController.to.timeSlot.isEmpty
              ? const Center(
            child: Text("No Available slots", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
          )
              : GridView.builder(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            shrinkWrap: true,
            itemCount: BookingController.to.timeSlot.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3.0,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                BookingController.to.updateTimeSlot(index);
              },
              child: Card(
                color: BookingController.to.selectedSlotIndex == index ? Colors.black : const Color(0xFFFFFEF2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: GridTile(
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Center(
                        child: Text(
                          BookingController.to.timeSlot[index],
                          style: TextStyle(
                            color: BookingController.to.selectedSlotIndex == index ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
