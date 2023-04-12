import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {

  bool _login = false;
  bool _passwordVisible = false;

  bool get login => _login;

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