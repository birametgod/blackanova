import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:blackanova/screens/confirmation_page.dart';

class SummaryPage extends StatefulWidget {
  final DateTime serviceDate;
  final String serviceTime;
  final String serviceName;

  SummaryPage({
    // add the name of the hairdresser as require too
    required this.serviceDate,
    required this.serviceTime,
    required this.serviceName,
  });

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedServiceDate = DateFormat('dd-MM-yyyy').format(widget.serviceDate);

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
              // Add your logic here for the "NO" button action
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
        child: Form(
          key: _formKey,
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
                  Text('${widget.serviceName}'),
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
                  Text('${widget.serviceTime}'),
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
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    // Add additional validation logic for email
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Add the black border
                  borderRadius: BorderRadius.circular(8), // Set the border radius
                ),
                child: TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    // Add additional validation logic for phone number
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),

              Spacer(),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, add your logic here for the "Book Now" button action
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmationPage(
                        ),
                      ),
                    );
                  },
                  child: Text("Book Now", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFFFCF00), // Set the background color
                    onPrimary: Colors.black, // Set the text color
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40), // Adjust the button padding as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Make the button rounded
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
