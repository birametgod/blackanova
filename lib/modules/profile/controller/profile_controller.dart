import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:blackanova/models/service_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blackanova/services/review_service.dart';
import 'package:blackanova/models/review.dart';

class ProfileController extends GetxController {
  List<Service> services = [];
  List<Map<String, dynamic>> service = [];
  List<Review> reviews = [];
  DoubleValueNotifier topPosition = DoubleValueNotifier(250.0);
  RxInt totalSubServices = 0.obs;
  static ProfileController get to => Get.find();
  final imageUrls = <String>[].obs;

  RxInt getServices() {
    for (var category in service) {
      int subService = category['subService'].length;
      totalSubServices += subService;
    }
    update();
    return totalSubServices;
  }


  @override
  Future<void> onInit() async {
    service = await getServicesByUserId("8IihfI6zhUb78zSCIZO6");
    service.forEach((item) {
      services.add(Service.fromJson(item));
      update();
    });

    getServices();
    fetchImageUrls();
    reviews = await getReviewsByUserId("8IihfI6zhUb78zSCIZO6");

    super.onInit();
    update();
  }


  void updateTopPosition(Offset delta) {
    //topPosition.value += delta.dy;
    //print(topPosition);
    double newValue = topPosition.value + delta.dy;
    newValue = newValue.clamp(50.0, 300.0); // Ensure the value stays between 50.0 and 300.0
    topPosition.value = newValue;
  }

  void fetchImageUrls() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('portofolio')
          .where('userId', isEqualTo: "8IihfI6zhUb78zSCIZO6")
          .get();

      imageUrls.value = querySnapshot.docs.map((doc) => doc['url'] as String).toList();
      update();
    } catch (e) {
      // Handle any errors here
      print('Error fetching image URLs: $e');
    }
  }

}

class DoubleValueNotifier extends ValueNotifier<double> {
  DoubleValueNotifier(double value) : super(value);

  @override
  set value(double newValue) {
    if (newValue != super.value) {
      super.value = newValue;
    }
  }
}