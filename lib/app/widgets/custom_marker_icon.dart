import 'package:flutter/material.dart';

class CustomMarkerIcon extends StatelessWidget {
  final String imageUrl;

  const CustomMarkerIcon({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the square box
        borderRadius: BorderRadius.circular(8.0), // Adjust the corner radius as needed
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // Shadow offset
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), // Clip the image with the same border radius
        child: Image.asset(
          imageUrl,
          width: 40, // Adjust the size of the image
          height: 40,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
