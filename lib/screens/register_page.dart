import 'package:blackanova/all_imprts.dart';
import 'package:blackanova/widgets/my_password_field.dart';
import 'package:blackanova/widgets/my_text_button.dart';
import 'package:blackanova/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passwordVisibility = true;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  //FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackanova.background ,
      appBar: AppBar(
        backgroundColor: AppColors.blackanova.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:  Image(
            width: 24,
            color: Colors.black,
            image: Svg(Assets.backArrowSvg),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            "Register",
                            style: AppTextStyles.blackanova.alegreyaTitle,
                          ),
                           Text(
                            "Create new account to get started.",
                            style: AppTextStyles.blackanova.alegreyaSubTitle,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          MyTextField(
                            hintText: 'Name',
                            inputType: TextInputType.name,
                            myController: nameController,
                          ),
                          MyTextField(
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                            myController: emailController,
                          ),
                          MyTextField(
                            hintText: 'Phone',
                            inputType: TextInputType.phone,
                            myController: phoneController,
                          ),
                          MyPasswordField(
                            isPasswordVisible: passwordVisibility,
                            myController: passwordController,
                            onTap: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          "Already have an account ?",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.blackanova.alegreyaDescription,
                        ),
                        const SizedBox(width: 10.0,),
                        Text(
                          "Sign In",
                          style: AppTextStyles.blackanova.alegreyaDescription.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextButton(
                      backgroundColor: AppColors.blackanova.blackanovaYellow,
                      buttonName: 'Register',
                      onTap: () async {
                        try {
                           await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: (){},
                            icon: const Icon(FontAwesomeIcons.facebook,color: Colors.blue)
                        ),
                        IconButton(
                            onPressed: (){},
                            icon: const Icon(FontAwesomeIcons.google,color: Colors.redAccent,)
                        ),
                        IconButton(
                            onPressed: (){},
                            icon: const Icon(FontAwesomeIcons.phone,color: Colors.orangeAccent,)
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}