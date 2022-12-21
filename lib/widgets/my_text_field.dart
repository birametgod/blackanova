import 'package:blackanova/all_imprts.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final String hintText;
  final TextInputType inputType;
  final TextEditingController myController ;

  const MyTextField({
    Key? key,
    required this.hintText,
    required this.inputType,
    required this.myController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: myController,
        style: AppTextStyles.blackanova.alegreyaFieldTitle.copyWith(color: Colors.black),
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          hintText: hintText,
          hintStyle: AppTextStyles.blackanova.alegreyaFieldTitle,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(0.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
      ),
    );
  }
}