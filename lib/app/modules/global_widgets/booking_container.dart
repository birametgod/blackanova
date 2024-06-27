import 'package:blackanova/app/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'container_controller.dart';

class BookingContainer extends StatelessWidget {
  final Widget element;
  final Widget button;

  BookingContainer({Key? key, required this.element, required this.button}) : super(key: key);
  final ContainerController controller = Get.put(ContainerController());

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = Get.find<SettingsService>().getThemeMode();
    return themeMode == ThemeMode.dark? Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Image.asset('assets/images/img_afro.jpeg'),
          AnimatedBuilder(
              animation: controller.topPosition,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, controller.topPosition.value),
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      controller.updateTopPosition(details.delta);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(52.0),
                          topRight: Radius.circular(52.0),
                        ),
                      ),
                      child: element,
                    ),
                  ),
                );
              }
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: button
          )
        ],
      ),
    ) : Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      body: Stack(
        children: [
          Image.asset('assets/images/img_afro.jpeg'),
          AnimatedBuilder(
              animation: controller.topPosition,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, controller.topPosition.value),
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      controller.updateTopPosition(details.delta);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFEF2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(52.0),
                          topRight: Radius.circular(52.0),
                        ),
                      ),
                      child: element,
                    ),
                  ),
                );
              }
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: button
          )
        ],
      ),
    );
  }
}
