import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blackanova/modules/booking/view/booking_v2.dart';

class Confirmation extends StatelessWidget {
  const Confirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFEF2), // Set the background color
      body: Padding(
        padding: EdgeInsets.only(top: 190),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/img_afro.jpeg'),
            SizedBox(height: 40),
            Text("Your visit successfully booked", style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 20),
            Text("We will reminder you via email 24 hours before the visit"),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => Booking());

                  },
                  child: Text("Done", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFFFFEF2), // Set the background color
                    onPrimary: Colors.black, // Set the text color
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40), // Adjust the button padding as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Make the button rounded
                      side: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
