import 'package:flutter/material.dart';

class ProfileDetail extends StatelessWidget {
  final String name;
  final String description;
  final String location;
  //final String rating;
  //final String review;
  final String price;
  final String openingHour;

  const ProfileDetail({super.key,
    required this.name,
    required this.description,
    required this.location,
    //required this.rating,
    //required this.review,
    required this.price,
    required this.openingHour
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: const Color(0xFFFFFEF2),
      elevation: 0,
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: Text(description, overflow: TextOverflow.ellipsis, maxLines: 2),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          color: const Color(0xFFFFFEF2),
                          padding: EdgeInsets.all(40.0),
                          child: Text(
                            description,
                            style: TextStyle(fontSize: 20.0),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text("More", style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(" 5"),
                SizedBox(width: 5),
                Icon(Icons.star, size: 15, color: Colors.orange,),
                Icon(Icons.star, size: 15, color: Colors.orange,),
                Icon(Icons.star, size: 15, color: Colors.orange,),
                Icon(Icons.star, size: 15, color: Colors.orange,),
                Icon(Icons.star, size: 15, color: Colors.orange,),
                SizedBox(width: 5),
                Text("126 Reviews")
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_on_outlined),
                const SizedBox(width: 5),
                Text(location),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.watch_later),
                const SizedBox(width: 5),
                Text(openingHour),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.currency_exchange_outlined),
                const SizedBox(width: 5),
                Text(price)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
