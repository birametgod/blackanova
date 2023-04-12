import 'package:blackanova/all_imprts.dart';
import 'package:blackanova/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SmsDialog extends StatefulWidget {
  final String verificationId;

  const SmsDialog({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<SmsDialog> createState() => _SmsDialogState();
}

class _SmsDialogState extends State<SmsDialog> {
  TextEditingController codeController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Enter Sms Code",
          style: AppTextStyles.blackanova.alegreyaSubTitle),
      contentPadding: const EdgeInsets.all(20.0),
      content: PinCodeTextField(
        showCursor: true,
        hintCharacter: '?',
        hintStyle: AppTextStyles.blackanova.alegreyaDescription,
        cursorWidth: 3,
        cursorHeight: 20,
        cursorColor: Colors.blue,
        animationType: AnimationType.slide,
        backgroundColor: Colors.transparent,
        keyboardType: TextInputType.number,
        obscureText: true,
        controller: codeController,
        appContext: context,
        length: 6,
        keyboardAppearance: Brightness.dark,
        textStyle: const TextStyle(color: Colors.black),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.underline,
          borderRadius: BorderRadius.circular(5.0),
          inactiveColor: Colors.black,
          selectedColor: Colors.grey,
          activeColor: Colors.black,
          borderWidth: 1.0,
        ),
        onChanged: (String value) {},
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Resend code',
              style: AppTextStyles.blackanova.alegreyaSubTitleForAlertDialog,
            )),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text('Confirm',
              style: AppTextStyles.blackanova.alegreyaSubTitleForAlertDialog),
          onPressed: () async {
            // resendToken only supported in android devices
            // Update the UI - wait for the user to enter the SMS code
            String smsCode = codeController.text.trim();
            signIn(smsCode, widget.verificationId);
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
          },
        )
      ],
    );
  }
}
