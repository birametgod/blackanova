import 'package:blackanova/all_imprts.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextInputType inputType;
  final TextEditingController myController;
  final bool isPassword;
  final bool isPasswordVisible;
  final FormFieldValidator<String> validator;
  final void Function()? onTap;

  const MyTextField(
      {Key? key,
      required this.hintText,
      required this.inputType,
      required this.myController,
      required this.validator,
      this.isPassword = false,
      this.isPasswordVisible = false,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        autofocus: true,
        controller: myController,
        style: AppTextStyles.blackanova.alegreyaFieldTitle
            .copyWith(color: Colors.black),
        obscureText: isPasswordVisible ? true : false,
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        validator: validator,
        decoration: InputDecoration(
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: onTap,
                  child: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ))
              : null,
          contentPadding: const EdgeInsets.all(20),
          hintText: hintText,
          hintStyle: AppTextStyles.blackanova.alegreyaFieldTitle,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: Colors.redAccent,
              ),
              borderRadius: BorderRadius.circular(5.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 3,
                color: Colors.redAccent,
              ),
              borderRadius: BorderRadius.circular(5.0)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
