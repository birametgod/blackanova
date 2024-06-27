import 'package:blackanova/app/providers/firebase_api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';
import '../providers/firebase_provider.dart';
import '../services/auth_service.dart';

class UserRepositoryBlackanova {
  late FirebaseApiClient _firebaseApiClient;
  late FirebaseProvider _firebaseProvider;

  UserRepositoryBlackanova();

  Future<User> login(User user) {
    _firebaseApiClient = Get.find<FirebaseApiClient>();
    return _firebaseApiClient.login(user);
  }

  Future<User> get() {
      _firebaseApiClient = Get.find<FirebaseApiClient>();
    return _firebaseApiClient.getUser();
  }

  Future<User> getUser() {
    _firebaseApiClient = Get.find<FirebaseApiClient>();
    return _firebaseApiClient.getUser();
  }

  Future<User> update(User user) {
    _firebaseApiClient = Get.find<FirebaseApiClient>();
    return _firebaseApiClient.updateUser(user);
  }

  Future<User> getCurrentUser() {
    return get();
  }

  Future<void> deleteCurrentUser() async {
    _firebaseApiClient = Get.find<FirebaseApiClient>();
    _firebaseProvider = Get.find<FirebaseProvider>();
    await _firebaseApiClient.deleteUser(Get.find<AuthService>().user.value);
    await _firebaseProvider.deleteCurrentUser();
    Get.find<AuthService>().user.value = User();
    GetStorage().remove('current_user');
  }

  Future<bool> sendResetLinkEmail(User user) {
    _firebaseProvider = Get.find<FirebaseProvider>();
    return _firebaseProvider.sendResetLinkEmail(user);
  }

  Future<User> register(User user) {
    _firebaseApiClient = Get.find<FirebaseApiClient>();
    return _firebaseApiClient.register(user);
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
}
