import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get package
import 'package:cloud_firestore/cloud_firestore.dart';

class PortofolioController extends GetxController {
  final String userId;
  final imageUrls = <String>[].obs;

  PortofolioController({required this.userId});

  @override
  void onInit() {
    super.onInit();
    fetchImageUrls();
  }

  void fetchImageUrls() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('portofolio')
          .where('userId', isEqualTo: userId)
          .get();

      imageUrls.value = querySnapshot.docs.map((doc) => doc['imageUrl'] as String).toList();
    } catch (e) {
      // Handle any errors here
      print('Error fetching image URLs: $e');
    }
  }
}

class Portofolio extends StatelessWidget {
  final String userId;

  Portofolio({Key? key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PortofolioController>(
      init: PortofolioController(userId: userId),
      builder: (controller) {
        if (controller.imageUrls.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return GridView.builder(
            padding: EdgeInsets.all(5),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0, // add spacing between columns
              mainAxisSpacing: 10.0, // add spacing between rows
              childAspectRatio: 1,
            ),
            itemCount: controller.imageUrls.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black), // add border
                  borderRadius: BorderRadius.circular(10.0), // add border radius
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0), // clip content to the same border radius
                  child: Image.network(
                    controller.imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
