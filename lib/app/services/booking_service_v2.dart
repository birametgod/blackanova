import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/booking.dart';
import '../models/availibility.dart';

class BookingService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _availabilityBox = Hive.box('availabilityCache');
  final _serviceBox = Hive.box('serviceCache');

  String _formatDate(DateTime? selectedDay) {
    return selectedDay != null
        ? "${selectedDay.year}-${selectedDay.month.toString().padLeft(2, '0')}-${selectedDay.day.toString().padLeft(2, '0')}"
        : "";
  }

  Future<void> preloadBookingData() async {
    await Future.wait([
      _preloadAvailabilities(),
      _preloadServices(),
    ]);
  }

  Future<void> _preloadAvailabilities() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('availabilities')
          .get();

      for (var doc in querySnapshot.docs) {
        String userId = doc.data()['userId'];
        Availability availability = Availability.fromFirestore(doc);
        await _availabilityBox.put(userId, availability.toJson());
      }
      print('Availabilities preloaded successfully');
    } catch (error) {
      print("Error preloading availabilities: $error");
    }
  }

  Future<void> _preloadServices() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('services')
          .get();

      for (var doc in querySnapshot.docs) {
        String serviceId = doc.id;
        await _serviceBox.put(serviceId, doc.data());
      }
      print('Services preloaded successfully');
    } catch (error) {
      print("Error preloading services: $error");
    }
  }

  Future<List<String>?> getAvailabilityByUserIdAndDate(String userId, DateTime? selectedDay) async {
    try {
      String formattedDate = _formatDate(selectedDay);

      // First, try to get from cache
      var cachedAvailability = _availabilityBox.get(userId);
      if (cachedAvailability != null) {
        Availability availability = Availability.fromFirestore(cachedAvailability);
        return availability.availabilityMap?[formattedDate];
      }

      // If not in cache, fetch from Firestore
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('availabilities')
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> snapshot = querySnapshot.docs.first;
        Availability availability = Availability.fromFirestore(snapshot);

        // Cache the fetched data
        await _availabilityBox.put(userId, availability.toJson());

        return availability.availabilityMap?[formattedDate];
      }
    } catch (error) {
      print("Error getting availability: $error");
    }

    return null;
  }

  Future<List<String>> getServiceNames(List<String> serviceIds) async {
    List<String> serviceNames = [];

    try {
      for (String serviceId in serviceIds) {
        // First, try to get from cache
        var cachedService = _serviceBox.get(serviceId);
        if (cachedService != null) {
          String? serviceName = cachedService['serviceName'];
          if (serviceName != null) {
            serviceNames.add(serviceName);
          }
          continue;
        }

        // If not in cache, fetch from Firestore
        DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('services').doc(serviceId).get();

        if (snapshot.exists) {
          String? serviceName = snapshot.data()?['serviceName'];
          if (serviceName != null) {
            serviceNames.add(serviceName);
            // Cache the fetched data
            await _serviceBox.put(serviceId, snapshot.data()!);
          }
        }
      }
    } catch (e) {
      print("Error fetching service names: $e");
    }

    return serviceNames;
  }

// ... (rest of your existing methods)

}