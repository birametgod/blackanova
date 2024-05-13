import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {

  bool _login = false;
  bool _passwordVisible = false;
  int _selectedCardIndex = -1;
  String _selectedButton = "Services";


  bool get login => _login;
  int get selectedCardIndex => _selectedCardIndex;
  String get selectedButton => _selectedButton;


  void selectCard(int index) {
    _selectedCardIndex = index;
    notifyListeners();
  }

  void selectButton(String buttonName) {
    _selectedButton = buttonName;
    notifyListeners();
  }

  set login(bool login) {
    _login = login;
    notifyListeners();
  }

  bool get passwordVisible => _passwordVisible;

  set passwordVisible(bool passwordVisible) {
    _passwordVisible = passwordVisible;
    notifyListeners();
  }
}