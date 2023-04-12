import 'package:flutter/material.dart';


class ErrorSnackbar extends StatelessWidget {

  final String errorMessage;

  const ErrorSnackbar({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SnackBar(
          backgroundColor: Colors.red,
          content: Text(errorMessage));
  }
}
