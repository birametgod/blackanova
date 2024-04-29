import 'package:flutter/material.dart';

class TimeSlotSelection extends StatefulWidget {
  final List<String> timeSlots;
  final Function(int) onTimeSlotSelected;

  const TimeSlotSelection({
    Key? key,
    required this.timeSlots,
    required this.onTimeSlotSelected,
  }) : super(key: key);

  @override
  _TimeSlotSelectionState createState() => _TimeSlotSelectionState();
}

class _TimeSlotSelectionState extends State<TimeSlotSelection> {
  int selectedSlotIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Text(
            " Available Slot",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey
            ),
          ),
        GridView.builder(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          shrinkWrap: true,
          itemCount: widget.timeSlots.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 3.0,
          ),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              setState(() {
                selectedSlotIndex = index;
                widget.onTimeSlotSelected(index);
              });
            },
            child: Card(
              color: selectedSlotIndex == index ? Colors.black : Color(0xFFFFFEF2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: GridTile(
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Center(
                      child: Text(
                        widget.timeSlots[index],
                        style: TextStyle(
                          color: selectedSlotIndex == index ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
