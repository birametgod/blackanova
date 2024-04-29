import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blackanova/modules/booking/controller/booking_v2_controller.dart';

class TimeSlot extends StatelessWidget {

  const TimeSlot({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.put(BookingController());

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
          controller.timeSlot.value.isEmpty
              ? const Center(
            child: Text("No Available slots", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
          )
              : GridView.builder(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            shrinkWrap: true,
            itemCount: controller.timeSlot.value.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3.0,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                controller.updateTimeSlot(index);
              },
              child: Card(
                color: controller.selectedSlotIndex.value == index ? Colors.black : const Color(0xFFFFFEF2),
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
                          controller.timeSlot.value[index],
                          style: TextStyle(
                            color: controller.selectedSlotIndex.value == index ? Colors.white : Colors.black,
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
