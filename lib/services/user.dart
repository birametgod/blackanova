import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> addUser(String uid, String name, String phoneNumber) {
  return db
      .collection('users')
      .doc(uid)
      .set({
        "name": name,
        "phoneNumber": phoneNumber,
      })
      .then((value) => debugPrint("User Added"))
      .catchError((error) => debugPrint("Failed to add user: $error"));
}

Future<void> updateUser(String userId, BuildContext context, String firstName,
    String lastName, String number, String type) {
  CollectionReference users = db.collection('users');
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
            /*Navigator.of(context).pushAndRemoveUntil(
        PageTransition(
            child: RegisterPage(), type: PageTransitionType.rightToLeft),
            (route) => false)*/
          })
      .catchError((error) => print("Failed to update user: $error"));
}
