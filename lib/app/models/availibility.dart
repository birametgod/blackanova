import 'package:cloud_firestore/cloud_firestore.dart';

class Availability {
  String? id;
  Map<String, List<String>>? availabilityMap; // Dictionary structure
  String? userId;

  //handle when their is no availability
  //a function that delete past availability


  Availability({
    this.id,
    this.availabilityMap,
    this.userId,
  });

  factory Availability.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return Availability(
      id: snapshot.id,
      availabilityMap: _parseAvailabilityMap(data?['availabilityMap']),
      userId: data?['userId'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'availabilityMap': availabilityMap,
      'userId': userId,
    };
  }

  static Map<String, List<String>>? _parseAvailabilityMap(dynamic mapData) {
    if (mapData == null) {
      return null;
    }

    Map<String, dynamic>? rawData = mapData.cast<String, dynamic>();
    if (rawData == null) {
      return null;
    }

    return rawData.map((key, value) {
      return MapEntry(key, (value as List<dynamic>).cast<String>());
    });
  }
}
