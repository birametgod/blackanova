import 'package:blackanova/app/models/user_model.dart';

import '../widgets/haidresser_card.dart';
import 'package:flutter/material.dart';

class HairdresserList extends StatelessWidget {

  final List<User> hairdressers;

  const HairdresserList({ Key? key, required this.hairdressers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: hairdressers.length,
      itemBuilder: (context, index) {
        return HairdresserCard(hairdresser: hairdressers[index], index: index,);
      },
    );
  }
}

