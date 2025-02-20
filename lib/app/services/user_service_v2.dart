import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService extends GetxService {
  final _userBox = Hive.box('userCache');

  Future<void> preloadUsers() async {
    try {
      // Fetch all users or a subset of users
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').get();

      for (var doc in userSnapshot.docs) {
        String userId = doc.id;
        Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
        await _userBox.put(userId, userData);
      }
    } catch (e) {
      print('Error preloading users: $e');
    }
  }

  Future<User?> getUserInfo(String userId) async {
    // First, try to get cached data
    final cachedUser = _userBox.get(userId);
    if (cachedUser != null) {
      return User.fromJson(cachedUser);
    }

    // If not in cache, fetch from Firestore
    // ... (existing code to fetch from Firestore)
  }

  Future<void> refreshUserData(String userId) async {
    // Fetch fresh data from Firestore and update cache
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      await _userBox.put(userId, userData);
    }
  }
}