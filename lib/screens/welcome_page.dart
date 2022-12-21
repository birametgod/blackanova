import 'package:blackanova/all_imprts.dart';
import 'package:blackanova/screens/register_page.dart';
import 'package:blackanova/screens/signin_page.dart';
import 'package:blackanova/widgets/my_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackanova.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Flexible(
                child: Column(
                  children: [
                    Center(
                      child: Container(
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
                      style: AppTextStyles.blackanova.alegreyaTitle,
                      textAlign: TextAlign.center,

                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child:  Text(
                        "Bring all the hairstyler in one place",
                        style: AppTextStyles.blackanova.alegreyaSubTitle,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.blackanova.background,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: MyTextButton(
                        backgroundColor: AppColors.blackanova.blackanovaYellow,
                        buttonName: 'Register',
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const RegisterPage()));
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: MyTextButton(
                        backgroundColor: AppColors.blackanova.blackanovaOrange,
                        buttonName: 'Sign In',
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => SignInPage(),
                              ));
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}