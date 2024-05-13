import 'dart:convert';

import 'package:blackanova/app/models/statistic.dart';
import 'package:blackanova/app/providers/api_provider.dart';
import 'package:blackanova/app/services/auth_service_blackanova.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class FirebaseApiClient extends GetxService with ApiClient {
  late final firebase_auth.FirebaseAuth _auth;
  late final FirebaseFirestore _firestore;
  final AuthServiceBlackanova _authService = Get.find<AuthServiceBlackanova>();

  @override
  Future<FirebaseApiClient> init() async {
    super.init();
    _auth = firebase_auth.FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    return this;
  }

  Future<User> getUserSecond() async {
    try {
      firebase_auth.User? currentUser = _auth.currentUser;
      _authService.user.value.auth = true;
      print('email: ${currentUser?.email}');
      DocumentSnapshot<Map<String, dynamic>> userDoc =
      await _firestore.collection('users').doc(currentUser?.uid).get();
      if (userDoc.exists) {
        return User.fromJson(userDoc.data()!);
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
  }

  Future<User> getUser() async {
    try {
      firebase_auth.User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(currentUser.uid).get();
        if (userSnapshot.exists) {
          Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
          userData['auth'] = true;
          await _firestore.collection('users').doc(currentUser.uid).update({ 'auth': true });
          return User.fromJson(userData);
        }
      }
      return User();
    } catch (e) {
      print("Error getting user data: $e");
      return User();
    }
  }

  Future<User> login(User user) async {
    try {
      firebase_auth.UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      firebase_auth.User? currentUser = userCredential.user;
      if (currentUser != null) {
        return getUser();
      }
      return User.fromJson(currentUser as Map<String, dynamic>?);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User> register(User user) async {
    try {
      firebase_auth.UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      firebase_auth.User? currentUser = userCredential.user;
      if (currentUser != null) {
        await _firestore.collection('users').doc(currentUser.uid).set(user.toJson());
        return getUser();
      }
      return User();
    } catch (e) {
      print("Error registering user: $e");
      throw Exception(e.toString());
    }
  }

  Future<bool> sendResetLinkEmail(User user) async {
    try {
      await _auth.sendPasswordResetEmail(email: user.email!);
      return true;
    } catch (e) {
      print("Error sending reset link email: $e");
      return false;
    }
  }

  Future<User> updateUser(User user) async {
    try {
      firebase_auth.User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore.collection('users').doc(currentUser.uid).update(user.toJson());
        return getUser();
      }
      return User();
    } catch (e) {
      print("Error updating user: $e");
      return User();
    }
  }

  Future<bool> deleteUser(User user) async {
    try {
      firebase_auth.User? currentUser = firebase_auth.FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await _firestore.collection('users').doc(currentUser.uid).update({ 'auth': false });
        return true;
      }
      return false;
    } catch (e) {
      print("Error deleting user: $e");
      throw Exception("Error deleting user: $e");
    }
  }
}
