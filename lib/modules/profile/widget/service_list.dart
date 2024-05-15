import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blackanova/modules/profile/controller/profile_controller.dart';

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
            title: Text(service.name),
            children: service.subService.map((subService) {
              return ListTile(
                title: Text(subService.title),
                leading: Image.network(subService.image),
                subtitle: Text('Price: ${subService.price} FCFA - Time: ${subService.time}'),
              );
            }).toList(),
          );
        }
    ));
  }
}
