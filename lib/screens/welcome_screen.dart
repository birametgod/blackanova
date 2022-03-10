import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:blackanova/constants.dart';
import 'package:blackanova/screens/connexion_screen.dart';
import 'package:blackanova/screens/home_screen.dart';
import 'package:blackanova/widgets/button_radius.dart';
import 'package:blackanova/widgets/google_font_one.dart';
import 'package:blackanova/widgets/text_fitted_box.dart';
import 'package:ripple_effect/ripple_effect.dart';
import 'package:splashscreen/splashscreen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // go To Connexion Screen
  /*Future<void> toNextPage() => Navigator.of(context).pushAndRemoveUntil(
      PageTransition(
          child: ConnexionScreen(), type: PageTransitionType.rightToLeft),
      (route) => false);*/

  /* @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((_) {
      _navigateUser();
    });
  }
  void _navigateUser() {
    FirebaseAuth.instance.authStateChanges().listen((User currentUser) {
      if (currentUser == null) {
        Navigator.of(context).pushAndRemoveUntil(
            PageTransition(
                child: ConnexionScreen(),
                duration: Duration(seconds: 1),
                type: PageTransitionType.rightToLeftWithFade),
            (route) => false);
      } else {
        print(currentUser);
        Navigator.of(context).pushAndRemoveUntil(
            PageTransition(
                child: HomeScreen(), type: PageTransitionType.rightToLeft),
            (route) => false);
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return SplashScreen(
      navigateAfterSeconds: user != null ? HomeScreen() : ConnexionScreen(),
      seconds: 5,
      //image: Image.asset('assets/images/flutter.png', fit: BoxFit.scaleDown),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader:  TextStyle(),
    );
    /*vnreturn StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return ConnexionScreen();
          }
          return HomeScreen();
        } else {
          return Scaffold(
            body: Material(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/lac_rose.jpeg'),
                  fit: BoxFit.cover,
                )),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                    child: SafeArea(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 30.0),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  GoogleFontOne(
                                      textValue:
                                          'Trouvez\nvotre chauffeur\nen un peu de temps',
                                      size: 25.0,
                                      weight: FontWeight.w800,
                                      height: 1.2),
                                  GoogleFontOne(
                                    textValue:
                                        "Vous serez bientôt en route",
                                    size: 20.0,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
    */
  }
}