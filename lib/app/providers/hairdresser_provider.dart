import 'package:blackanova/app/models/hairdresser.dart';
import 'package:flutter/foundation.dart';

class HairdresserProvider extends ChangeNotifier {
  List<Hairdresser> _hairdressers = [];

  List<Hairdresser> get hairdressers => _hairdressers;

  void setHairdressers(List<Hairdresser> hairdressers) {
    _hairdressers = hairdressers;
    notifyListeners();
  }

// Add methods to add, update, or delete hairdressers as needed.
}
