import 'package:blackanova/app/providers/firebase_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';


class UserRepository {
  late FirebaseProvider _firebaseProvider;

  UserRepository();

  User getCurrentUser() {
    return Get.find<AuthService>().user.value;
  }

  Future<void> deleteCurrentUser() async {
    _firebaseProvider = Get.find<FirebaseProvider>();
    await _firebaseProvider.deleteCurrentUser();
    Get.find<AuthService>().user.value = User();
    GetStorage().remove('current_user');
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    _firebaseProvider = Get.find<FirebaseProvider>();
    return _firebaseProvider.signInWithEmailAndPassword(email, password);
  }

  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    _firebaseProvider = Get.find<FirebaseProvider>();
    return _firebaseProvider.signUpWithEmailAndPassword(email, password);
  }

  Future<void> verifyPhone(String smsCode) async {
    _firebaseProvider = Get.find<FirebaseProvider>();
    return _firebaseProvider.verifyPhone(smsCode);
  }

  Future<void> sendCodeToPhone() async {
    _firebaseProvider = Get.find<FirebaseProvider>();
    return _firebaseProvider.sendCodeToPhone();
  }

  Future signOut() async {
    _firebaseProvider = Get.find<FirebaseProvider>();
    return await _firebaseProvider.signOut();
  }

  //Future<User> register(User user) {
  bool register(User user) {
    /*_laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.register(user);*/
    return true;
  }

  bool sendResetLinkEmail(User user) {
    /*    _laravelApiClient = Get.find<LaravelApiClient>();
    return _laravelApiClient.sendResetLinkEmail(user); */
    return true;
  }

}
