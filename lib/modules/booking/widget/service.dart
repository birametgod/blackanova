import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blackanova/modules/booking/controller/booking_v2_controller.dart';

class Service extends StatelessWidget {
  const Service({Key? key});

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.put(BookingController());
    return GetBuilder<BookingController>(
      builder: (controller) => Container(
            height: 400,// Adjust height as needed
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: controller.services.length,
              itemBuilder: (BuildContext context, int index) {
                final service = controller.services[index];
                //final isSelectedService = service;
                return GestureDetector(
                  onTap: (){
                    controller.onServiceNameChanged(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Image(
                          image : NetworkImage(service['image']),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service['name'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Price: ${service['price']} FCFA - Time: ${service['time']} min',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        if (controller.selectedServiceIndex.value == index)
                        const Icon(Icons.check_circle, color: Colors.black),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
    );
  }
}
