import 'package:flutter/material.dart';

class ProfileInformationWidget extends StatelessWidget {
  final String name;
  final String location;
  final String rating;
  final String price;

  const ProfileInformationWidget({super.key,
    required this.name,
    required this.location,
    required this.rating,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      color: const Color(0xFFFFFEF2),
      elevation: 0,
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_on_outlined),
                const SizedBox(width: 5),
                Text(location),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.currency_exchange_outlined),
                const SizedBox(width: 5),
                Text(price)
              ],
            ),
          ],
        ),
        trailing: const Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star_border_outlined, size: 20),
                Icon(Icons.star_border_outlined, size: 20),
                Icon(Icons.star_border_outlined, size: 20),
                Icon(Icons.star_border_outlined, size: 20),
                Icon(Icons.star_border_outlined, size: 20),
              ],
            ),
            SizedBox(height: 15),
            Text(
              "More Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
