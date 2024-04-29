import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:blackanova/modules/booking/controller/booking_v2_controller.dart';
import 'package:get/get.dart';

class Calendar extends StatelessWidget {

  Calendar({super.key});

  BookingController controller = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => TableCalendar(
      headerStyle: const HeaderStyle(
          formatButtonVisible:false,
          titleCentered:true,
          titleTextStyle: TextStyle(fontSize: 17.0, color: Colors.grey,),
          headerMargin: EdgeInsets.symmetric(horizontal: 88),
          leftChevronIcon: Icon(Icons.chevron_left, color: Colors.grey,),
          rightChevronIcon: Icon(Icons.chevron_right, color: Colors.grey,)
      ),
      calendarStyle: const CalendarStyle(
        isTodayHighlighted: false,
        selectedDecoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle),
      ),

      calendarFormat: CalendarFormat.week,
      focusedDay: controller.focusedDay.value,
      firstDay: DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day),
      lastDay: DateTime(DateTime.now().year, DateTime.now().month + 3, DateTime.now().day),
      selectedDayPredicate: (day) {
        return controller.selectedDay.value != null && isSameDay(controller.selectedDay.value!, day);
      },
      onDaySelected: (selectedDay, focusedDay){
        controller.onDaySelected(selectedDay, focusedDay);
      },
      onPageChanged: (focusedDay) {
        controller.onPageChanged(focusedDay);
      },
    )
    );
  }
}
