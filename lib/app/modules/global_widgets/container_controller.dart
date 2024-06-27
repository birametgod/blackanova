import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class ContainerController extends GetxController {
  DoubleValueNotifier topPosition = DoubleValueNotifier(250.0);

  void updateTopPosition(Offset delta) {
    double newValue = topPosition.value + delta.dy;
    newValue = newValue.clamp(50.0, 300.0); // Ensure the value stays between 50.0 and 300.0
    topPosition.value = newValue;
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