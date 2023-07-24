import 'package:blackanova/all_imprts.dart';
import 'package:flutter/material.dart';
import 'package:blackanova/widgets/portrait.dart';

class PortraitWithDescription extends StatelessWidget {

  final String file;
  final String title;
  final String description;

  const PortraitWithDescription({
    Key? key,
    required this.title,
    required this.description,
    required this.file,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: AppDecorations.onBoarding.onBoardingDecoration,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Portrait(file: file ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: AppTextStyles.blackanova.alegreya,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 45.0, vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  description,
                  style: AppTextStyles.blackanova.poppinsDescription,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
