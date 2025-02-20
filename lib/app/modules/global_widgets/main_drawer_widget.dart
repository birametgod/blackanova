/*
 * File name: main_drawer_widget.dart
 * Last modified: 2023.02.09 at 15:52:46
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2023
 */

import 'package:blackanova/app/modules/favorites/view/fav.dart';
import 'package:blackanova/app/modules/home/views/faq.dart';
import 'package:blackanova/app/modules/home/views/notification.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../services/auth_service_blackanova.dart';
import '../../services/settings_service.dart';
import '../root/controllers/root_controller.dart' show RootController;
import 'drawer_link_widget.dart';

class MainDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ListView(
        children: [
          Obx(() {
            if (!Get.find<AuthServiceBlackanova>().isAuth) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).hintColor.withOpacity(0.1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome".tr, style: Get.textTheme.headlineSmall?.merge(TextStyle(color: Get.theme.colorScheme.secondary))),
                    SizedBox(height: 5),
                    Text("Login account or create new one for free".tr, style: Get.textTheme.bodyLarge),
                    SizedBox(height: 15),
                    Wrap(
                      spacing: 10,
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () {
                            Get.toNamed(Routes.LOGIN);
                          },
                          color: Get.theme.colorScheme.secondary,
                          height: 40,
                          elevation: 0,
                          child: Wrap(
                            runAlignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 9,
                            children: [
                              Icon(Icons.exit_to_app_outlined, color: Get.theme.primaryColor, size: 24),
                              Text(
                                "Login".tr,
                                style: Get.textTheme.titleMedium?.merge(TextStyle(color: Get.theme.primaryColor)),
                              ),
                            ],
                          ),
                          shape: StadiumBorder(),
                        ),
                        MaterialButton(
                          color: Get.theme.focusColor.withOpacity(0.2),
                          height: 40,
                          elevation: 0,
                          onPressed: () {
                            Get.toNamed(Routes.REGISTER);
                          },
                          child: Wrap(
                            runAlignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 9,
                            children: [
                              Icon(Icons.person_add_outlined, color: Get.theme.hintColor, size: 24),
                              Text(
                                "Register".tr,
                                style: Get.textTheme.titleMedium?.merge(TextStyle(color: Get.theme.hintColor)),
                              ),
                            ],
                          ),
                          shape: StadiumBorder(),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).hintColor.withOpacity(0.1),
                ),
                accountName: Text(
                  Get.find<AuthServiceBlackanova>().user.value.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                accountEmail: Text(
                  Get.find<AuthServiceBlackanova>().user.value.email,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                currentAccountPicture: Stack(
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(80)),
                        child: CachedNetworkImage(
                          height: 80,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: "https://thumbs.dreamstime.com/z/speed-boat-5750774.jpg?ct=jpeg",
                          /*placeholder: (context, url) => Image.asset(
                            'assets/img/loading.gif',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 80,
                          ),*/
                          errorWidget: (context, url, error) => Icon(Icons.error_outline),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Icon(Icons.check_circle, color: Get.theme.colorScheme.secondary, size: 24)
                    )
                  ],
                ),
              );
            }
          }),
          SizedBox(height: 20),
          DrawerLinkWidget(
            icon: Icons.person_outline,
            text: "My Bookings",
            onTap: (e) {
              //Get.back();
              //Get.find<RootController>().changePage(3);
            },
          ),
          DrawerLinkWidget(
            icon: Icons.folder_special_outlined,
            text: "My Favorites",
            onTap: (e) {
              Get.to(FavoritesPage());
            },
          ),
          DrawerLinkWidget(
            icon: Icons.notifications_none_outlined,
            text: "Notifications",
            onTap: (e) {
              Get.to(NotificationPage());
            },
          ),
          ListTile(
            dense: true,
            title: Text(
              "Application preferences".tr,
              style: Get.textTheme.bodySmall,
            ),
            trailing: Icon(
              Icons.remove,
              color: Get.theme.focusColor.withOpacity(0.3),
            ),
          ),

          DrawerLinkWidget(
            icon: Icons.translate_outlined,
            text: "Languages",
            onTap: (e) {
              Get.offAndToNamed(Routes.SETTINGS_LANGUAGE);
            },
          ),
          DrawerLinkWidget(
            icon: Icons.brightness_6_outlined,
            text: Get.isDarkMode ? "Light Theme" : "Dark Theme",
            onTap: (e) {
              Get.offAndToNamed(Routes.SETTINGS_THEME_MODE);
            },
          ),
          ListTile(
            dense: true,
            title: Text(
              "Help & Privacy",
              style: Get.textTheme.bodySmall,
            ),
            trailing: Icon(
              Icons.remove,
              color: Get.theme.focusColor.withOpacity(0.3),
            ),
          ),
          DrawerLinkWidget(
            icon: Icons.help_outline,
            text: "Help & FAQ",
            onTap: (e) {
              Get.to(const FAQ());
            },
          ),
          //if (Get.find<AuthService>().user.value.isSalonOwner) CustomPageDrawerLinkWidget(),
          Obx(() {
            if (Get.find<AuthServiceBlackanova>().isAuth) {
              return DrawerLinkWidget(
                icon: Icons.logout,
                text: "Logout",
                onTap: (e) async {
                  await Get.find<AuthServiceBlackanova>().removeCurrentUser();
                  await Get.offNamedUntil(Routes.LOGIN, (Route route) {
                    if (route.settings.name == Routes.LOGIN) {
                      return true;
                    }
                    return false;
                  });
                },
              );
            } else {
              return SizedBox(height: 0);
            }
          }),
        ],
      ),
    );
  }
}
