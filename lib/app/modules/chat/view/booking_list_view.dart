import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/booking_list_controller.dart';
import 'conversation.dart';
import '../../global_widgets/black_white_bg.dart';

class BookingListView extends StatelessWidget {
  final BookingListController controller = Get.put(BookingListController());

  Widget _buildTab(String value, String text) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(value.toLowerCase()),
        child: Obx(() => Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: controller.selectedTab.value == value.toLowerCase() ? Get.theme.highlightColor : null,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: controller.selectedTab.value == value.toLowerCase()
                ? Get.theme.primaryColor
                : Colors.grey,
            ),
          ),
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlackWhiteBg(
      bar: AppBar(
        backgroundColor: Get.theme.canvasColor,
        title: Text('Bookings', style: context.textTheme.titleLarge,),
        centerTitle: true,
      ),
      element: Column(
        children: [
          // Status Tabs
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey[200],
            ),
            child: Row(
              children: [
                _buildTab('pending', 'Pending'),
                _buildTab('complete', 'Complete'),
                _buildTab('cancel', 'Cancel'),
              ],
            ),
          ),
          // Booking List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.bookings.isEmpty) {
                return Center(
                  child: Text(
                    'No appointments ${controller.selectedTab.value} yet',
                    style: Get.textTheme.displayMedium,
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.bookings.length,
                itemBuilder: (context, index) {
                  final booking = controller.bookings[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.person, color: Colors.white),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  '${booking.barberName}',
                                  style: Get.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          Row(
                            children: [
                              const Icon(Icons.home, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                index.isEven ? 'Service At Salon' : 'Service At Home',
                                style: Get.textTheme.displaySmall,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                '${booking.date}',
                                style: Get.textTheme.displaySmall,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.watch_later, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                '${booking.timeSlot}',
                                style: Get.textTheme.displaySmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Text(
                                '${booking.service}',
                                style: Get.textTheme.titleMedium,
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (booking.barberName != null && booking.barberId != null) {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Conversation(receiverUserEmail: booking.barberName!, receiverUserID: booking.barberId!,)));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Get.theme.highlightColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    'Contact',
                                    style: Get.textTheme.labelLarge,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
            );}
          ),)
        ],
      ),
    );
  }
}
