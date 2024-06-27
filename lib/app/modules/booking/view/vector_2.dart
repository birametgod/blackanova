import 'package:flutter/material.dart';

class VectorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                    colors: [Color(0xFFE66D38), Color(0xFFE95919)],
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
                color: Color(0xFFA2BAA2),
              ),
            ),
          ),
          Positioned(
            left: 139.7,
            top: 251.37,
            child: Transform(
              transform: Matrix4(
                0.45, 0.96, 0, 0, // a, c, 0, 0
                1.98, -0.93, 0, 0, // b, d, 0, 0
                -100, 0, 1, 0, // 0, 0, 1, 0
                -60, 50.12, -40, 1, // tx, ty, 0, 1
              ),
              child: Container(
                width: 240.19,
                height: 116.35,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(245, 131, 81, 1), // Converted UIColor to Color
                      Color.fromRGBO(237, 119, 69, 1), // Converted UIColor to Color
                    ],
                    begin: Alignment(0.25, 0.5),
                    end: Alignment(0.75, 0.5),
                  ),
                ),
              ),
            )
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.6868,
            top: MediaQuery.of(context).size.height * 1.6613,
            child: Transform(
              transform: Matrix4(-0.54, -0.84, 0, 0, 0.85, -0.53, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1),
              child: Container(
                width: 100, // Adjust size accordingly
                height: 100, // Adjust size accordingly
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFF9814E), Color(0xFFF3804E)],
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
                width: 100, // Adjust size accordingly
                height: 100, // Adjust size accordingly
                color: Color(0xFFA2BAA2),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.537,
            top: MediaQuery.of(context).size.height * 1.8037,
            child: Transform(
              transform: Matrix4(-0.54, -0.84, 0, 0, 0.85, -0.53, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1),
              child: Container(
                width: 100, // Adjust size accordingly
                height: 100, // Adjust size accordingly
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFF58351), Color(0xFFED7745)],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
