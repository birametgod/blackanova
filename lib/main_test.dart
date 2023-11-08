import 'package:flutter/material.dart';
import 'package:blackanova/screens/availibility.dart';
import 'package:blackanova/screens/profile_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.ltr, // Replace with your desired text direction
      child: MaterialApp(
        home: Scaffold(
          body: SafeArea(
              top: false,
          bottom: false,
              child: ProfilePage()),
        ),
      ),
    );
  }
}