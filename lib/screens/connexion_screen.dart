import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:blackanova/screens/home_screen.dart';
import 'package:blackanova/screens/identification_screen.dart';
import 'package:blackanova/services/authentification.dart';

import '../widgets/LineDivider.dart';
import '../widgets/connexion_button.dart';

class ConnexionScreen extends StatefulWidget {
  const ConnexionScreen({Key? key}) : super(key: key);

  @override
  _ConnexionScreenState createState() => _ConnexionScreenState();
}

class _ConnexionScreenState extends State<ConnexionScreen> {
  late TextEditingController phoneController;
  late FocusNode _phoneFocusNode;
  late String countryCode;
  late User userAfterConnexion;
  final _formKey = GlobalKey<FormState>();

  void _onCountryChange(CountryCode code) {
    countryCode = code.toString();
  }

  Future<DocumentReference> addUserInside(
      User user, BuildContext context) async {
    await Firebase.initializeApp();
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users.add({"name": user.displayName, "email": user.email});
  }

  String? _validateNumberPhone(
      String numberPhone, TextEditingController phoneController) {
    phoneController.text = numberPhone;
    if (numberPhone.isEmpty) {
      return 'Please enter a valid number';
    } else if (numberPhone.length != 9) {
      return '9 digit for mobile phone';
    }
    return null;
  }

  void _connectUser(User user) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) => {
              (documentSnapshot.exists)
                  ? Navigator.of(context).pushAndRemoveUntil(
                      PageTransition(
                          child: HomeScreen(),
                          type: PageTransitionType.rightToLeft),
                      (route) => false)
                  : Navigator.of(context).push(PageTransition(
                      child: IdentificationScreen(
                        user: user,
                        isConnectingWithPhoneNumber: false,
                      ),
                      type: PageTransitionType.rightToLeft))
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneController = TextEditingController();
    _phoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE7E7E7),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          systemOverlayStyle:
              SystemUiOverlayStyle.light, // status bar brightness
          title: const Text(
            'Inscription ou connexion',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w400),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SafeArea(
            child: Container(
              color: const Color(0xFFE7E7E7),
              margin: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Abiria",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.grey[800],
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ConnexionButton(
                          color: const Color(0xFF0596F2),
                          padding: const EdgeInsets.all(10.0),
                          image: const AssetImage('assets/images/facebo.png'),
                          title: 'Continuer avec Facebook',
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ConnexionButton(
                          color: const Color(0xFFF7F7F7),
                          padding: const EdgeInsets.all(10.0),
                          image: const AssetImage('assets/images/google.png'),
                          title: 'Continuer avec Google',
                          onPressed: () async {
                            await signInWithGoogle().then((user) {
                              if (user != null) {
                                _connectUser(user);
                              }
                            }).catchError((onError) {});
                          },
                        ),
                        // SIGN IN TO GOOGLE
                      ),
                    ],
                  ),
                  Row(children: const <Widget>[
                    LineDivider(
                      indent: 10,
                    ),
                    Text(
                      "Ou",
                      textAlign: TextAlign.center,
                    ),
                    LineDivider(
                      indent: 20,
                    ),
                  ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        "Saisissez votre numéro de téléphone",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      ElevatedButton(
                        onPressed: null,
                        child: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                CountryCodePicker(
                                  onChanged: _onCountryChange,
                                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                  initialSelection: 'IT',
                                  favorite: ['+39', 'FR'],
                                  // optional. Shows only country name and flag
                                  showCountryOnly: false,
                                  // optional. Shows only country name and flag when popup is closed.
                                  showOnlyCountryWhenClosed: false,
                                  // optional. aligns the flag and the Text left
                                  alignLeft: false,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                SizedBox(
                                  width: 110.0,
                                  child: TextFormField(
                                    controller: phoneController,
                                    focusNode: _phoneFocusNode,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.done,
                                    cursorColor: Colors.black,
                                    validator: (value) => _validateNumberPhone(
                                        value!, phoneController),
                                    decoration: const InputDecoration(
                                      focusColor: Colors.black,
                                      hoverColor: Colors.black,
                                      hintText: 'saisir numéro',
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String mobile =
                              countryCode + phoneController.text.trim();
                          await signInPhone(mobile, context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFF2B903)),
                      child: Container(
                          //color:  Color(0xFFF2B903),
                          padding: const EdgeInsets.all(10.0),
                          child: const Text('Continuer',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
