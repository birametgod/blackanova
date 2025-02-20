import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/booking.dart';
import '../models/availibility.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>?> getAvailabilityByUserIdAndDate(
      String userId, DateTime? selectedDay) async {
    try {
      String formattedDate = _formatDate(selectedDay);

      // Query to get the document with the given userId
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('availabilities')
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one document for a specific user
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            querySnapshot.docs.first;

        Availability availability = Availability.fromFirestore(snapshot);

        List<String>? userAvailability =
            availability.availabilityMap?[formattedDate];

        return userAvailability;
      }
    } catch (error) {
      print("Error getting availability: $error");
    }

    return null;
  }

  String _formatDate(DateTime? selectedDay) {
    return selectedDay != null
        ? "${selectedDay.year}-${selectedDay.month.toString().padLeft(2, '0')}-${selectedDay.day.toString().padLeft(2, '0')}"
        : "";
  }

  Future<List<String>> getServiceNames(List<String> serviceIds) async {
    List<String> serviceNames = [];

    try {
      // Reference to the "services" collection in Firestore
      CollectionReference servicesCollection =
          FirebaseFirestore.instance.collection('services');

      // Iterate through each service ID and fetch the corresponding service name
      for (String serviceId in serviceIds) {
        // Query the Firestore collection for the document with the given service ID
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await servicesCollection.doc(serviceId).get() as DocumentSnapshot<
                Map<String, dynamic>>; // Cast to the correct type

        // Check if the document exists and contains the service name
        if (snapshot.exists) {
          // Extract the service name from the document data
          String? serviceName = snapshot.data()?['serviceName'];
          if (serviceName != null) {
            serviceNames.add(serviceName);
          }
        }
      }
    } catch (e) {
      print("Error fetching service names: $e");
    }

    return serviceNames;
  }

  Future<void> addAvailabilityDocument(String userId) async {
    try {
      Map<String, dynamic> availabilityData = {
        'availabilityMap': {
          '2024-09-04': [
            '09:00 am',
            '11:00 am',
            '03:00 pm',
            '05:00 pm',
            '07:00 pm',
            '09:00 pm'
          ],
          '2024-09-11': ['10:00 AM', '2:00 PM', '4:30 PM'],
          '2024-09-12': ['1:00 PM', '3:30 PM', '6:00 PM'],
        },
        'userId': userId,
      };

      await _firestore.collection('availabilities').add(availabilityData);
      print('Document added successfully');
    } catch (error) {
      print('Error adding document: $error');
    }
  }

  //add barber name ****
  //transform datetime to date
  //to do in summary page
  Future<void> addBooking(
      String customerId,
      String customerName,
      String customerEmail,
      String customerPhone,
      String barberId,
      String service,
      String timeSlot,
      DateTime dateTime,
      String serviceType) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference bookings = firestore
          .collection('bookings'); // Assuming 'bookings' is the collection name

      final Booking booking = Booking(
        customerId: customerId,
        customerName: customerName,
        customerEmail: customerEmail,
        customerPhone: customerPhone,
        barberId: barberId,
        service: service,
        timeSlot: timeSlot,
        dateTime: dateTime,
        serviceType: serviceType,
        status: 'pending', // Default status is 'pending'
      );

      await bookings.add(booking.toFirestore());
    } catch (e) {
      print('Error storing booking info: $e');
      // Handle the error appropriately
    }
  }

  Future<List<Booking>> getBookingsByUserId(String userId) async {
    List<Booking> userBookings = [];

    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('bookings')
          .where('customerId', isEqualTo: userId)
          .get();

      for (var doc in querySnapshot.docs) {
        Booking booking = Booking.fromFirestore(doc);
        userBookings.add(booking);
      }
    } catch (e) {
      print('Error fetching bookings: $e');
    }

    return userBookings;
  }
}
