import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:blackanova/screens/connexion_screen.dart';
import 'package:blackanova/widgets/google_font_one.dart';

class SplashScreenBegin extends StatefulWidget {

  @override
  _SplashScreenBeginState createState() => _SplashScreenBeginState();
}

class _SplashScreenBeginState extends State<SplashScreenBegin> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: 6);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ConnexionScreen()));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/connexion");
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const <Widget>[
                            GoogleFontOne(
                                textValue: 'Trouvez\nvotre coiffeuse\nen un peu de temps',
                                size: 0.0,
                                weight:  FontWeight.w800 ,
                                height: 1.2
                            ),
                            GoogleFontOne(
                              textValue: "Vous serez bientôt en contact" ,
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
}
//Find the perfect Hairstyler at your door step