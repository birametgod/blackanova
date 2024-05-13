import 'package:blackanova/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import '../controllers/root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RootController(), permanent: true);
    Get.put(HomeController(), permanent: true);

    /*
    Get.lazyPut<BookingController>(
      () => BookingController(),
    );
    Get.lazyPut<ReviewsController>(
      () => ReviewsController(),
    );
    Get.lazyPut<ReviewController>(
      () => ReviewController(),
    );
    Get.lazyPut<MessagesController>(
      () => MessagesController(),
      fenix: true,
    );
    Get.lazyPut<AccountController>(
      () => AccountController(),
    );
    Get.lazyPut<SearchController>(
      () => SearchController(),
    );*/
  }
}
