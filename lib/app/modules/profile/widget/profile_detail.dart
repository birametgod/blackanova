import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileDetail extends StatelessWidget {
  final String name;
  final String description;
  final String location;
  //final String rating;
  //final String review;
  final String price;
  final String openingHour;

  const ProfileDetail({super.key,
    required this.name,
    required this.description,
    required this.location,
    //required this.rating,
    //required this.review,
    required this.price,
    required this.openingHour
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: Colors.transparent,
      elevation: 0,
      child: ListTile(
        title: Text(
          name,
          style: Get.textTheme.titleSmall,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: Text(description.tr, overflow: TextOverflow.ellipsis, maxLines: 2, style: Get.textTheme.displaySmall,),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          color: Get.theme.canvasColor,
                          padding: EdgeInsets.all(40.0),
                          child: Text(
                            description.tr,
                            style: Get.textTheme.bodyMedium,
                          ),
                        );
                      },
                    );
                  },
                  child: Text("More", style: Get.textTheme.displaySmall?.merge(TextStyle(fontWeight: FontWeight.bold, color: Get.theme.primaryColor))),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(" 5", style: Get.textTheme.displaySmall,),
                const SizedBox(width: 5),
                Icon(Icons.star, size: 15, color: Get.theme.cardColor,),
                Icon(Icons.star, size: 15, color: Get.theme.cardColor,),
                Icon(Icons.star, size: 15, color: Get.theme.cardColor,),
                Icon(Icons.star, size: 15, color: Get.theme.cardColor,),
                Icon(Icons.star, size: 15, color: Get.theme.cardColor,),
                const SizedBox(width: 5),
                Text("126 Reviews", style: Get.textTheme.displaySmall,)
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: Get.theme.hintColor),
                const SizedBox(width: 5),
                Text(location, style: Get.textTheme.displaySmall),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.watch_later, color: Get.theme.hintColor),
                const SizedBox(width: 5),
                Text(openingHour, style: Get.textTheme.displaySmall),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.currency_exchange_outlined, color: Get.theme.hintColor),
                const SizedBox(width: 5),
                Text(price,style: Get.textTheme.displaySmall)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
