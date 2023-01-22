import 'package:blackanova/all_imprts.dart';
import 'package:blackanova/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

FirebaseAuth auth = FirebaseAuth.instance;
TextEditingController codeController = TextEditingController();

Future<void> signInWithPhoneNumber(BuildContext context, String mobile) async {
  print(mobile);
  auth.verifyPhoneNumber(
    phoneNumber: mobile,
    // Automatic handling of the SMS code on Android devices.
    verificationCompleted: (PhoneAuthCredential credential) async {
      // Android ONLY
      // Sign the user in (or link) with the auto-generated credential
      await auth.signInWithCredential(credential).then((value) =>
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage())));
    },
    // Handle failure events such as invalid phone numbers or whether the SMS quota has been exceeded.
    verificationFailed: (FirebaseAuthException e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    },
    // Handle when a code has been sent to the device from Firebase, used to prompt users to enter the code.
    codeSent: (String verificationId, int? resendToken) {
      _dialogBuilder(context, verificationId);
    },
    // Handle a timeout of when automatic SMS code handling fails.
    codeAutoRetrievalTimeout: (String verificationId) {
      print('verificationId: ${verificationId} ');
      // Auto-resolution timed out...
      /** On Android devices which support automatic SMS code resolution,
        * this handler will be called if the device has not automatically resolved an SMS message within a certain timeframe.
        * Once the timeframe has passed, the device will no longer attempt to resolve any incoming messages.
           By default, the device waits for 30 seconds however this can be customized with the timeout argument:**/
    },
  );
}

Future<void> _dialogBuilder(BuildContext context, String verificationId) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
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
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text('Confirm',
                  style:
                      AppTextStyles.blackanova.alegreyaSubTitleForAlertDialog),
              onPressed: () async {
                // resendToken only supported in android devices
                // Update the UI - wait for the user to enter the SMS code
                String smsCode = codeController.text.trim();
                // Create a PhoneAuthCredential with the code
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId, smsCode: smsCode);
                //Sign the user in with the credential
                await auth
                    .signInWithCredential(credential)
                    .then((value) => {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()))
                        })
                    .catchError((error) {
                  debugPrint("this error");
                });
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Resend code',
                  style:
                      AppTextStyles.blackanova.alegreyaSubTitleForAlertDialog,
                ))
          ],
        );
      });
}
