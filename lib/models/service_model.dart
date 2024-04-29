
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
      name: json['name'],
      subService: subServiceList,
    );
  }
}

class SubService {
  final String title;
  final String image;
  final String price;
  final String time;

  SubService({required this.title, required this.image, required this.price, required this.time});

  factory SubService.fromJson(Map<String, dynamic> json) {
    return SubService(
      title: json['title'],
      image: json['image'],
      price: json['price'],
      time: json['time'],
    );
  }
}

void printServiceData() {
  for (var service in serviceList) {
    Service currentService = Service.fromJson(service);
    print("Service Name: ${currentService.name}");
    for (var subService in currentService.subService) {
      print("Sub Service Title: ${subService.title}");
      print("Sub Service Image: ${subService.image}");
      print("Sub Service Price: ${subService.price}");
      print("Sub Service Time: ${subService.time}");
    }
  }
}