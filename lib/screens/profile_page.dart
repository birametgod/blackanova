import 'package:flutter/material.dart';
import 'package:blackanova/widgets/profile_details.dart';
import 'package:blackanova/models/service_model.dart';
import 'package:blackanova/models/review_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  List<Service> _services = [];
  List<Review> _reviews = [];

  @override
  void initState() {
    super.initState();
    serviceList.forEach((service) {
      _services.add(Service.fromJson(service));
    });
    reviewList.forEach((review) {
      _reviews.add(Review.fromJson(review));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }
    return Scaffold(
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.2,
            child: Image.asset('assets/images/img_afro.jpeg'),
          ),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const ProfileDetailsWidget(
                      name: "Oulita Niang",
                      description:
                      "My name is Oulita, I am a professional hairdresser with 10 years of experience. I specialize in tresses, chignon, locks.",
                      location: "123 Avenue Salside, Dkr",
                      price: "15,000+",
                      openingHour: "Open now 9 AM - 8 PM",
                    ),
                    const SizedBox(height: 20),
                    DefaultTabController(length: 3, initialIndex: 0, child: Column(
                  children: <Widget> [
                    TabBar(
                      unselectedLabelColor: Colors.black, // Text color when unselected
                      labelColor: Colors.white,
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
                    ],

                      indicatorColor: Colors.transparent,
                      indicator: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(35.0)
                      ),
                      //overlayColor: MaterialStateProperty.resolveWith(getColor)
                    ),
                    Container(
                      height: 200,
                      child: TabBarView(children: <Widget>[
                        ListView.builder(
                      itemCount: _services.length,
                        itemBuilder: (BuildContext context, int index) {
                          final service = _services[index];
                          return ExpansionTile(
                            title: Text(service.name),
                            children: service.subService.map((subService) {
                              return ListTile(
                                title: Text(subService.title),
                                leading: Image.asset(subService.image),
                                subtitle: Text('${subService.price} - ${subService.time}'),
                              );
                            }).toList(),
                          );
                        },
                      ),
                        GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          children: List.generate(4, (index) {
                            return GridTile(
                              child: Image.asset('assets/images/image_$index.png'),
                            );
                          }),
                        ),
                        Container(
                          height: 200,
                          child: ListView.builder(
                            itemCount: _reviews.length,
                            itemBuilder: (BuildContext context, int index) {
                              final review = _reviews[index];
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: Image.asset(review.image, width: 50, height: 50, fit: BoxFit.cover,),
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(child: Text(review.name)),
                                            Text(review.date, style: TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                        const Row(
                                          children: [
                                            Icon(Icons.star, size: 15, color: Colors.orange,),
                                            Icon(Icons.star, size: 15, color: Colors.orange,),
                                            Icon(Icons.star, size: 15, color: Colors.orange,),
                                            Icon(Icons.star, size: 15, color: Colors.orange,),
                                            Icon(Icons.star, size: 15, color: Colors.orange,),
                                          ],
                                        ),
                                      ],
                                    ),
                                    //trailing: Text(review.date),
                                    subtitle: Row(
                                      children: [
                                        Expanded(
                                          child: Text(review.comment, overflow: TextOverflow.ellipsis, maxLines: 2),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // Add your GestureDetector action here
                                          },
                                          child: const Text("More", style: TextStyle(fontWeight: FontWeight.bold),),
                                        ),
                                      ],
                                    ),
                                  )
                                ]
                              );
                            },
                          ),
                        )
                      ]),
                    )
                  ],
                ),)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
