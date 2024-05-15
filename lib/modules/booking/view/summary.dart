import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:blackanova/modules/booking/controller/booking_v2_controller.dart';
import 'package:flutter/services.dart';

class Summary extends StatelessWidget {
  final DateTime serviceDate;
  final String serviceTime;
  final String serviceName;
  final BookingController controller = Get.put(BookingController());

  Summary({super.key, required this.serviceDate, required this.serviceTime, required this.serviceName});



  @override
  Widget build(BuildContext context) {
    String formattedServiceDate = DateFormat('dd-MM-yyyy').format(serviceDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Summary',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xFFFFFEF2),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFFFFEF2), // Set the background color
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.perm_contact_cal),
                SizedBox(width: 8),

                Text('Oulimata Niang'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.cut),
                SizedBox(width: 8),
                Text('${serviceName}'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 8),
                Text('$formattedServiceDate'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.watch_later),
                SizedBox(width: 8),
                Text('${serviceTime}'),
              ],
            ),
            SizedBox(height: 20), // Add spacing

            Text(
              'Please provide the following details:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Add the black border
                borderRadius: BorderRadius.circular(9), // Set the border radius
              ),
              child: TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: ' Name',
                ),
              ),
            ),
            SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Add the black border
                borderRadius: BorderRadius.circular(8), // Set the border radius
              ),
              // add input control
              child: TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  labelText: ' Email',
                )
              ),
            ),
            SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Add the black border
                borderRadius: BorderRadius.circular(8), // Set the border radius
              ),
              child: TextFormField(
                controller: controller.phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10), // Limit to 10 characters
                  // You can add more formatters if needed, e.g., to format the phone number
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Add the black border
                borderRadius: BorderRadius.circular(8), // Set the border radius
              ),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Type de coiffure',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                  border: InputBorder.none,
                ),
                items: ["long","petit","court"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  // Handle the value change if needed
                },
              ),
            ),
            SizedBox(height: 20),

            Spacer(),
            Container(
              width: double.infinity,
              child:ElevatedButton(
                onPressed: controller.onBookNow,
                child: Text("Book Now", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFFCF00), // Set the background color
                  onPrimary: Colors.black, // Set the text color
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40), // Adjust the button padding as needed
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Make the button rounded
                  )),
            )
            )
          ],
        ),
      ),
    );
  }
}
