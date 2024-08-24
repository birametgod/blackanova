import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../models/service_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../services/review_services.dart';
import '../../../models/review.dart';
import '../../../services/user_service.dart';
import '../../../models/user_model.dart';

class ProfileController extends GetxController {
  //get the id from widget
  final String id;

  ProfileController({required this.id}){
    Get.put(UserService());
  }

  List<Service> services = [];
  List<Map<String, dynamic>> service = [];
  List<Review> reviews = [];
  RxInt totalSubServices = 0.obs;
  static ProfileController get to => Get.find();
  final imageUrls = <String>[].obs;

  RxInt getServices() {
    for (var category in service) {
      int subService = category['subService'].length;
      totalSubServices += subService;
    }
    update();
    return totalSubServices;
  }

  var barberName = ''.obs;
  var barberLocation = ''.obs;


  @override
  Future<void> onInit() async {
    String userId = id;
    final UserService userService = Get.find<UserService>();
    User? userInfo = await userService.getUserInfo(userId);
    if (userInfo != null) {
      barberName.value = userInfo.name;
      barberLocation.value = userInfo.address;
    } else {
      print('Failed to fetch user info for ID: $userId');
    }
    service = await getServicesByUserId(userId);
    service.forEach((item) {
      services.add(Service.fromJson(item));
      update();
    });

    getServices();
    fetchImageUrls();
    reviews = await getReviewsByUserId(userId);

    super.onInit();
    update();
  }



  void fetchImageUrls() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('portofolio')
          .where('userId', isEqualTo: id)
          .get();

      imageUrls.value = querySnapshot.docs.map((doc) => doc['url'] as String).toList();
      update();
    } catch (e) {
      // Handle any errors here
      print('Error fetching image URLs: $e');
    }
  }

}
