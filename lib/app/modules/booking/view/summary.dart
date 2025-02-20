import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../controller/booking_controller.dart';
import 'package:flutter/services.dart';
import '../../global_widgets/black_white_bg.dart';

class Summary extends StatelessWidget {
  final DateTime serviceDate;
  final String serviceTime;
  final String serviceName;
  final List serviceTypes;

  Summary({super.key, required this.serviceDate, required this.serviceTime, required this.serviceName, required this.serviceTypes});



  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.find<BookingController>();
    String formattedServiceDate = DateFormat('dd-MM-yyyy').format(serviceDate);
    var stringList = serviceTypes.map((item) => item as String).toList();

    return BlackWhiteBg(
      bar: AppBar(
        title: Text(
          'Summary',
          style: context.textTheme.titleLarge,
        ),
        backgroundColor: Get.theme.canvasColor,
        iconTheme: IconThemeData(color: Get.theme.primaryColor),
        actions: [
          TextButton(
            onPressed: () {
              controller.resetBookingDetails();
              Get.back();
            },
            child: Text(
              'Cancel',
              style: Get.textTheme.bodyMedium?.merge(const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      element: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.perm_contact_cal),
                SizedBox(width: 8),

                Text('Oulimata Niang', style:Get.textTheme.displaySmall),
              ],
            ),
            Row(
              children: [
                Icon(Icons.cut),
                SizedBox(width: 8),
                Text(serviceName, style:Get.textTheme.displaySmall),
              ],
            ),
            Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 8),
                Text('$formattedServiceDate', style:Get.textTheme.displaySmall),
              ],
            ),
            Row(
              children: [
                Icon(Icons.watch_later),
                SizedBox(width: 8),
                Text('${serviceTime}', style:Get.textTheme.displaySmall),
              ],
            ),
            SizedBox(height: 20), // Add spacing

            Text(
              'Please provide the following details:',
              style: Get.textTheme.displayMedium),
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
                  labelStyle: Get.textTheme.displaySmall
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
                      labelStyle: Get.textTheme.displaySmall
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
                    labelStyle: Get.textTheme.displaySmall
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
                decoration: InputDecoration(
                  labelText: 'Type de coiffure',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                  border: InputBorder.none,
                    labelStyle: Get.textTheme.displaySmall
                ),
                items: stringList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: Get.textTheme.displaySmall,),
                  );
                }).toList(),
                onChanged: (String? value) {
                  // Handle the value change if needed
                  print(value);
                  controller.type.value = value!;
                },
              ),
            ),
            SizedBox(height: 20),

            Spacer(),
            Container(
                width: double.infinity,
                child:ElevatedButton(
                  onPressed: () async {
                    await controller.onBookNow();
                    controller.resetBookingDetails();
                    },
                  style: ElevatedButton.styleFrom(
                      primary: Get.theme.unselectedWidgetColor, // Set the background color
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40), // Adjust the button padding as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // Make the button rounded
                      )),
                  child: Text("Book Now", style: Get.textTheme.bodyMedium),
                )
            )
          ],
        ),
      ),
    );
  }
}
