import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/welcome_page.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/notifications_button_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {

  const HomeView({super.key});


  @override
  Widget build(BuildContext context) {
    controller.initScrollController();
        return Obx(() {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).canvasColor,
                  title: Text(
                    Get.find<SettingsService>().setting.value.salonAppName ?? "",
                    style: Get.textTheme.titleLarge,
                  ),
                  leading: IconButton(
                    icon:  Icon(Icons.sort, color: Theme.of(context).primaryColor),
                    onPressed: () => {Scaffold.of(context).openDrawer()},
                  ),
                  actions: [NotificationsButtonWidget(iconColor: Get.theme.hintColor)]
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: const WelcomePage(),
                );
            });
  }
}