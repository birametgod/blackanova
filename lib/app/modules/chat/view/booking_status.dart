import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/booking_list_controller.dart';

class BookingStatusPage extends StatelessWidget {
  final BookingListController _controller = Get.put(BookingListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (_controller.bookings.isEmpty) {
          return Center(child: Text('No bookings found.'));
        }

        return ListView.builder(
          itemCount: _controller.bookings.length,
          itemBuilder: (context, index) {
            final booking = _controller.bookings[index];
            return Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(booking.service ?? ''),
                subtitle: Text(
                    'Date: ${booking.dateTime}\nTime: ${booking.timeSlot}\nStatus: ${booking.status}'),
                trailing: Text(booking.serviceType ?? ''),
              ),
            );
          },
        );
      }),
    );
  }
}
