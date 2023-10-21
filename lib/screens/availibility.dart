import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:blackanova/screens/summary_page.dart';
import 'package:blackanova/widgets/calendar.dart';
import 'package:blackanova/widgets/time_slot_selection.dart';
import 'package:blackanova/widgets/profile_information.dart';
import 'package:blackanova/widgets/service_list.dart';


class Availibility extends StatefulWidget {
  const Availibility({Key? key}) : super(key: key);

  @override
  State<Availibility> createState() => _AvailibilityState();
}

class _AvailibilityState extends State<Availibility> {

  static const List<String> timeSlot = [
    '09:00 am',
    '11:00 am',
    '03:00 pm',
    '05:00 pm',
    '07:00 pm',
    '09:00 pm'
  ];

  int selectedCardIndex = -1;
  Map<String, dynamic>? selectedService;

  DateTime serviceDate;
  _AvailibilityState(): serviceDate = DateTime.now();
  late String serviceTime;
  late String serviceName;

  List<Map<String, dynamic>> services = [
    {
      'name': 'Tresses',
      'price': '\$50 40-60 min',
      'image': 'assets/images/blackGirl.png',
    },
    {
      'name': 'Locks',
      'price': '\$50 40-60 min',
      'image': 'assets/images/blackGirl.png',
    },
    {
      'name': 'Chignon',
      'price': '\$50 40-60 min',
      'image': 'assets/images/blackGirl.png',
    },
  ];
  void updateTimeSlot(int index) {
    // Handle the selected time slot here
    serviceTime = timeSlot.elementAt(index);
  }
  @override
  void dispose() {
    // Dispose of the ValueNotifier to prevent memory leaks
    selectedServiceNotifier.dispose();
    super.dispose();
  }

  ValueNotifier<Map<String, dynamic>?> selectedServiceNotifier = ValueNotifier<Map<String, dynamic>?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.2,
            child: Image.asset('assets/images/img_afro.jpeg'),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFEF2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(52.0),
                  topRight: Radius.circular(52.0),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: const Color(0xFF3A5160).withOpacity(0.2),
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const ProfileInformationWidget(
                      name: "Oulimata Niang",
                      location: "0.2 Km - 123 Avenue Salside, Dkr",
                      price: "15.000",
                      rating: "5.0",
                    ),
                    CalendarWidget(
                      calendarFormat: CalendarFormat.week,
                      onDaySelected: (selectedDay) {
                        // Handle the selected day here
                        serviceDate = selectedDay;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          " Select a Time Slot",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                    ),
                    // Use the TimeSlotSelection widget
                    TimeSlotSelection(
                      timeSlots: timeSlot,
                      onTimeSlotSelected: updateTimeSlot,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          " Select a Service",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                    ),

                    ServiceListWidget(
                      services: services,
                      selectedServiceNotifier: selectedServiceNotifier,
                      onServiceNameChanged: (name) {
                        setState(() {
                          serviceName = name;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SummaryPage(
                              serviceDate: serviceDate,
                              serviceTime: serviceTime,
                              serviceName: serviceName,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFFFFFEF2),
                        onPrimary: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 130),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                      child: const Text("Continue", style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
