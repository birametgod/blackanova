import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../services/auth_service.dart';
import '../root/controllers/root_controller.dart';
import '../home/views/notification.dart';

class NotificationsButtonWidget extends GetView<RootController> {
  const NotificationsButtonWidget({
    this.iconColor,
    this.labelColor,
    Key? key,
  }) : super(key: key);

  final Color? iconColor;
  final Color? labelColor;

  Widget build(BuildContext context) {
    return MaterialButton(
      hoverElevation: 0,
      highlightElevation: 0,
      elevation: 0,
      onPressed: () {
        if (Get.find<AuthService>().isAuth == true) {
          Get.to(() => NotificationPage());
        } else {
          Get.toNamed(Routes.LOGIN);
        }
      },
      color: Colors.transparent,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          Icon(
            Icons.notifications_outlined,
            color: iconColor ?? Get.theme.hintColor,
            size: 28,
          ),
          Container(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(color: labelColor ?? Get.theme.colorScheme.secondary, borderRadius: BorderRadius.all(Radius.circular(10))),
            constraints: BoxConstraints(minWidth: 16, maxWidth: 16, minHeight: 16, maxHeight: 16),
            child: Obx(() {
              return Center(
                child: Text(
                  controller.notificationsCount.value.toString(),
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodySmall?.merge(
                    TextStyle(color: Get.theme.primaryColor, fontSize: 9, height: 1.4),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}