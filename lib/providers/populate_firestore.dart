import 'package:cloud_firestore/cloud_firestore.dart';

void populateFirestore() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    for (var categoryData in serviceLists) {
      String category = categoryData['category'];
      List<Map<String, dynamic>> services = List<Map<String, dynamic>>.from(categoryData['services']);

      for (var service in services) {
        String title = service['title'];
        List<String> types = List<String>.from(service['type'] ?? []);

        // Add the category if it doesn't exist
        await firestore.collection('categories').doc(category).set({});

        // Add the service
        await firestore.collection('categories').doc(category).collection('service').doc(title).set({
          'title': title,
          'types': types,
        });
      }
    }
    print('Firestore population complete!');
  } catch (e) {
    print('Error populating Firestore: $e');
  }
}

Future<void> getDataFromFirestore() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    // Get all categories
    QuerySnapshot categoriesSnapshot = await firestore.collection('categories')
        .get();
    List<DocumentSnapshot> categoryDocuments = categoriesSnapshot.docs;

    for (DocumentSnapshot categoryDoc in categoryDocuments) {
      String category = categoryDoc.id;
      print('Category: $category');

      // Get all services within the category
      QuerySnapshot servicesSnapshot = await categoryDoc.reference.collection(
          'service').get();
      List<DocumentSnapshot> serviceDocuments = servicesSnapshot.docs;

      for (DocumentSnapshot serviceDoc in serviceDocuments) {
        Object? title = serviceDoc.data();
        print('  Service: $title');
      }
    }
  } catch (e) {
    print('Error getting data from Firestore: $e');
  }
}

class Service {
  final String title;
  final List<String> types;

  Service({
    required this.title,
    required this.types,
  });

  factory Service.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Service(
      title: data['title'] ?? '',
      types: List<String>.from(data['types'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'types': types,
    };
  }
}

class Category {
  final String name;
  List<Service> services;

  Category({
    required this.name,
    required this.services,
  });

  factory Category.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    List<Service> services = (data['services'] as List<dynamic>? ?? [])
        .map((serviceData) => Service.fromFirestore(serviceData))
        .toList();
    return Category(
      name: doc.id,
      services: services,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'services': services.map((service) => service.toFirestore()).toList(),
    };
  }
}

Future<List<Category>> getDataFromFirestore2() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Category> categories = [];

  try {
    // Get all categories
    QuerySnapshot categoriesSnapshot = await firestore.collection('categories').get();
    List<DocumentSnapshot> categoryDocuments = categoriesSnapshot.docs;

    for (DocumentSnapshot categoryDoc in categoryDocuments) {
      Category category = Category.fromFirestore(categoryDoc);

      // Get services from the 'service' subcollection
      QuerySnapshot servicesSnapshot = await categoryDoc.reference.collection('service').get();
      List<DocumentSnapshot> serviceDocuments = servicesSnapshot.docs;

      List<Service> services = serviceDocuments.map((serviceDoc) => Service.fromFirestore(serviceDoc)).toList();
      category.services = services;

      categories.add(category);
    }
  } catch (e) {
    print('Error getting data from Firestore: $e');
  }

  return categories;
}

Future<void> onInit() async {
  List<Category> categories = await getDataFromFirestore2();
  for (Category category in categories) {
    print('Category Name: ${category.name}');
    print('Category Service: ${category.services}');
    // Iterate over the services in each category and print them
    for (Service service in category.services) {
      print(service.title);
      print(service.types);
    }
  }
}


List<Map<String, dynamic>> serviceLists = [];

class UserService {
  final String userId;
  final Service service;
  final String category;
  final double price;
  final int time;

  UserService({
    required this.userId,
    required this.service,
    required this.category,
    required this.price,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'service': service.toFirestore(), // Convert the service to a map
      'category': category,
      'price': price,
      'time': time,
    };
  }
}

Future<void> addUserService(String userId, Service service, String category, double price, int time) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference userServices = firestore.collection('userService');

    // Convert the service to a map using the toFirestore method
    Map<String, dynamic> serviceData = service.toFirestore();

    // Add the user service data to the collection
    await userServices.add({
      'userId': userId,
      'service': serviceData,
      'category' : category,
      'price': price,
      'time': time,
    });
  } catch (e) {
    print('Error adding user service: $e');
    throw e;
  }
}

Future<void> addToUserServiceCollection(String userId, double price, int time) async {
  try {
    // Fetch the first five services from Firestore
    List<Category> categories = await getDataFromFirestore2();

    // Get the first five services
    List<Service> servicesToAdd = [];
    for (Category category in categories) {
      if (servicesToAdd.length >= 5) break;
      servicesToAdd.addAll(category.services.take(5 - servicesToAdd.length));
      servicesToAdd.addAll(category.services.take(servicesToAdd.length - 5));
    }

    // Add each service to the 'userService' collection
    for (Service service in servicesToAdd) {
      // Get the categoryName of the category containing the service
      String category = categories.firstWhere((category) => category.services.contains(service)).name;

      await addUserService(userId, service, category, price, time);
    }

    print('Services added to userService collection successfully!');
  } catch (e) {
    print('Error adding services to userService collection: $e');
    throw e;
  }
}




