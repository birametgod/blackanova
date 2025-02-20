import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blackanova/app/models/user_model.dart' as userModel;

class FavoriteController extends GetxController {
  var hairdressers = <userModel.User>[].obs;
  var hairdressers_list = <Map<String, dynamic>>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    loadHairdressers();
    fetchFavoritesFromFirebase(); // Fetch favorites when the controller is initialized
  }

  List<Map<String, Object?>> fetchHairdressers() {
    return hairdressers.map((hairdresser) => {
      'id': hairdresser.id,
      'name': hairdresser.name,
      'profileImageUrl': hairdresser.profileImageUrl,
      'bio': hairdresser.bio,
      'address': hairdresser.address,
      'latitude': hairdresser.latitude,
      'longitude': hairdresser.longitude,
      'isFavorite': false,
    }).toList();
  }

  void loadHairdressers() {
    hairdressers.value = [
      userModel.User(
        name: 'Oulita Niang',
        profileImageUrl: "assets/images/img.png",
        bio: 'My name is Hama and I am a professional hairdresser with 10 years of experience. I specialize in the late...',
        address: '14 boulevard edouard qndk, villeurbanne',
        latitude: 14.7459,
        longitude: -17.4721,
        id: '8IihfI6zhUb78zSCIZO6',
      ),
      userModel.User(
        name: 'Yousra Adechokan',
        profileImageUrl: "assets/images/ethiopian.png",
        bio: 'Description of Hairdresser 2',
        rate: 4,
        address: '79 cours de la liberte, lyon',
        latitude: 14.7434,
        longitude: -17.4854,
        id: '1gprLLuG0DquNK5zetYZ',
      ),
      // Add more hairdressers as needed
      userModel.User(
        name: 'Seynabou Trawaré',
        profileImageUrl: "assets/images/ethiopian.png",
        bio: 'Description of Hairdresser 2',
        rate: 4,
        address: '79 cours de la liberte, lyon',
        latitude: 14.7434,
        longitude: -17.4854,
        id: 'Fu53ADecnofLWq3KYUbU',
      ),
      userModel.User(
        name: 'Maria Keita',
        profileImageUrl: "assets/images/ethiopian.png",
        bio: 'Description of Hairdresser 2',
        rate: 4,
        address: '79 cours de la liberte, lyon',
        latitude: 14.7434,
        longitude: -17.4854,
        id: 'iij1kJfnv5ODntcCZykY',
      ),
      userModel.User(
        name: 'Sonia De Carvalho',
        profileImageUrl: "assets/images/ethiopian.png",
        bio: 'Description of Hairdresser 2',
        rate: 4,
        address: '79 cours de la liberte, lyon',
        latitude: 14.7434,
        longitude: -17.4854,
        id: 'tF8ivhR9Ne19dH0OgC9q',
      ),
    ];
    hairdressers_list.value = fetchHairdressers();
  }

  void toggleFavorite(String id) {
    int index = hairdressers_list.indexWhere((hairdresser) => hairdresser['id'] == id);
    if (index != -1) {
      hairdressers_list[index]['isFavorite'] = !hairdressers_list[index]['isFavorite'];
      hairdressers_list.refresh(); // Refresh the observable list

      if (hairdressers_list[index]['isFavorite']) {
        addFavoriteToFirebase(hairdressers_list[index]);
      } else {
        removeFavoriteFromFirebase(hairdressers_list[index]['id']);
      }
    }
  }

  Future<void> addFavoriteToFirebase(Map<String, dynamic> hairdresser) async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('favorites')
            .doc(hairdresser['id'])
            .set(hairdresser);
      } catch (e) {
        print('Error adding favorite: $e');
      }
    }
  }

  Future<void> removeFavoriteFromFirebase(String id) async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('favorites')
            .doc(id)
            .delete();
      } catch (e) {
        print('Error removing favorite: $e');
      }
    }
  }

  Future<void> fetchFavoritesFromFirebase() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final snapshot = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('favorites')
            .get();

        for (var doc in snapshot.docs) {
          int index = hairdressers_list.indexWhere((hairdresser) => hairdresser['id'] == doc.id);
          if (index != -1) {
            hairdressers_list[index]['isFavorite'] = true;
          }
        }
        hairdressers_list.refresh();
      } catch (e) {
        print('Error fetching favorites: $e');
      }
    }
  }
}