import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  //add the ID in abstract class
  final String? userType;
  final String? name;
  final String? email;
  final String? address;
  //add location
  final String? phone;
  // Additional user-related information
//set shop name ===> user name if professional
  User({
    this.userType,
    this.name,
    this.email,
    this.address,
    this.phone,
    // Additional user-related fieldscl
  });

  factory User.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options)
  {
    final data = snapshot.data();
    return User(
      userType: data?['userType'],
      name: data?['name'],
      email: data?['email'],
      address: data?['address'],
      phone: data?['phone'],
    );

  }

  Map<String, dynamic> toFirestore() {
    return {
      if (userType != null) "userType": userType,
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (address != null) "address": address,
      if (phone != null) "contactDetails": phone,
    };
  }
}