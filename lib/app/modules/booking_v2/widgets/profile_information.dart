import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../profile/view/profile.dart';
import '../controllers/booking_controller.dart';

class ProfileInformationWidget extends StatelessWidget {
  final String rating;
  final String price;
  final String barberName;
  final String barberLocation;

  const ProfileInformationWidget({super.key,
    required this.rating,
    required this.price,
    required this.barberName,
    required this.barberLocation,
  });

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.find<BookingController>();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                barberName,
                style: Get.textTheme.titleSmall,
              ),
              //TODO : add dynamically the number of stars and 5
              Row(
                  children: List.generate(
                    5, (index) => Icon(
                    Icons.star,
                    size: 15,
                    color: Get.theme.cardColor,
                  ),
                  )
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.location_on_outlined, color: Get.theme.hintColor),
              const SizedBox(width: 5),
              Text(barberLocation, style: Get.textTheme.displaySmall)
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.currency_exchange_outlined, color: Get.theme.hintColor),
                  const SizedBox(width: 5),
                  Text(price.tr, style: Get.textTheme.displaySmall,)
                ],
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() =>Profile(id: controller.id,));
                },
                child: Text(
                  "More Details",
                  style: Get.textTheme.displaySmall?.merge(TextStyle(fontWeight: FontWeight.bold,color: Get.theme.primaryColor )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
