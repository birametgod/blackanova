import 'package:flutter/material.dart';

class ServiceListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> services;
  final ValueNotifier<Map<String, dynamic>?> selectedServiceNotifier;
  final Function(String) onServiceNameChanged;

  ServiceListWidget({
    required this.services,
    required this.selectedServiceNotifier,
    required this.onServiceNameChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, dynamic>?>(
      valueListenable: selectedServiceNotifier,
      builder: (context, selectedService, child) {
        return Column(
          children: services.map((service) {
            final isSelectedService = selectedService == service;
            return GestureDetector(
              onTap: () {
                if (isSelectedService) {
                  selectedServiceNotifier.value = null; // Deselect if already selected
                  onServiceNameChanged('');
                } else {
                  selectedServiceNotifier.value = service;
                  onServiceNameChanged(service['name']); // Update the service name
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Row(
                  children: [
                    Image.asset(
                      service['image'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Price: \$${service['price']}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (isSelectedService)
                      const Icon(Icons.check_circle, color: Colors.black),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
