import 'package:flutter/material.dart';

class Glow extends StatelessWidget {
  final Color color;
  final double size;
  final double blur;

  const Glow({Key? key, required this.color, this.size = 100, this.blur = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _Painter(color: color, blur: blur) ,
    );
  }
}

class _Painter extends CustomPainter {
  final Color color;
  final double blur;

  _Painter({ required this.color, required this.blur});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final Paint paint = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur);

    canvas.drawCircle(Offset(size.width / 2, size.width / 2), size.width, paint);
  }

  @override
  bool shouldRepaint(covariant _Painter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate.color != color;
  }
}
