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
    List<Color> gradient1 = themeMode == ThemeMode.dark
        ? [Color(0xFF8F65F4), Color(0xFF5F53F7)]
        : [Color(0xFFE66D38), Color(0xFFE95919)];
    Color color1 = themeMode == ThemeMode.dark ? Color(0xFF1E232D) : Color(0xFFA2BAA2);
    Color color2 = themeMode == ThemeMode.dark ? Color(0xFF22A6B6) : Color(0xFFAFB19B);
    List<Color> gradient2 = themeMode == ThemeMode.dark
        ? [Color(0xFFF9814E), Color(0xFFF3804E)]
        : [Color(0xFFF58351), Color(0xFFED7745)];
    Color color3 = themeMode == ThemeMode.dark ? Color(0xFF9AC3C6) : Color(0xFFA2BAA2);
    return Background( // Set the background color
      element: Padding(
        padding: EdgeInsets.only(top: 190),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/img_afro.jpeg'),
            SizedBox(height: 40),
            Text("Your visit successfully booked", style:Get.textTheme.displayMedium?.merge(TextStyle(fontWeight: FontWeight.bold),)),
            SizedBox(height: 20),
            Text("We will reminder you via email 24 hours before the visit", style: Get.textTheme.displayMedium,),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => Booking());

                  },
                  child: Text("Done", style: Get.textTheme.bodyMedium),
                  style: ElevatedButton.styleFrom(
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
