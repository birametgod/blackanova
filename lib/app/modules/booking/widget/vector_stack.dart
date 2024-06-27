import 'package:flutter/material.dart';

class VectorStack extends StatelessWidget {
  final List<Color> gradient1;
  final Color color1;
  final Color color2;
  final List<Color> gradient2;
  final Color color3;

  const VectorStack({
    Key? key,
    required this.gradient1,
    required this.color1,
    required this.color2,
    required this.gradient2,
    required this.color3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: MediaQuery.of(context).size.width * 0.5109,
          top: MediaQuery.of(context).size.height * 0.1893,
          child: Transform(
            transform: Matrix4(0.03, -1, 0, 0, 1, 0.03, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1),
            child: Container(
              width: MediaQuery.of(context).size.width * (1 - 0.3136 - 0.5109),
              height: MediaQuery.of(context).size.height * (1 - 0.1893 - 0.6723),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradient1,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 265.07,
          top: 78.64,
          child: Transform(
            transform: Matrix4(0.03, 1, 0, 0, -1, 0.03, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1),
            child: Container(
              width: 115.45,
              height: 92.73,
              color: color1,
            ),
          ),
        ),
        Positioned(
          left: 139.7,
          top: 251.37,
          child: Transform(
            transform: Matrix4(-0.84, -0.55, 0, 0, 0.55, -0.84, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1),
            child: Container(
              width: 73.22,
              height: 76.39,
              color: color2,
            ),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.6868,
          top: MediaQuery.of(context).size.height * 1.6613,
          child: Transform(
            transform: Matrix4(-0.54, -0.84, 0, 0, 0.85, -0.53, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: gradient2,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.1802,
          top: MediaQuery.of(context).size.height * 0.4487,
          child: Transform(
            transform: Matrix4(0.96, -0.29, 0, 0, 0.29, 0.96, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1),
            child: Container(
              width: 100,
              height: 100,
              color: color3,
            ),
          ),
        ),
      ],
    );
  }
}