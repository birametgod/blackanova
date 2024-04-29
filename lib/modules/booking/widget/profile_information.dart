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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //TODO : add dynamically the number of stars
              Row(
                children: List.generate(
                  5, (index) => const Icon(
                    Icons.star,
                    size: 15,
                    color: Colors.amberAccent,
                  ),
                )
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              const Icon(Icons.location_on_outlined),
              const SizedBox(width: 5),
              Text(location),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.currency_exchange_outlined),
                  const SizedBox(width: 5),
                  Text(price)
                ],
              ),
              //TODO : transform to button and redirect to barber profile
              Text(
                "More Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          )
        ],
      ),
    );
  }
}
