import 'package:flutter/material.dart';

class LineDivider extends StatelessWidget {

  final double indent;

  const LineDivider({
    Key? key,
    required this.indent
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Expanded(
        child: Divider(
          color: Colors.black,
          height: 10,
          thickness: 1,
          indent: indent,
          endIndent: 20,
        ));
  }
}
