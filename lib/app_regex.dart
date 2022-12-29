class AppRegex {
  static Authentication authentication = Authentication();
}

class Authentication {
  String email = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  String password = r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)';
}