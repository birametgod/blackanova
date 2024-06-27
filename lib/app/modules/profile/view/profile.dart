import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/profile_controller.dart';
import '../../global_widgets/profile_container.dart';
import '../widget/profile_detail.dart';
import '../widget/service_list.dart';
import '../widget/portofolio.dart';
import '../widget/review.dart';
import '../../booking/view/booking.dart';

class Profile extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileContainer(
        element: Column(
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
                    unselectedLabelColor: Get.theme.primaryColor,
                    labelStyle: Get.textTheme.displaySmall?.merge(TextStyle(color: Colors.white)),
                    indicator: BoxDecoration(
                        color: Get.theme.focusColor,
                        borderRadius: BorderRadius.circular(35.0)
                    ),
                    tabs: [
                      Tab(
                        child: Container(
                          child: Center(
                            child: Text(
                              "Services",
                              //style: Get.textTheme.displaySmall,
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Center(
                            child: Text(
                              "Portofolio",
                              //style: Get.textTheme.displaySmall
                          ),
                        ),
                      )),
                      Tab(
                        child: Container(
                          child: Center(
                            child: Text(
                              "Reviews",
                              //style: Get.textTheme.displaySmall
                          ),
                        ),
                      ),)
                    ]
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
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
        button: Obx(() => Container(
          padding: EdgeInsets.only(bottom: 30, left: 10, right: 10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Get.theme.canvasColor,
              shape: BoxShape.rectangle
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Text('${ProfileController.to.totalSubServices} services available', style: Get.textTheme.bodyMedium,)),
              //Spacer(),
              ElevatedButton(
                  onPressed: (){
                    Get.to(() => Booking());
                    print(MediaQuery.of(context).size.width);
                    print(MediaQuery.of(context).size.height);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                      primary: Get.theme.unselectedWidgetColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )
                  ),
                  child: const Text("Book now", style: TextStyle(fontSize: 18, color: Colors.black))
              )
            ],
          ),
        ))
    );
  }
}
