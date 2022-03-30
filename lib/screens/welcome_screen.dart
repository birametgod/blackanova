import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:blackanova/screens/connexion_screen.dart';
import 'package:blackanova/screens/home_screen.dart';
import 'package:splashscreen/splashscreen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return SplashScreen(
      navigateAfterSeconds: user != null ? HomeScreen() : ConnexionScreen(),
      seconds: 5,
      backgroundColor: Colors.white,
      styleTextUnderTheLoader:  TextStyle(),
    );
  }
}