import 'package:blackanova/screens/home_page.dart';
import 'package:blackanova/screens/main_page.dart';
import 'package:blackanova/screens/onboarding_page.dart';
import 'package:blackanova/screens/start_page.dart';
import 'package:flutter/material.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case 'onboarding':
        return MaterialPageRoute(builder: (_) => const OnBoardingPage());
      case 'start':
        return MaterialPageRoute(builder: (_) => const StartPage());
      case 'main':
        return MaterialPageRoute(builder: (_) => const MainPage());
      case 'home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No Route defined for ${settings.name}')
            ),
          );
        });
    }
  }
}