import 'package:flutter/material.dart';
import 'package:blackanova/widgets/profile_details.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
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
                      child: const TabBarView(children: <Widget>[
                        Center(
                          child: Text('Services'),
                        ),
                        Center(
                          child: Text('Portfolio'),
                        ),
                        Center(
                          child: Text('Reviews'),
                        ),
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
