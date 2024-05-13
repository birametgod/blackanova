import 'package:blackanova/app/repositories/user_repository_blackanova.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_model.dart';
import '../repositories/user_repository.dart';
import 'settings_service.dart';

class AuthServiceBlackanova extends GetxService {
  final user = User().obs;
  late GetStorage _box;
  late UserRepositoryBlackanova _usersRepo;
  late firebaseAuth.FirebaseAuth _auth;


  AuthServiceBlackanova() {
    _usersRepo =  UserRepositoryBlackanova();
    _box =  GetStorage();
    _auth = firebaseAuth.FirebaseAuth.instance;
  }

  Future<AuthServiceBlackanova> init() async {
    /*_auth.authStateChanges().listen((firebaseAuth.User? firebaseUser) async {
      if(firebaseUser != null) {
        // If user is signed in
        user.value = await _usersRepo.getUser();
        user.value.auth = true;
        _box.write('current_user', user.value.toJson());
      } else {
        // If user is signed out
        user.value = User();
        _box.remove('current_user');
      }
    });*/
    user.listen((User user) {
      if (Get.isRegistered<SettingsService>()) {
        print('currentUser ? :$user');
        Get.find<SettingsService>().address.value.userId = user.id;
      }
      _box.write('current_user', user.toJson());
    });
    await getCurrentUser();
    return this;
  }

  Future  getCurrentUser() async {
    print('authentication: ${user.value.auth}');
    print('current user from service : ${_box.hasData('current_user')}');
    if (user.value.auth == null && _box.hasData('current_user')) {
      user.value = User.fromJson(await _box.read('current_user'));
      user.value.auth = true;
    } else {
      user.value.auth = false;
    }
  }

  Future removeCurrentUser() async {
    user.value = User();
    await _usersRepo.signOut();
    await _box.remove('current_user');
  }

  Future deleteAccount() async {
    user.value = User();
    await _usersRepo.signOut();
    await _box.remove('current_user');
  }


  Future isRoleChanged() async {
    try {
      User currentUser = await _usersRepo.getCurrentUser();
      if (currentUser.isSalonOwner != user.value.isSalonOwner) {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('$e');
    }
  }

  bool get isAuth => user.value.auth ?? false;

  String get apiToken => (user.value.auth ?? false) ? user.value.apiToken : '';
}
