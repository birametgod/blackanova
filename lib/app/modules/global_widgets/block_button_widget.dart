import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockButtonWidget extends StatelessWidget {
  const BlockButtonWidget({Key? key, required this.color, required this.text, required this.onPressed}) : super(key: key);

  final Color color;
  final Widget text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: onPressed != null
          ? BoxDecoration(
              border: Border.all(color: Get.theme.focusColor, width: 2.0),
              borderRadius: const BorderRadius.all(Radius.circular(45.0)),
            )
          : null,
      child: MaterialButton(
        onPressed: onPressed,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        color: Colors.transparent,
        disabledElevation: 0,
        disabledColor: Get.theme.focusColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.0)),
        elevation: 0,
        child: text,
      ),
    );
  }
}
