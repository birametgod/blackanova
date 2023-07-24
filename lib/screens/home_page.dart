import 'package:blackanova/all_imprts.dart';
import 'package:blackanova/assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackanova.background,
      body: GestureDetector(
        onTap: () async {
          print("tap");
          await FirebaseAuth.instance.signOut();
        },
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child:  Image(
                    image: AssetImage(Assets.askMeAQuestionGirl),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "blackanova.",
                style: AppTextStyles.blackanova.poppinsTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child:  Text(
                  "Bring all the hairstyler in one place",
                  style: AppTextStyles.blackanova.poppinsSubTitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      );
  }
}
