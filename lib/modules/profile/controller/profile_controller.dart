import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:blackanova/models/service_model.dart';
import 'package:blackanova/models/review_model.dart';

class ProfileController extends GetxController {
  List<Service> services = [];
  List<Review> reviews = [];
  DoubleValueNotifier topPosition = DoubleValueNotifier(250.0);

  @override
  Future<void> onInit() async {
    serviceList.forEach((service) {
      services.add(Service.fromJson(service));
    });
    reviewList.forEach((review) {
      reviews.add(Review.fromJson(review));
    });
    super.onInit();
    update();
  }

  void updateTopPosition(Offset delta) {
    topPosition.value += delta.dy;
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