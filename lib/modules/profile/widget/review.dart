import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blackanova/modules/profile/controller/profile_controller.dart';

class Review extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  Review({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        padding: EdgeInsets.all(5),
        itemCount: controller.reviews.length,
        itemBuilder: (BuildContext context, int index) {
          final review = controller.reviews[index];
          return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Image.asset(review.image, width: 50, height: 50, fit: BoxFit.cover,),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(review.name)),
                          Text(review.date, style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(Icons.star, size: 15, color: Colors.orange,),
                          Icon(Icons.star, size: 15, color: Colors.orange,),
                          Icon(Icons.star, size: 15, color: Colors.orange,),
                          Icon(Icons.star, size: 15, color: Colors.orange,),
                          Icon(Icons.star, size: 15, color: Colors.orange,),
                        ],
                      ),
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
                          // Add your GestureDetector action here
                        },
                        child: const Text("More", style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                )
              ]
          );
        },
      ),
    );
  }
}
