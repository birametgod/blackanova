import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  String? id;
  String? categoryID;
  String? serviceName;
  double? price;
  // add image
  // add time range

  Service({
    this.id,
    this.categoryID,
    this.serviceName,
    this.price,
  });

  factory Service.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return Service(
      id: snapshot.id,
      categoryID: data?['categoryID'],
      serviceName: data?['serviceName'],
      price: (data?['price'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (categoryID != null) 'categoryID': categoryID,
      if (serviceName != null) 'serviceName': serviceName,
      if (price != null) 'price': price,
    };
  }
}
