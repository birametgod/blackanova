import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:blackanova/screens/summary_page.dart';

class AvailibilityPage extends StatefulWidget {
  const AvailibilityPage({Key? key}) : super(key: key);

  @override
  State<AvailibilityPage> createState() => _AvailibilityPageState();
}

class _AvailibilityPageState extends State<AvailibilityPage> with TickerProviderStateMixin {

  final CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // TO-DO : Get the data from firebase
  static const TIME_SLOT = {
    '09:00 am',
    '11:00 am',
    '03:00 pm',
    '05:00 pm',
    '07:00 pm',
    '09:00 pm'
  };
  int selectedCardIndex = -1;
  int isSelected = -1;
  Map<String, dynamic>? selectedService;

  late DateTime serviceDate;
  late String serviceTime;
  late String serviceName;
  // TO-DO : Get the data from firebase
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



  @override
  void initState() {
    super.initState();
    
  }

  @override
  void dispose() {
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFFFFFEF2),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.2,
                child: Image.asset('assets/images/img_afro.jpeg'),
              ),
            ],
          ),
          Positioned(
            top: (MediaQuery.of(context).size.width / 1.2) - 50.0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFEF2),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(52.0),
                    topRight: Radius.circular(52.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xFF3A5160).withOpacity(0.2),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: ListView(
                children: [
                  const Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // TO-DO retrieve the data below from Firebase instead
                              Text(" Oulimata Niang",
                                style: TextStyle(
                                  fontSize: 20, // Adjust the font size as desired
                                  fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined), // Replace with your desired icon
                                  SizedBox(width: 5),
                                  Text("0.2 Km - 123 Avenue Salside, Dkr"),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.currency_exchange_outlined), // Replace with your desired icon
                                  SizedBox(width: 5),
                                  Text("15.000"),
                                  Spacer(),
                                  // TO-DO : make it clickable - redirect to pro profile page
                                  Text("More details...", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.star_border_outlined,size: 20),
                              Icon(Icons.star_border_outlined,size: 20),
                              Icon(Icons.star_border_outlined,size: 20),
                              Icon(Icons.star_border_outlined,size: 20),
                              Icon(Icons.star_border_outlined,size: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //CalendarWidget(),
                  TableCalendar(
                    headerStyle: const HeaderStyle(
                        formatButtonVisible:false,
                        titleCentered:true,
                        titleTextStyle: TextStyle(fontSize: 17.0, color: Colors.grey,),
                        headerMargin: EdgeInsets.symmetric(horizontal: 88),
                      leftChevronIcon: Icon(Icons.chevron_left, color: Colors.grey,),
                      rightChevronIcon: Icon(Icons.chevron_right, color: Colors.grey,)
                    ),
                    calendarStyle: const CalendarStyle(
                      selectedDecoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle),
                    todayDecoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),),
                    focusedDay: DateTime.now(),
                    firstDay: DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day),
                    lastDay: DateTime(DateTime.now().year, DateTime.now().month + 3, DateTime.now().day),
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      // Use `selectedDayPredicate` to determine which day is currently selected.
                      // If this returns true, then `day` will be marked as selected.

                      // Using `isSameDay` is recommended to disregard
                      // the time-part of compared DateTime objects.
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        // Call `setState()` when updating the selected day
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                          print(_selectedDay);
                          serviceDate = selectedDay;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      // No need to call `setState()` here
                      _focusedDay = focusedDay;
                      print(_focusedDay);
                      serviceDate = focusedDay;
                    },
                  ),
                  SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16), // Adjust the padding as needed
                    child: Text(
                      "Select a Time Slot",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      itemCount: TIME_SLOT.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 3.0, // Set the desired aspect ratio for the grid items
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            // Update the selected index here
                            selectedCardIndex = index;
                            isSelected = selectedCardIndex;
                            print(TIME_SLOT.elementAt(selectedCardIndex));
                            serviceTime = TIME_SLOT.elementAt(selectedCardIndex);
                          });
                        },
                        child: Card(
                          color: selectedCardIndex == index ? Colors.black : Color(0xFFFFFEF2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15), // Remove the default card border radius
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1.0), // Add the black border
                              borderRadius: BorderRadius.circular(15), // Set the desired card border radius
                            ),
                            child: GridTile(
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Center(
                                  child: Text(TIME_SLOT.elementAt(index), style: TextStyle(color: selectedCardIndex == index ? Colors.white : Colors.black),),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16), // Adjust the padding as needed
                    child: Text(
                      "Select a Service",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Column(
                    children: services.map((service) {
                      final isSelectedService = selectedService == service;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelectedService) {
                              selectedService = null; // Deselect if already selected
                            } else {
                              selectedService = service; // Select this service
                              print(selectedService?['name']);
                              serviceName = selectedService?['name'];
                            }
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          child: Row(
                            children: [
                              Image.asset(
                                service['image'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service['name'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Price: \$${service['price']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              if (isSelectedService) // Add space to push the select icon to the end
                                Icon(Icons.check_circle, color: Colors.black), // Select icon
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ElevatedButton(
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
                      child: Text("Continue", style: TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFFFEF2), // Set the background color to transparent
                        onPrimary: Colors.black, // Set the text color to black
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40), // Adjust the button padding as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Make the button rounded
                          side: BorderSide(color: Colors.black, width: 2), // Add a black border
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SizedBox(
              width: AppBar().preferredSize.height,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                  BorderRadius.circular(AppBar().preferredSize.height),
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFF213333),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}