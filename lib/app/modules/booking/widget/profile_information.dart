import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../profile/view/profile.dart';

class ProfileInformationWidget extends StatelessWidget {
  final String name;
  final String location;
  final String rating;
  final String price;

  const ProfileInformationWidget({super.key,
    required this.name,
    required this.location,
    required this.rating,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
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
              Text(location.tr, style: Get.textTheme.displaySmall,),
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
                  Get.to(() =>Profile());
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
