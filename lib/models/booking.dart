import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  String? id;
  String? customerId;
  String? customerName;
  String? customerEmail;
  String? customerPhone;
  String? barberId;
  String? service;
  String? timeSlot;
  DateTime? dateTime;
  String? status;
  //nom
  //email
  //telephone

  Booking({
    this.id,
    this.customerId,
    this.customerName,
    this.customerEmail,
    this.customerPhone,
    this.barberId,
    this.service,
    this.timeSlot,
    this.dateTime,
    this.status,
  });

  factory Booking.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return Booking(
      id: snapshot.id,
      customerId: data?['customerId'],
      customerName: data?['customerName'],
      customerEmail: data?['customerEmail'],
      customerPhone: data?['customerPhone'],
      barberId: data?['barberId'],
      service: data?['service'],
      timeSlot: data?['timeSlot'],
      dateTime: (data?['dateTime'] as Timestamp?)?.toDate(),
      status: data?['status'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (customerId != null) 'customerId': customerId,
      if (customerName != null) 'customerName': customerName,
      if (customerEmail != null) 'customerEmail': customerEmail,
      if (customerPhone != null) 'customerPhone': customerPhone,
      if (barberId != null) 'barberID': barberId,
      if (service != null) 'service' : service,
      if (timeSlot != null) 'timeSlot' : timeSlot,
      if (dateTime != null) 'dateTime': Timestamp.fromDate(dateTime!),
      if (status != null) 'status': status ?? 'pending',
    };
  }
}
