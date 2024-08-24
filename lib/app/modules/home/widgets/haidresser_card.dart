import 'package:blackanova/all_imprts.dart';
import 'package:blackanova/app/models/user_model.dart';
import '../../../models/hairdresser.dart';
import '../../../providers/base_model.dart';
import './hairdresser_profile_dark.dart';
import '../../../widgets/glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../booking/view/booking.dart';


class HairdresserCard extends StatelessWidget {
  final User hairdresser;
  final int index; // The index of this card

  const HairdresserCard({Key? key, required this.hairdresser, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    final isSelected = Provider.of<BaseModel>(context).selectedCardIndex == index;


    return GestureDetector(
      onTap: () {
        Provider.of<BaseModel>(context, listen: false).selectCard(index);
      },
      child: Container(
        width: 350, // Set the width of each card
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Set the border radius
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0), // Set the border radius
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    hairdresser.profileImageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: Stack(
                    children: [
                      if(isSelected)
                        const Positioned(
                            top: 40,
                            left: -100.0,
                            bottom: 0.0,
                            width: 150,
                            child: Glow(color: Color(0xFF14CACC))),
                      if(isSelected)
                        const Positioned(
                            top: -100,
                            left: 100,
                            width: 100,
                            child: Glow(color: Color(0xFF4E9FFF))),
                      if(isSelected)
                        const Positioned(
                            top: -100,
                            left: 30,
                            width: 80,
                            child:  Glow(color: Color(0xFFB557FF))),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Hairdresser's Name
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2.0),
                                  child: Text(
                                    hairdresser.name,
                                    style: AppTextStyles
                                        .blackanova.poppinsTitleForCard,
                                  ),
                                ),
                                // Hairdresser's Rate with Stars (Assuming rate is between 1 to 5)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2.0),
                                  child: isSelected ? Row(
                                    children: [
                                      for (int i = 0; i < hairdresser.rate!; i++)
                                        const Icon(Icons.star,
                                            color: Colors.yellow, size: 12),
                                      for (int i = hairdresser.rate!; i < 5; i++)
                                        const Icon(Icons.star_outline,
                                            color: Colors.yellow, size: 12),
                                    ],
                                  ) : Row(
                                    children: [
                                      for (int i = 0; i < hairdresser.rate!; i++)
                                        const Icon(Icons.star,
                                            color: Colors.white, size: 12),
                                      for (int i = hairdresser.rate!; i < 5; i++)
                                        const Icon(Icons.star_outline,
                                            color: Colors.white, size: 12),
                                    ],
                                  ),
                                ),
                                // Hairdresser's Address
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  child: Text(
                                    hairdresser.address,
                                    style: AppTextStyles
                                        .blackanova.poppinsForDescriptionCard,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Booking Button
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 6.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Booking(id: hairdresser.id.toString(),),//HairdresserProfileDark(hairdresser: hairdresser),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: isSelected ?  const Color(
                                      0xFF14CACA) : Colors.white24, // Set the background color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        35), // Set the border radius
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15)),
                              child: Text('Book now',
                                  style: AppTextStyles
                                      .blackanova.poppinsForButtonCard),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
