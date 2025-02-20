import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/profile_controller.dart';

class ServiceList extends StatelessWidget {

  ServiceList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        builder: (controller) =>ListView.builder(
            padding: EdgeInsets.all(5),
            itemCount: ProfileController.to.services.length,
            itemBuilder: (BuildContext context, int index) {
              final service = ProfileController.to.services[index];
              return ExpansionTile(
                initiallyExpanded: true,
                title: Text(service.name, style: Get.textTheme.displayMedium?.merge(const TextStyle(fontSize: 14))),
                children: service.subService.map((subService) {
                  return ListTile(
                    title: Text(subService.title, style: Get.textTheme.titleMedium?.merge(const TextStyle(fontSize: 16))),
                    leading: Image.asset("assets/images/blackGirl.png"),
                    subtitle: Text('Price: ${subService.price} FCFA - Time: ${subService.time}', style: Get.textTheme.displayMedium?.merge(const TextStyle(fontSize: 14)),),
                  );
                }).toList(),
              );
            }
        ));
  }
}
