import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {

  CardInfo({ required this.imagePath,required this.width, required this.height});

  final String imagePath;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage(imagePath),
              width: width,
              height: height,
            ),
          )
        ],
      ),
    );
  }
}