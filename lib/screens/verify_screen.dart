import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:blackanova/constants.dart';
import 'package:blackanova/screens/home_screen.dart';
import 'package:blackanova/screens/identification_screen.dart';
import 'package:blackanova/screens/splash_screen.dart';
import 'package:blackanova/screens/connexion_screen.dart';
import 'package:blackanova/services/authentification.dart';
import 'package:blackanova/services/user.dart';

class VerifyScreenSecond extends StatefulWidget {
  final String verificationId;
  final String numberPhone;

  VerifyScreenSecond(
      {required this.verificationId, required this.numberPhone});

  @override
  _VerifyScreenSecondState createState() => _VerifyScreenSecondState();
}

class _VerifyScreenSecondState extends State<VerifyScreenSecond> {
  TextEditingController controller = TextEditingController();
  String errorText = "Vous n'avez pas reçu ce code";
  bool isVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE7E7E7),
        appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light, // status bar brightness
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: ConnexionScreen(),
                      type: PageTransitionType.leftToRight));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFFF2BB00),
            ),
          ),
          title: Text(
            'Confirmation',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w400),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
                top: 50.0, left: 20.0, right: 20.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Saisissez le code 6 chiffres reçus',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                  ),
                ),
                isVisible
                    ? Text(
                  errorText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                      color: Color(0xFF273553)),
                )
                    : RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Nous avons envoyé un code par SMS au \n",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                            color: Colors.grey[700]),
                      ),
                      TextSpan(
                        text: "${widget.numberPhone}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                            color: Color(0xFF273553)),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: PinCodeTextField(
                    animationType: AnimationType.slide,
                    backgroundColor: Colors.transparent,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    controller: controller,
                    appContext: context,
                    length: 6,
                    keyboardAppearance: Brightness.dark,
                    textStyle: TextStyle(color: Colors.black),
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      borderRadius: BorderRadius.circular(5.0),
                      inactiveColor: Colors.black,
                      selectedColor: Colors.grey,
                      activeColor: Colors.black,
                      borderWidth: 1.0,
                    ), onChanged: (String value) {  },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Vous n'avez pas reçu le code ?\n",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0,
                                color: Colors.grey[700]),
                          ),
                          TextSpan(
                            text: "Cliquez ici",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>
                              {signInPhone(widget.numberPhone, context)},
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0,
                                color: Color(0xFF273553)),
                          )
                        ],
                      ),
                    ),
                    Ink(
                        width: 65.0,
                        decoration: ShapeDecoration(
                          color: Color(0xFFF2BB00),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 2.0, color: Color(0xFF464F63)),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                        ),
                        child: IconButton(
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Color(0xFF464F63),
                              size: 35.0,
                            ),
                            onPressed: () {
                              setState(() {
                                isVisible = false;
                              });
                              FirebaseAuth auth = FirebaseAuth.instance;
                              //update UI - wait for user enter sms text code
                              String smsCode = controller.text.trim();
                              // create a phoneAuthCredential with the code
                              PhoneAuthCredential phoneAuthCredential =
                              PhoneAuthProvider.credential(
                                  verificationId: widget.verificationId,
                                  smsCode: smsCode);
                              // sign in with credential
                              auth
                                  .signInWithCredential(phoneAuthCredential)
                                  .then((result) async {
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(result.user!.uid)
                                    .get()
                                    .then((DocumentSnapshot documentSnapshot) =>
                                {
                                  if (documentSnapshot.exists)
                                    {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          PageTransition(
                                              child: HomeScreen(),
                                              type:
                                              PageTransitionType
                                                  .rightToLeft),
                                              (route) => false)
                                    }
                                  else
                                    {
                                      // add user
                                      Navigator.of(context).push(
                                        PageTransition(
                                            child: IdenticationScreen(
                                              user: result.user,
                                              isConnectingWithPhoneNumber:
                                              true,
                                            ),
                                            type: PageTransitionType
                                                .rightToLeft),
                                      )
                                    }
                                });
                              }).catchError((e) {
                                print(e.toString().split("]")[1]);
                                String error = e.toString().split("]")[1];
                                setState(() {
                                  isVisible = true;
                                  errorText = error;
                                });
                              });
                            }))
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}