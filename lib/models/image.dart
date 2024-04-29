import 'package:cloud_firestore/cloud_firestore.dart';

class ImageModel {
  String? id;
  String? barberID;
  String? imageUrl;
  String? description;

  ImageModel({
    this.id,
    this.barberID,
    this.imageUrl,
    this.description,
  });

  factory ImageModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return ImageModel(
      id: snapshot.id,
      barberID: data?['barberID'],
      imageUrl: data?['imageUrl'],
      description: data?['description'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (barberID != null) 'barberID': barberID,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (description != null) 'description': description,
    };
  }
}
