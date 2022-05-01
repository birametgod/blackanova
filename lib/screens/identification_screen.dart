import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:blackanova/services/user.dart';

import '../constants.dart';

class IdentificationScreen extends StatefulWidget {
  final bool isConnectingWithPhoneNumber;
  final User? user;

  const IdentificationScreen(
      {required this.user, required this.isConnectingWithPhoneNumber, Key? key})
      : super(key: key);

  @override
  _IdentificationScreenState createState() => _IdentificationScreenState();
}

class _IdentificationScreenState extends State<IdentificationScreen> {
  String dropdownValue = "User";
  bool isRider = false;
  bool isConnectingWithPhoneNumber = false;
  final _formKey = GlobalKey<FormState>();
  late String countryCode;
  late TextEditingController fullNameController;
  late TextEditingController numberPhoneController;
  late TextEditingController idLicenseController;
  late FocusNode _fullNameNode;
  late FocusNode _numberPhoneNode;
  late FocusNode _idLicenseNode;

  void _onCountryChange(CountryCode code) {
    countryCode = code.toString();
    debugPrint(countryCode);
  }

  void _createUser() {
    if (_formKey.currentState!.validate()) {
      String fullName = fullNameController.text;
      String mobile = countryCode + numberPhoneController.text.trim();
      String typeUser = dropdownValue;
      String idLicense = isRider ? idLicenseController.text : "";
      addUser(widget.user, fullName, mobile, idLicense, typeUser, context);
    }
  }

  String? _validateText(String text, TextEditingController fullNameController) {
    fullNameController.text = text;
    if (text.isEmpty) {
      return 'Please enter some text';
    }
    return null;
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
      backgroundColor: const Color(0xFFE7E7E7),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: identificationBodyDecoration,
        child: SafeArea(
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: const <Widget>[
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
                  const SizedBox(
                    height: 35.0,
                  ),
                  const Text('Connexion',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 48,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFormField(
                            controller: fullNameController,
                            focusNode: _fullNameNode,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            autofocus: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                filled: false,
                                fillColor: Colors.white,
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: "nom et prenom"),
                            onChanged: (String value) {},
                            validator: (value) =>
                                _validateText(value!, fullNameController),
                          ),
                          widget.isConnectingWithPhoneNumber
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color(0xFFF7F7F7)),
                                    child: Container(
                                        //color:  Color(0xFFF2B903),
                                        padding: const EdgeInsets.all(10.0),
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
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            SizedBox(
                                              width: 110.0,
                                              child: TextFormField(
                                                controller:
                                                    numberPhoneController,
                                                focusNode: _numberPhoneNode,
                                                keyboardType:
                                                    TextInputType.phone,
                                                textInputAction:
                                                    TextInputAction.done,
                                                cursorColor: Colors.black,
                                                validator: (value) =>
                                                    _validateNumberPhone(value!,
                                                        numberPhoneController),
                                                decoration:
                                                    const InputDecoration(
                                                  focusColor: Colors.black,
                                                  hoverColor: Colors.black,
                                                  hintText: 'saisir numéro',
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                          DropdownButton<String>(
                            value: dropdownValue,
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.white),
                            icon: const Icon(
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
                            items: <String>['User', 'Driver']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          isRider
                              ? TextFormField(
                                  controller: idLicenseController,
                                  focusNode: _idLicenseNode,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.name,
                                  autofocus: true,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
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
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: "id permis"),
                                  onChanged: (String value) {},
                                  validator: (value) {
                                    idLicenseController.text = value!;
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                )
                              : Container(),
                          const SizedBox(
                            height: 35.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: ElevatedButton(
                              // SIGN IN TO GOOGLE
                              onPressed: () async {
                                _createUser();
                              },
                              child: Container(
                                  color: const Color(0xFFF7F7F7),
                                  padding: const EdgeInsets.all(10.0),
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
                          ),
                        ],
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
