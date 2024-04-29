import 'package:flutter/material.dart';

class Portofolio extends StatelessWidget {
  const Portofolio({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(5),
      crossAxisCount: 2,
      childAspectRatio: 1,
      children: List.generate(4, (index) {
        return GridTile(
          child: Image.asset('assets/images/image_$index.png'),
      );
      }),
    );
  }
}
