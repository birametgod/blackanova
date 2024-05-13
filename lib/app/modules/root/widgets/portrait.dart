import 'package:flutter/material.dart';

class Portrait extends StatelessWidget {
  final String file;

  const Portrait({
    Key? key,
    required this.file
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 45.0,
        vertical: 90.0,
      ),
      child: Image.asset(
        file,
      ),
    );
  }
}
