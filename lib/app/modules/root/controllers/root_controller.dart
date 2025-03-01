import 'package:blackanova/app/modules/chat/view/booking_list_view.dart';
import 'package:blackanova/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/custom_page_model.dart';
import '../../../routes/app_routes.dart';
import '../../home/views/home_view.dart';
import '../../favorites/view/fav.dart';
import '../../favorites/view/favorite_screen.dart';


class RootController extends GetxController {
  final currentIndex = 0.obs;
  final notificationsCount = 0.obs;
  final customPages = <CustomPage>[].obs;


  @override
  void onInit() async {
    //await getCustomPages();
    if (Get.arguments != null && Get.arguments is int) {
      changePageInRoot(Get.arguments as int);
    } else {
      changePageInRoot(0);
    }
    super.onInit();
  }

  List<Widget> pages = [
    HomeView(),
    FavoritesPage(),
    BookingListView()
    //BookingStatusPage()
    //ChatScreen()
  ];

  Widget get currentPage => pages[currentIndex.value];

  /**
   * change page in route
   * */
  void changePageInRoot(int _index) {
    currentIndex.value = _index;
  }

  void changePageOutRoot(int _index) {
    currentIndex.value = _index;
    Get.offNamedUntil(Routes.ROOT, (Route route) {
      if (route.settings.name == Routes.ROOT) {
        return true;
      }
      return false;
    }, arguments: _index);
  }

  Future<void> changePage(int _index) async {
    if (Get.currentRoute == Routes.ROOT) {
      changePageInRoot(_index);
    } else {
      changePageOutRoot(_index);
    }
    await refreshPage(_index);
  }

  Future<void> refreshPage(int _index) async {
    switch (_index) {
      case 0:
        {
          await Get.find<HomeController>().refreshHome();
          break;
        }
      case 2:
        {
          //await Get.find<MessagesController>().refreshMessages();
          break;
        }
    }
  }
}
