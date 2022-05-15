import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:blackanova/screens/connexion_screen.dart';
import 'package:blackanova/screens/splash_screen.dart';
import 'package:blackanova/screens/onboarding_page.dart';
import 'package:blackanova/screens/verify_screen.dart';
import 'package:blackanova/screens/welcome_screen.dart';

FirebaseAuth auth  = FirebaseAuth.instance;
GoogleSignIn googleSignIn = GoogleSignIn();

Future signInPhone(String mobile, BuildContext context) async{
  print('mobile $mobile');
  String phoneNumber = "+33752526199";
  auth.verifyPhoneNumber(
      phoneNumber: mobile,
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential authCredential) async {
        //sign the user in
        await auth.signInWithCredential(authCredential);
      },
      verificationFailed: (FirebaseAuthException authException){
        print(authException.message);
      },
      codeSent: (verificationId, [forceResendingToken]){
        //code been sent to my device
        Navigator.of(context).pushAndRemoveUntil(
            PageTransition(child: VerifyScreenSecond(verificationId: verificationId,numberPhone: mobile), type: PageTransitionType.rightToLeft),
                (route) => false
        );
        print('Code sent');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      });
}

Future<User?> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!
      .authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  final UserCredential authResult = await auth.signInWithCredential(
      credential);
  final User? user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User? currentUser = auth.currentUser;
    assert(user.uid == currentUser!.uid);

    //print('signInWithGoogle succeeded: $user');

    return user;
  }
}

Future<void> signOut (BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.push(
      context,
      PageTransition(
          child: ConnexionScreen(),
          type: PageTransitionType.rightToLeft));
}

Future<void> signOutGoogle(BuildContext context) async {
  await googleSignIn.signOut();
}