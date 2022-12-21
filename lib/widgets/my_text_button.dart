import 'package:blackanova/all_imprts.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTap;
  final Color backgroundColor;

  const MyTextButton({
    Key? key,
    required this.buttonName,
    required this.onTap,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(45.0),
        color: backgroundColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(45.0),
          onTap: onTap,
          child: Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(45.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  buttonName,
                  style: AppTextStyles.blackanova.alegreyaTitleButton,
                  textAlign: TextAlign.center,
                ),
              )),
        ));
  }
}
