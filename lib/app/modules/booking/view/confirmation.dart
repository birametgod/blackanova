import 'package:blackanova/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'booking.dart';
import '../../global_widgets/background.dart';
import 'package:blackanova/app/services/settings_service.dart';

class Confirmation extends StatelessWidget {
  const Confirmation({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = Get.find<SettingsService>().getThemeMode();

    // Define colors for light and dark themes
    //Color color3 = themeMode == ThemeMode.dark ? Color(0xFF9AC3C6) : Color(0xFFA2BAA2);
    String imageName = themeMode == ThemeMode.dark ? 'confirm_2.png' : 'confirm_1.png';
    return Background( // Set the background color
      element: Padding(
        padding: EdgeInsets.only(top: 190),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/$imageName',height: 300, width: 300,),
            SizedBox(height: 40),
            Text("Your visit successfully booked", style:Get.textTheme.bodyMedium?.merge(TextStyle(fontWeight: FontWeight.bold),)),
            SizedBox(height: 20),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "We will remind you via SMS\n",
                    style: Get.textTheme.displayMedium,
                  ),
                  TextSpan(
                    text: "  24 hours before the visit",
                    style: Get.textTheme.displayMedium,
                  ),
                ],
              ),
            ),
            //SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.only(top: 100, bottom: 10, left: 80, right: 80),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => HomeView());
                  },
                  child: Text("Done", style: Get.textTheme.bodyMedium),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    onSurface: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40), // Adjust the button padding as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Make the button rounded
                      side: BorderSide(color: Get.theme.primaryColor, width: 2),
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
