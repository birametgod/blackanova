import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blackanova/models/user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> getUserById(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await _firestore.collection('users').doc(userId).get();

      if (snapshot.exists) {
        return User.fromFirestore(snapshot, null);
      } else {
        return null; // User not found
      }
    } catch (e) {
      print("Error fetching user: $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getUserServices(String userId) async {
    List<Map<String, dynamic>> userServices = [];

    // Fetch user services from userService collection
    QuerySnapshot<Map<String, dynamic>> userServiceSnapshot = await FirebaseFirestore.instance
        .collection('userServices')
        .where('userId', isEqualTo: userId)
        .get();

    // Iterate through userService documents
    for (var userServiceDoc in userServiceSnapshot.docs) {
      String serviceId = userServiceDoc.get('serviceId');
      String price = userServiceDoc.get('price');
      String time = userServiceDoc.get('time');
      // Fetch service information from service collection
      DocumentSnapshot<Map<String, dynamic>> serviceSnapshot = await FirebaseFirestore.instance
          .collection('services')
          .doc(serviceId)
          .get();

      if (serviceSnapshot.exists) {
        String name = serviceSnapshot.get('serviceName');
        String image = serviceSnapshot.get('image');

        // Combine user service information
        Map<String, dynamic> userServiceInfo = {
          'name': name,
          'price': price,
          'time': time,
          'image': image,
        };

        userServices.add(userServiceInfo);
      }
    }

    return userServices;
  }
}
