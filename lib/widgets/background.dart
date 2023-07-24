import 'package:flutter/material.dart';
import 'package:blackanova/widgets/glow.dart';

class Background extends StatelessWidget {

  final Widget element;

  const Background({Key? key, required this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 70.0,
            right: -50.0,
            height: 186,
            width: 150,
            child: Glow(color: const Color(0xFF14CACC).withOpacity(0.3) )),
        Positioned(
            top: 50.0,
            right: 100.0,
            height: 85,
            child:  Glow(color: const Color(0xFF4E9FFF).withOpacity(0.5))),
        Positioned(
            top: 50,
            left: 100,
            width: 100,
            height: 350,
            child:  Glow(color: const Color(0xFFB557FF).withOpacity(0.3))),
        Positioned(
            width: 200.0,
            height: 100.0,
            left: -130,
            bottom: 20.0,
            child:  Glow(color: const Color(0xFF14CACC).withOpacity(0.1))),
        Positioned(
            width: 200.0,
            height: 100.0,
            left: 130,
            bottom: 20.0,
            child:  Glow(color: const Color(0xFFB557FF).withOpacity(0.1))),
        element
      ],
    );
  }
}
