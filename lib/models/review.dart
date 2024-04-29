import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  String? id;
  String? customerID;
  String? barberID;
  int? rating;
  String? feedback;

  Review({
    this.id,
    this.customerID,
    this.barberID,
    this.rating,
    this.feedback,
  });

  factory Review.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return Review(
      id: snapshot.id,
      customerID: data?['customerID'],
      barberID: data?['barberID'],
      rating: data?['rating'],
      feedback: data?['feedback'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (customerID != null) 'customerID': customerID,
      if (barberID != null) 'barberID': barberID,
      if (rating != null) 'rating': rating,
      if (feedback != null) 'feedback': feedback,
    };
  }
}
