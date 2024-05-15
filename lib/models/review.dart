import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  String? id;
  String username;
  String userImage;
  String? barberId;
  int rating;
  String comment;
  String date;

  Review({
    this.id,
    required this.username,
    required this.userImage,
    this.barberId,
    required this.rating,
    required this.comment,
    required this.date,
  });

  factory Review.fromFirestore(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Review(
      id: snapshot.id,
      username: data['username'],
      userImage: data['userImage'],
      barberId: data['barberID'],
      rating: data['rating'],
      comment: data['comment'],
      date: data['date'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (username != null) 'username': username,
      if (userImage != null) 'userImage': userImage,
      if (barberId != null) 'barberId': barberId,
      if (rating != null) 'rating': rating,
      if (comment != null) 'date': comment,
      if (date != null) 'date': date,
    };
  }
}
