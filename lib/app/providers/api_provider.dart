import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../common/custom_trace.dart';
import '../services/auth_service.dart';
import '../services/global_service.dart';

mixin ApiClient {
  final globalService = Get.find<GlobalService>();
  final authService = Get.find<AuthService>();
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;

  FirebaseAuth get auth => _auth;
  FirebaseFirestore get firestore => _firestore;

  Future<ApiClient> init() async {
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    return this;
  }

  void setLocale(String locale) {
    // Implement if necessary
  }

  void forceRefresh() {
    // Implement if necessary
  }

  void unForceRefresh() {
    // Implement if necessary
  }

  void printUri(StackTrace stackTrace, Uri uri) {
    Get.log(CustomTrace(stackTrace, message: uri.toString()).toString());
  }
}
