import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blackanova/modules/booking/controller/booking_v2_controller.dart';

class Service extends StatelessWidget {
  Service({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
      builder: (controller) => Container(
            height: 400,// change with MediaQuery.of(context).size.height
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: BookingController.to.services.length,
              itemBuilder: (BuildContext context, int index) {
                final service = BookingController.to.services[index];
                return GestureDetector(
                  onTap: (){
                    BookingController.to.onServiceNameChanged(index);
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
                              service['title'],
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
                        if (BookingController.to.selectedServiceIndex == index)
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
