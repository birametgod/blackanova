import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/booking_controller.dart';

class Service extends StatelessWidget {
  Service({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Container(
          height: 300,// change with MediaQuery.of(context).size.height
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
                            style: Get.textTheme.titleMedium?.merge(const TextStyle(fontSize: 16)),
                          ),
                          Text(
                            'Price: ${service['price']} FCFA - Time: ${service['time']} min',
                            style: Get.textTheme.displayMedium?.merge(const TextStyle(fontSize: 14)),
                          ),
                        ],
                      ),
                      const Spacer(),
                      if (BookingController.to.selectedServiceIndex == index)
                        Icon(Icons.check_circle, color: Get.theme.focusColor),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
