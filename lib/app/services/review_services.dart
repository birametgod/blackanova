import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/review.dart';

Future<List<Review>> getReviewsByUserId(String userId) async {
  List<Review> reviews = [];

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('reviews')
        .where('barberId', isEqualTo: userId)
        .get();

    reviews = querySnapshot.docs.map((doc) => Review.fromFirestore(doc)).toList();
  } catch (e) {
    // Handle any errors here
    print('Error fetching reviews: $e');
  }

  return reviews;
}