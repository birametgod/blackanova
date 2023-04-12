import 'package:blackanova/all_imprts.dart';
import 'package:blackanova/services/user.dart';
import 'package:blackanova/widgets/sms_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

FirebaseAuth auth = FirebaseAuth.instance;
TextEditingController codeController = TextEditingController();

Future<void> createWithEmailAndPassword(String email, String password,
    String name, String phoneNumber, BuildContext context) async {
  try {
    UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    addUser(result.user!.uid, name, phoneNumber);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.red,
            content: Text('The password provided is too weak.')),
      );
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.red,
            content: Text('The account already exists for that email.')),
      );
    }
  } catch (e) {
    print(e);
  }
}

Future<void> signInWithEmailAndPassword(
    String email, String password, BuildContext context) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.red,
            content: Text('No user found for that email.')),
      );
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Wrong password provided for that user.')),
      );
    }
  }
}

Future<void> changePassword(User currentUser, String newPassword) async {
  try {
    await currentUser.updatePassword(newPassword);
  } on FirebaseAuthException catch (e) {
    debugPrint(e.code);
  }
}

Future<void> signInWithPhoneNumber(BuildContext context, String mobile) async {
  await auth.verifyPhoneNumber(
    phoneNumber: mobile,
    // Automatic handling of the SMS code on Android devices.
    verificationCompleted: (PhoneAuthCredential credential) async {
      // Android ONLY
      // Sign the user in (or link) with the auto-generated credential
      await auth
          .signInWithCredential(credential)
          .then((value) => Navigator.popAndPushNamed(context, 'home'));
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

Future<UserCredential?> signInWithGoogle(BuildContext context) async {
  try {
    //Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    //obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    //create a new credential
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
    );

    //once SignedIn return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (e) {
      debugPrint(e.toString());
      return null;
  }
}

Future<void> signIn(String smsCode, String verificationId) async{
// Create a PhoneAuthCredential with the code
  PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId, smsCode: smsCode);
  //Sign the user in with the credential
  await auth.signInWithCredential(credential);
}

Future<void> _dialogBuilder(BuildContext context, String verificationId) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SmsDialog(verificationId: verificationId,);
      });
}
