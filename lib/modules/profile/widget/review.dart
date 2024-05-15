import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blackanova/modules/profile/controller/profile_controller.dart';

class Review extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  Review({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        builder: (controller) => ListView.builder(
      padding: EdgeInsets.all(5),
      itemCount: controller.reviews.length,
      itemBuilder: (BuildContext context, int index) {
        final review = controller.reviews[index];
        return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(review.userImage, width: 50, height: 50, fit: BoxFit.cover,)),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(review.username)),
                        Text(review.date, style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Row(
                      children: List.generate(
                          review.rating,
                              (index) => Icon(Icons.star, size: 15, color: Colors.orange))
                    )
                  ],
                ),
                //trailing: Text(review.date),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: Text(review.comment, overflow: TextOverflow.ellipsis, maxLines: 2),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              color: const Color(0xFFFFFEF2),
                              padding: EdgeInsets.all(40.0),
                              child: Text(
                                review.comment,
                                style: TextStyle(fontSize: 20.0),
                              ),
                            );
                          },
                        );
                      },
                      child: const Text("More", style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              )
            ]
        );
      },
    ));
  }
}
