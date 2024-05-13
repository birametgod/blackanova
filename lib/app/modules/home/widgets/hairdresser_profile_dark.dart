import 'package:blackanova/all_imprts.dart';
import 'package:blackanova/app/models/user_model.dart';
import '../../../models/hairdresser.dart';
import '../../../providers/base_model.dart';
import '../../../providers/hairdresser_provider.dart';
import '../../../widgets/glow.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HairdresserProfileDark extends StatefulWidget {
  final User hairdresser;

  const HairdresserProfileDark({Key? key, required this.hairdresser})
      : super(key: key);

  @override
  State<HairdresserProfileDark> createState() => _HairdresserProfileDarkState();
}

class _HairdresserProfileDarkState extends State<HairdresserProfileDark> {
  late List<Hairdresser> hairdressers = []; // Declare hairdressers list
  String selectedButton = "Services"; // Track the selected button

  Row buildButtonRow(List<String> buttonNames, String selectedButton) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: buttonNames.map((buttonName) {
        return customButtonStyle(buttonName, selectedButton);
      }).toList(),
    );
  }

  Widget customButtonStyle(String buttonName, String selectedButton) {
    return GestureDetector(
      onTap: () {
        Provider.of<BaseModel>(context, listen: false).selectButton(buttonName);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.0),
          color:
              selectedButton == buttonName ? Colors.black : Colors.transparent,
        ),
        child: Text(
          buttonName,
          style: const TextStyle(
            color: Colors.white, // Text color
          ),
        ),
      ),
    );
  }

  Widget buildDataSection<T>(Future<List<T>> Function() fetchData,
      Widget Function(List<T>) itemBuilder) {
    return FutureBuilder<List<T>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final data = snapshot.data!;
          return Expanded(
            child: itemBuilder(data),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        return const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Future<List<Hairdresser>> fetchHairdressers() async {
    // Replace this with your actual list of hairdressers
    final hairdressers = [
      Hairdresser(
          name: 'Oulita Niang',
          profileImageUrl: "assets/images/img.png",
          description:
              'My name is Hama and I am a professional hairdresser with 10 years of experience. I specialize',
          rate: 3,
          address: '14 boulevard edouard qndk, villeurbanne',
          latitude: 14.7459, // Example latitude value
          longitude: -17.4721, // Example longitude value
          minimumPrice: 25),
      Hairdresser(
          name: 'Johne Doeee',
          profileImageUrl: "assets/images/ethiopian.png",
          description: 'Description of Hairdresser 2',
          rate: 4,
          address: '79 cours de la liberte, lyon',
          latitude: 14.7434, // Example latitude value
          longitude: -17.4854, // Example longitude value
          minimumPrice: 25),
      // Add more hairdressers as needed
    ];

    return hairdressers;
  }

  Future<List<PortfolioItem>> fetchPortfolio() async {
    // Replace this with your actual list of portfolio items
    final portfolioItems = [
      const PortfolioItem(
        imageUrl: 'assets/images/img.png',
        description: "Description of",
      ),
      const PortfolioItem(
        imageUrl: 'assets/images/ethiopian.png',
        description: "Description of",
      ),
      const PortfolioItem(
        imageUrl: 'assets/images/ethiopian.png',
        description: "Description of",
      ),
      const PortfolioItem(
        imageUrl: 'assets/images/img.png',
        description: "Description of",
      ),
      // Add more portfolio items as needed
    ];

    return portfolioItems;
  }

  Future<List<Review>> fetchReviews() async {
    // Replace this with your actual list of reviews
    final reviews = [
      const Review(
          userName: 'Review 1',
          comment: 'Description of Review 1',
          rating: 3,
          userImg: 'assets/images/ethiopian.png'),
      const Review(
          userName: 'Review 2',
          comment: 'Description of Review 2',
          rating: 2,
          userImg: 'assets/images/img.png'),
      // Add more reviews as needed
    ];

    return reviews;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Use the provider to get the selected button
    final selectedButton = Provider.of<BaseModel>(context).selectedButton;

    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                widget.hairdresser.profileImageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 5,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 3 / 5,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0))),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  child: Stack(
                    children: [
                      const Positioned(
                          right: 5.0,
                          bottom: 20.0,
                          width: 70,
                          child: Glow(color: Color(0xFF14CACC))),
                      const Positioned(
                          top: 20,
                          left: -100.0,
                          bottom: 0.0,
                          width: 200,
                          child: Glow(color: Color(0xFF14CACC))),
                      const Positioned(
                          top: -90,
                          left: 70,
                          width: 150,
                          child: Glow(color: Color(0xFF4E9FFF))),
                      const Positioned(
                          top: -100,
                          left: 60,
                          width: 130,
                          child: Glow(color: Color(0xFFB557FF))),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          // Hairdresser's Name
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.0),
                            child: Text(
                              widget.hairdresser.name,
                              style: AppTextStyles.blackanova.poppinsSubTitle,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          // Hairdresser's description
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.0),
                            child: ExpandableText(
                              widget.hairdresser.bio,
                              expandText: 'more',
                              collapseText: 'less',
                              linkColor: Colors.white, // Customize link color if needed
                              linkStyle: const TextStyle(fontWeight: FontWeight.bold),
                              style: AppTextStyles.blackanova.poppinsDescription,
                            )
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.0),
                            child: Row(
                              children: [
                                // Hairdresser's Rate with Stars (Assuming rate is between 1 to 5)
                                Row(
                                  children: [
                                    for (int i = 0;
                                        i < widget.hairdresser.rate!;
                                        i++)
                                      const Icon(Icons.star,
                                          color: Colors.yellow, size: 12),
                                    for (int i = widget.hairdresser.rate!;
                                        i < 5;
                                        i++)
                                      const Icon(Icons.star_outline,
                                          color: Colors.yellow, size: 12),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "123 reviews",
                                  style: AppTextStyles
                                      .blackanova.poppinsForDescriptionCard,
                                ),
                              ],
                            ),
                          ),
                          // Hairdresser's Address
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white38,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  widget.hairdresser.address,
                                  style: AppTextStyles
                                      .blackanova.poppinsForDescriptionCard,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: Colors.white38,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "Open now 9 AM - 8 PM",
                                  style: AppTextStyles
                                      .blackanova.poppinsForDescriptionCard,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Padding(
                            padding:  EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.0),
                            child: Row(
                              children: [
                                 Icon(
                                  Icons.monetization_on_outlined,
                                  color: Colors.white38,
                                ),
                                 SizedBox(
                                  width: 10.0,
                                )
                                /*Text(
                                  widget.hairdresser.minimumPrice.toString(),
                                  style: AppTextStyles
                                      .blackanova.poppinsForDescriptionCard,
                                ),*/
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          buildButtonRow(["Services", "Portfolio", "Reviews"],
                              selectedButton),
                          const SizedBox(
                            height: 10.0,
                          ),
                          if (selectedButton == "Services")
                            buildDataSection<Hairdresser>(
                              fetchHairdressers,
                              (hairdressers) => ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                itemCount: hairdressers.length,
                                itemBuilder: (context, index) {
                                  final hairdresser = hairdressers[index];
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            hairdresser.profileImageUrl,
                                            width: 60.0,
                                            height: 60.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              hairdresser.name,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Icon(
                                                  Icons
                                                      .monetization_on_outlined,
                                                  color: Colors.white38,
                                                  size: 20.0,
                                                ),
                                                const SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "\$25 - \$60",
                                                  style: AppTextStyles
                                                      .blackanova
                                                      .poppinsForDescriptionCard,
                                                ),
                                                const SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "\$25 - \$60",
                                                  style: AppTextStyles
                                                      .blackanova
                                                      .poppinsForDescriptionCard,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          if (selectedButton == "Portfolio")
                            buildDataSection<PortfolioItem>(
                              fetchPortfolio,
                              (portfolioItems) => GridView.builder(
                                padding: const EdgeInsets.only(top: 0.0),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount: portfolioItems.length,
                                itemBuilder: (context, index) {
                                  final portfolioItem = portfolioItems[index];
                                  return PortfolioItem(
                                      imageUrl: portfolioItem.imageUrl,
                                      description: portfolioItem.description);
                                },
                              ),
                            ),
                          if (selectedButton == "Reviews")
                            buildDataSection<Review>(
                              fetchReviews,
                              (reviews) => ListView.builder(
                                padding: const EdgeInsets.only(top: 0.0),
                                itemCount: reviews.length,
                                itemBuilder: (context, index) {
                                  final review = reviews[index];
                                  return Review(
                                    userName: review.userName,
                                    comment: review.comment,
                                    rating: review.rating,
                                    userImg: review.userImg,
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                      // Booking Button
                    ],
                  ),
                ),
              ),
            ],
          )),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.09,
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '13 services available',
              style: AppTextStyles.blackanova.poppinsForDescriptionCard,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: const Color(0xFF14CACA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15),
                ),
                child: Text(
                  'Book now',
                  style: AppTextStyles.blackanova.poppinsForButtonCard,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PortfolioItem extends StatelessWidget {
  final String imageUrl;
  final String description;

  const PortfolioItem(
      {super.key, required this.imageUrl, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imageUrl,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height * 0.2,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class Review extends StatelessWidget {
  final String userName;
  final String comment;
  final int rating;
  final String userImg;

  const Review(
      {super.key,
      required this.userName,
      required this.comment,
      required this.rating,
      required this.userImg});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Circle picture on the left
              Row(
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      userImg, // replace with the actual image path
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Grouped username and stars on the right
                      Text(
                        userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          for (int i = 0; i < 3; i++)
                            const Icon(Icons.star,
                                color: Colors.yellow, size: 12),
                          for (int i = 3; i < 5; i++)
                            const Icon(Icons.star_outline,
                                color: Colors.yellow, size: 12),
                        ],
                      ),
                      // Comment
                      /*Text(
                    comment,
                    style: const TextStyle(color: Colors.white),
                  ),*/
                    ],
                  ),
                  const SizedBox(width: 8.0),
                ],
              ),
              // Date on the right
              const Text(
                '7 Mars 2023', // Replace with the actual date
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          const ExpandableText(
            "'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'",
            expandText: 'more',
            collapseText: 'less',
            linkColor: Colors.white, // Customize link color if needed
            linkStyle: TextStyle(fontWeight: FontWeight.bold),
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500
            ),
          )
        ],
      ),
    );
  }
}
