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
  String? date;
  String? status;
  String? serviceType;
  String? barberName;
  String? location;

  Booking({
    this.id,
    this.customerId,
    this.customerName,
    this.customerEmail,
    this.customerPhone,
    this.barberId,
    this.service,
    this.timeSlot,
    this.date,
    this.status,
    this.serviceType,
    this.barberName,
    this.location
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
      barberId: data?['barberID'],
      service: data?['service'],
      timeSlot: data?['timeSlot'],
      date: data?['date'],
      status: data?['status'],
      serviceType: data?['serviceType'],
      barberName: data?['barberName'],
      location:  data?['location'],
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
      if (date != null) 'date': date,
      if (serviceType != null) 'serviceType': serviceType,
      if (status != null) 'status': status ?? 'pending',
      if (barberName != null) 'barberName': barberName,
      if (location != null) 'location': location,
    };
  }
}
