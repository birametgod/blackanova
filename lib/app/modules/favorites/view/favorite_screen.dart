import 'package:blackanova/app/modules/favorites/view/fav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/fav_controller.dart';
import '../../global_widgets/black_white_bg.dart';

class HairdresserListScreen extends StatelessWidget {
  final FavoriteController controller = Get.put(FavoriteController());

  HairdresserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlackWhiteBg(
      bar: AppBar(
        title: Text('Hairdressers', style: Get.textTheme.titleLarge,),
        backgroundColor: Get.theme.canvasColor,
        iconTheme: IconThemeData(color: Get.theme.primaryColor),
        actions: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.favorite_border_outlined,
                    size: 32,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: ClipOval(
                      child: Container(
                        width: 22,
                        height: 22,
                        color: Colors.red,
                        child: Center(
                          child: Obx(() => Text(
                            controller.hairdressers_list.where((hairdresser) => hairdresser['isFavorite'] == true).length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      element: Obx(() {
        if (controller.hairdressers_list.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shrinkWrap: true,
                itemCount: controller.hairdressers_list.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 20, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final hairdresser = controller.hairdressers_list[index];
                  return Card(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                hairdresser['profileImageUrl'],
                                width: 100,
                                height: 100,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () {
                                  controller.toggleFavorite(hairdresser['id']);
                                },
                                icon: Icon(
                                  hairdresser['isFavorite']
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  size: 32,
                                  color: hairdresser['isFavorite']
                                      ? Colors.red
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(hairdresser['name']),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}