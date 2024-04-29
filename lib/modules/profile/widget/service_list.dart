import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blackanova/modules/profile/controller/profile_controller.dart';

class ServiceList extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  ServiceList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(5),
      itemCount: controller.services.length,
        itemBuilder: (BuildContext context, int index) {
          final service = controller.services[index];
          return ExpansionTile(
            initiallyExpanded: true,
            title: Text(service.name),
            children: service.subService.map((subService) {
              return ListTile(
                title: Text(subService.title),
                leading: Image.asset(subService.image),
                subtitle: Text('${subService.price} - ${subService.time}'),
              );
            }).toList(),
          );
        }
    );
  }
}
