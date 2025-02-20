import 'package:blackanova/app/modules/favorites/view/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/fav_controller.dart';

class FavoritesPage extends StatelessWidget {
  final FavoriteController controller = Get.put(FavoriteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites', style: TextStyle(fontSize: 24),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(HairdresserListScreen());
            },
          ),
        ],
      ),
      body:Obx(() {
        final favoriteHairdressers = controller.hairdressers_list
            .where((hairdresser) => hairdresser['isFavorite'] == true)
            .toList();
        if (favoriteHairdressers.isEmpty) {
          return Center(
            child: Text(
              'No favorites yet',
              style: TextStyle(fontSize: 18),
            ),
          );
        }
        return ListView.builder(
          itemCount: favoriteHairdressers.length,
          itemBuilder: (context, index) {
            final hairdresser = favoriteHairdressers[index];
            return ListTile(
              leading: Image.asset(hairdresser['profileImageUrl']),
              title: Text(hairdresser['name']),
              trailing: IconButton(
                icon: Icon(
                  hairdresser['isFavorite']
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: hairdresser['isFavorite']
                      ? Colors.red
                      : Colors.grey,
                ),
                onPressed: () => controller.toggleFavorite(hairdresser['id']),
              ),
            );
          },
        );
      }),
    );
  }
}
