import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> getServicesByUserId(String userId) async {
  List<Map<String, dynamic>> serviceLists = [];

  try {
    // Query the 'userService' collection based on userId
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('userService')
        .where('userId', isEqualTo: userId)
        .get();

    // Iterate through the documents in the query result
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      String category = doc['category'];
      double price = doc['price'];
      int time = doc['time'];
      String image = doc['image'];
      Map<String, dynamic> serviceData = doc['service'];

      // Construct the service details map
      Map<String, dynamic> subService = {
        'title': serviceData['title'],
        'price': '\$$price',
        'time': '$time min',
        'image': image
      };

      // Check if the category already exists in the serviceList
      int existingCategoryIndex = serviceLists.indexWhere((item) => item['name'] == category);

      if (existingCategoryIndex != -1) {
        // If category exists, add the subService to its existing list of subServices
        serviceLists[existingCategoryIndex]['subService'].add(subService);
      } else {
        // If category does not exist, create a new category entry with the subService
        serviceLists.add({
          'name': category,
          'subService': [subService],
        });
      }
    }

    return serviceLists;
  } catch (e) {
    print('Error fetching services: $e');
    return [];
  }
}



List<Map<String, dynamic>> serviceList = [
  {
    "name" : "Haircut",
    "subService": [
      {"title" : "Tresses",
        "image": "assets/images/blackGirl.png",
        "price": "\$50",
        "time": "40-60 min"},
      {"title" : "Locks",
        "image": "assets/images/blackGirl.png",
        "price": "\$50",
        "time": "40-60 min" }
    ]
  },
  {
    "name" : "Haircut",
    "subService": [
      {"title" : "Tresses",
        "image": "assets/images/blackGirl.png",
        "price": "\$50",
        "time": "40-60 min"},
      {"title" : "Locks",
        "image": "assets/images/blackGirl.png",
        "price": "\$50",
        "time": "40-60 min" }
    ]
  },
  {
    "name" : "Haircut",
    "subService": [
      {"title" : "Tresses",
        "image": "assets/images/blackGirl.png",
        "price": "\$50",
        "time": "40-60 min"},
      {"title" : "Locks",
        "image": "assets/images/blackGirl.png",
        "price": "\$50",
        "time": "40-60 min" }
    ]
  },

];

class Service {
  final String name;
  final List<SubService> subService;

  Service({required this.name, required this.subService});

  factory Service.fromJson(Map<String, dynamic> json) {
    List<SubService> subServiceList = [];
    for (var subService in json['subService']) {
      subServiceList.add(SubService.fromJson(subService));
    }
    return Service(
      name: json['name'] ?? '',
      subService: subServiceList,
    );
  }
}

class SubService {
  final String title;
  final String image;
  final String price;
  final String time;

  SubService({required this.image, required this.title, required this.price, required this.time});

  factory SubService.fromJson(Map<String, dynamic> json) {
    return SubService(
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      price: json['price'] ?? '',
      time: json['time'] ?? '',
    );
  }
}

void printServiceData() {
  for (var service in serviceList) {
    Service currentService = Service.fromJson(service);
    print("Service Name: ${currentService.name}");
    for (var subService in currentService.subService) {
      print("Sub Service Title: ${subService.title}");
      //print("Sub Service Image: ${subService.image}");
      print("Sub Service Price: ${subService.price}");
      print("Sub Service Time: ${subService.time}");
    }
  }
}