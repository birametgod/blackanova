import 'package:blackanova/all_imprts.dart';
import 'package:blackanova/providers/base_model.dart';
import 'package:blackanova/services/authentication.dart';
import 'package:blackanova/widgets/bottom_bar.dart';
import 'package:blackanova/widgets/my_text_button.dart';
import 'package:blackanova/widgets/my_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {

  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerAuth = Provider.of<BaseModel>(context);

    return Scaffold(
      backgroundColor: AppColors.blackanova.background,
      /*appBar: AppBar(
        backgroundColor: AppColors.blackanova.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image(
            width: 24,
            color: Colors.black,
            image: Svg(Assets.backArrowSvg),
          ),
        ),
      ),*/
      body: SafeArea(
        // Build a Form widget using the _formKey created above.
        child: Form(
          key: _formKey,
          // to make page scrollable
          child: CustomScrollView(
            reverse: true,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome back!",
                              style: AppTextStyles.blackanova.alegreyaTitle,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "You've been missed.",
                              style: AppTextStyles.blackanova.alegreyaSubTitle,
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            MyTextField(
                              hintText: 'Email',
                              inputType: TextInputType.emailAddress,
                              myController: emailController,
                              validator: (value) {
                                RegExp regex =
                                    RegExp(AppRegex.authentication.email);
                                if (value == null || value.isEmpty) {
                                  return 'Please enter email';
                                } else if (!regex.hasMatch(value)) {
                                  return 'Enter valid email';
                                }
                                return null;
                              },
                            ),
                            MyTextField(
                              hintText: 'Password',
                              isPassword: true,
                              isPasswordVisible: providerAuth.passwordVisible,
                              inputType: TextInputType.text,
                              myController: passwordController,
                              onTap: () {
                                providerAuth.passwordVisible = !providerAuth.passwordVisible;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                } else if (value.length < 6) {
                                  return '6 characters or plus';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Don't have an account ?",
                              style:
                                  AppTextStyles.blackanova.alegreyaDescription,
                              children: [
                            TextSpan(
                              text: 'Register',
                              style: const TextStyle(color: Colors.red),
                              // Single tapped.
                              recognizer: TapGestureRecognizer()..onTap = () {
                                providerAuth.login = !providerAuth.login;
                              },
                            ),
                          ])),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextButton(
                        backgroundColor: AppColors.blackanova.blackanovaOrange,
                        buttonName: 'Sign In',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            signInWithEmailAndPassword(emailController.text, passwordController.text, context);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                       BottomBar(parentContext: context,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}