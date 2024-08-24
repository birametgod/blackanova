import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controller/booking_controller.dart';
import 'package:get/get.dart';

class Calendar extends StatelessWidget {

  Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.find<BookingController>();
    return Obx(() => TableCalendar(
      daysOfWeekStyle: DaysOfWeekStyle(weekdayStyle: TextStyle(fontSize: 15), weekendStyle: TextStyle(fontSize: 15)),
      headerStyle: HeaderStyle(
          formatButtonVisible:false,
          titleCentered:true,
          titleTextStyle: Get.textTheme.displayMedium!.merge(const TextStyle(fontWeight: FontWeight.w400)),
          headerMargin: const EdgeInsets.symmetric(horizontal: 88),
          leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.grey,),
          rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.grey,)
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        selectedDecoration: BoxDecoration(
            color: Get.theme.focusColor,
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
