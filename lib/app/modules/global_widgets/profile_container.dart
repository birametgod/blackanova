import 'package:blackanova/app/services/settings_service.dart';
import 'package:flutter/material.dart';
import './glow.dart';
import 'package:get/get.dart';
import 'container_controller.dart';

class ProfileContainer extends StatelessWidget {

  final Widget element;
  final Widget button;

  ProfileContainer({Key? key, required this.element, required this.button}) : super(key: key);
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

                        child: Stack(
                          children: [
                            Positioned(
                                top: 70.0,
                                right: -50.0,
                                height: 186,
                                width: 150,
                                child: Glow(color:  Color(0xFFB557FF).withOpacity(0.5) )),
                            Positioned(
                                top: 50.0,
                                right: 100.0,
                                height: 85,
                                child:  Glow(color: const Color(0xFF4E9FFF).withOpacity(0.5))),
                            Positioned(
                                top: 50,
                                left: 100,
                                width: 100,
                                height: 350,
                                child:  Glow(color: const Color(0xFF14CACC).withOpacity(0.5))),
                            Positioned(
                                width: 200.0,
                                height: 100.0,
                                left: -130,
                                bottom: 20.0,
                                child:  Glow(color: const Color(0xFFB557FF).withOpacity(0.3))),
                            Positioned(
                                width: 200.0,
                                height: 100.0,
                                left: 130,
                                bottom: 20.0,
                                child:  Glow(color: const Color(0x7912C992).withOpacity(0.2))),
                            element
                          ],
                        )
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
