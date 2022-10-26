import 'package:flutter/material.dart';

class ConnexionButton extends StatelessWidget {
  final Color color;
  final EdgeInsets padding;
  final AssetImage image;
  final String title;
  final VoidCallback onPressed;

  const ConnexionButton(
      {Key? key,
        required this.color,
        required this.padding,
        required this.image,
        required this.title,
        required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Container(
        color: color,
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image(
              image: image,
              fit: BoxFit.fitWidth,
            ),
            Text(title,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }
}
