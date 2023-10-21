import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final CalendarFormat calendarFormat;
  final Function(DateTime)? onDaySelected;

  const CalendarWidget({
    Key? key,
    required this.calendarFormat,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime serviceDate;
  _CalendarWidgetState() : serviceDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
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
      calendarFormat: widget.calendarFormat,
      focusedDay: _focusedDay,
      firstDay: DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day),
      lastDay: DateTime(DateTime.now().year, DateTime.now().month + 3, DateTime.now().day),
      selectedDayPredicate: (day) {
        return _selectedDay != null && isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
          serviceDate = selectedDay ?? _focusedDay; // Set serviceDate to selectedDay if not null, otherwise to _focusedDay
        });

        // Call the provided callback with the selected day
        if (widget.onDaySelected != null) {
          widget.onDaySelected!(serviceDate);
        }
      },
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        _focusedDay = focusedDay;
        serviceDate = focusedDay;
      },
      // Additional calendar settings go here
    );
  }
}
