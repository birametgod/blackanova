import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blackanova/modules/profile/controller/profile_controller.dart';
import 'package:blackanova/modules/profile/widget/profile_detail.dart';
import 'package:blackanova/modules/profile/widget/service_list.dart';
import 'package:blackanova/modules/profile/widget/portofolio.dart';
import 'package:blackanova/modules/profile/widget/review.dart';

class Profile extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      body: Stack(
        children: [
          Image.asset('assets/images/img_afro.jpeg'),
          AnimatedBuilder(
              animation: controller.topPosition,
              builder: (context, child) {
                return Transform.translate(
                    offset: Offset(0, controller.topPosition.value),
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      controller.updateTopPosition(details.delta);
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFEF2),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(52.0),
                                topRight: Radius.circular(52.0),
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: const Color(0xFF3A5160).withOpacity(0.2),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const ProfileDetail(
                                  name: "Oulita Niang",
                                  description:
                                  "My name is Oulita, I am a professional hairdresser with 10 years of experience. I specialize in tresses, chignon, locks.",
                                  location: "123 Avenue Salside, Dkr",
                                  price: "15,000+",
                                  openingHour: "Open now 9 AM - 8 PM",
                                ),
                                DefaultTabController(length: 3, initialIndex: 0, child: Column(
                                  children: <Widget> [
                                    TabBar(
                                      unselectedLabelColor: Colors.black,
                                        labelColor: Colors.white,
                                        indicatorColor: Colors.transparent,
                                        indicator: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(35.0)
                                        ),
                                        tabs: [
                                          Tab(
                                            child: Container(
                                              child: const Center(
                                                child: Text(
                                                  "Services",
                                                ),
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            child: Container(
                                              child: const Center(
                                                child: Text(
                                                  "Portofolio",
                                                ),
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            child: Container(
                                              child: const Center(
                                                child: Text(
                                                  "Reviews",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height / 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: TabBarView(
                                            children: <Widget> [
                                          ServiceList(),
                                          const Portofolio(),
                                          Review()
                                        ]),
                                      ),
                                    )
                                  ],
                                ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.only(left: 25),
        decoration: const BoxDecoration(
          color: Color(0xFFFFFEF2),
          shape: BoxShape.rectangle
        ),
        child: Row(
          children: [
            const Text("13 services available", style: TextStyle(fontSize: 18),),
            Spacer(),
            ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                  primary: const Color(0xFFFFCF00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )
                ),
                child: const Text("Book now", style: TextStyle(fontSize: 18, color: Colors.black))
            )
          ],
        ),
      ),
    );
  }
}
