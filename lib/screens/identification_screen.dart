import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blackanova/services/user.dart';

class IdenticationScreen extends StatefulWidget {
  final bool isConnectingWithPhoneNumber;
  final User? user;

  IdenticationScreen(
      {required this.user, required this.isConnectingWithPhoneNumber});

  @override
  _IdenticationScreenState createState() => _IdenticationScreenState();
}

class _IdenticationScreenState extends State<IdenticationScreen> {
  String countryCode = "";
  String dropdownValue = "User";
  bool isRider = false;
  bool isConnectingWithPhoneNumber = false;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController fullNameController;
  late TextEditingController numberPhoneController;
  late TextEditingController idLicenseController;
  late FocusNode _fullNameNode;
  late FocusNode _numberPhoneNode;
  late FocusNode _idLicenseNode;

  void _onCountryChange(CountryCode code) {
    countryCode = code.toString();
    print(countryCode);
  }

  void _createUser() {
    if (_formKey.currentState!.validate()) {
      String fullName = fullNameController.text;
      String mobile = countryCode + numberPhoneController.text.trim();
      String typeUser = dropdownValue;
      String idLicense = isRider ? idLicenseController.text : "";
      addUser(widget.user,fullName,mobile,idLicense,typeUser,context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullNameController = TextEditingController();
    numberPhoneController = TextEditingController();
    idLicenseController = TextEditingController();
    _fullNameNode = FocusNode();
    _numberPhoneNode = FocusNode();
    _idLicenseNode = FocusNode();
    fullNameController.text = widget.user!.displayName!;
    numberPhoneController.text = widget.user!.phoneNumber!;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    numberPhoneController.dispose();
    idLicenseController.dispose();
    _fullNameNode.dispose();
    _numberPhoneNode.dispose();
    _idLicenseNode.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFE7E7E7),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF646464),
                Color(0xFF717271),
                Color(0xFF737473),
                Color(0xFFA2A5A2),
                Color(0xFFE7E7E7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              //stops: [0.1, 0.3, 0.5, 0.7, 0.9],
            )),
        child: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        Text(
                          'retour',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  Text('Connexion',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 48,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: TextFormField(
                                controller: fullNameController,
                                focusNode: _fullNameNode,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                autofocus: true,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    filled: false,
                                    fillColor: Colors.white,
                                    icon: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: "nom et prenom"),
                                onChanged: (String value) {},
                                validator: (value) {
                                  fullNameController.text = value!;
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            widget.isConnectingWithPhoneNumber
                                ? Container()
                                : RaisedButton(
                              onPressed: () {},
                              padding: EdgeInsets.all(0.0),
                              color: Color(0xFFF7F7F7),
                              child: Container(
                                //color:  Color(0xFFF2B903),
                                  padding: EdgeInsets.all(10.0),
                                  child: Container(
                                      child: Row(
                                        children: [
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
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Container(
                                            width: 110.0,
                                            child: TextFormField(
                                              controller: numberPhoneController,
                                              focusNode: _numberPhoneNode,
                                              keyboardType: TextInputType.phone,
                                              textInputAction: TextInputAction.done,
                                              cursorColor: Colors.black,
                                              validator: (value) {
                                                // validate my input number phone
                                                numberPhoneController.text = value!;
                                                if (value.isEmpty) {
                                                  return 'Please enter a valid number';
                                                } else if (value.length != 9) {
                                                  return '9 digit for mobile phone';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                focusColor: Colors.black,
                                                hoverColor: Colors.black,
                                                hintText: 'saisir numéro',
                                              ),
                                            ),
                                          )
                                        ],
                                      ))),
                            ),
                            Container(
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.white),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  dropdownColor: Colors.grey[500],
                                  underline: Container(
                                    height: 3,
                                    color: Colors.white,
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                      newValue == "Driver"
                                          ? isRider = true
                                          : isRider = false;
                                    });
                                  },
                                  items: <String>[
                                    'User',
                                    'Driver'
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                )),
                            isRider
                                ? Container(
                              child: TextFormField(
                                controller: idLicenseController,
                                focusNode: _idLicenseNode,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                autofocus: true,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    filled: false,
                                    fillColor: Colors.white,
                                    icon: Icon(
                                      Icons.perm_identity,
                                      color: Colors.white,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.red),
                                    ),
                                    hintStyle:
                                    TextStyle(color: Colors.white),
                                    hintText: "id permis"),
                                onChanged: (String value) {},
                                validator: (value) {
                                  idLicenseController.text = value!;
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                            )
                                : Container(),
                            SizedBox(
                              height: 35.0,
                            ),
                            RaisedButton(
                              // SIGN IN TO GOOGLE
                              onPressed: () async {
                                _createUser();
                              },
                              padding: EdgeInsets.all(0.0),
                              child: Container(
                                  color: Color(0xFFF7F7F7),
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text("Je m'inscris",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.w300)),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

