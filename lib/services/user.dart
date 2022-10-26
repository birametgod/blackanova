import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../screens/register_page.dart';

Future<void> addUser(User? user,String name, String phoneNumber,String idLicense, String typeUser, BuildContext context) {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  return users
      .doc(user!.uid)
      .set({
    "name": name,
    "idLicense": idLicense,
    "phoneNumber": phoneNumber,
    "type" : typeUser
  })
      .then((value) => {
    print('is saving ...'),
    // Navigate to the Home Screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return RegisterPage();
        },
      ),
    )
  })
      .catchError((error) => print("Failed to add user: $error"));
}

Future<void> updateUser(String userId, BuildContext context, String firstName,
    String lastName, String number, String type) {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  return users
      .doc(userId)
      .update({
    "firstName": firstName,
    "lastName": lastName,
    "number": number,
    "type": type
  })
      .then((value) => {
    // Navigate to the Home Screen
    Navigator.of(context).pushAndRemoveUntil(
        PageTransition(
            child: RegisterPage(), type: PageTransitionType.rightToLeft),
            (route) => false)
  })
      .catchError((error) => print("Failed to update user: $error"));
}