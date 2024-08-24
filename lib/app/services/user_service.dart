import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';

class UserService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = User().obs;

  Future<User?> getUserInfo(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        User fetchedUser = User.fromJson(userData);
        user.value = fetchedUser; // Update the observable user
        return fetchedUser;
      } else {
        print('User document with ID $userId does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching user info: $e');
      return null;
    }
  }
}
