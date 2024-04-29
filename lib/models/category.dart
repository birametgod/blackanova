import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String? id;
  String? categoryName;
  List<String>? services;

  Category({
    this.id,
    this.categoryName,
    this.services,
  });

  factory Category.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return Category(
      id: snapshot.id,
      categoryName: data?['categoryName'],
      services: List<String>.from(data?['services'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (categoryName != null) 'categoryName': categoryName,
      if (services != null) 'services': services,
    };
  }
}
