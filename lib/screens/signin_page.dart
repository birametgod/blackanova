import 'package:blackanova/all_imprts.dart';
import 'package:blackanova/screens/register_page.dart';
import 'package:blackanova/widgets/my_password_field.dart';
import 'package:blackanova/widgets/my_text_button.dart';
import 'package:blackanova/widgets/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
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
    return Scaffold(
      backgroundColor: AppColors.blackanova.background,
      appBar: AppBar(
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
      ),
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
                              "Welcome back.",
                              style: AppTextStyles.blackanova.alegreyaTitle,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "You've been missed!",
                              style: AppTextStyles.blackanova.alegreyaSubTitle,
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            MyTextField(
                              hintText: 'Phone, email or username',
                              inputType: TextInputType.text,
                              myController: emailController,
                            ),
                            TextFormField(
                              controller: emailController,
                              style: AppTextStyles.blackanova.alegreyaFieldTitle.copyWith(color: Colors.black),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Phone, email or username',
                                hintStyle: AppTextStyles.blackanova.alegreyaFieldTitle,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                              ),
                              validator: (value) {
                                if(value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            MyPasswordField(
                              myController: passwordController,
                              isPasswordVisible: isPasswordVisible,
                              onTap: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                            TextFormField(
                              controller: passwordController,
                              style: AppTextStyles.blackanova.alegreyaFieldTitle.copyWith(color: Colors.black),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: IconButton(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onPressed: () {
                                      setState(() {
                                        isPasswordVisible = !isPasswordVisible;
                                      });
                                    },
                                    icon: Icon(
                                      isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'Password',
                                hintStyle: AppTextStyles.blackanova.alegreyaFieldTitle,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                              ),
                              validator: (value) {
                                if(value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account ?",
                            style: AppTextStyles.blackanova.alegreyaDescription,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Register',
                              style: AppTextStyles
                                  .blackanova.alegreyaDescription
                                  .copyWith(
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      ),
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
                              onPressed: () {},
                              icon: const Icon(FontAwesomeIcons.facebook,
                                  color: Colors.blue)),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                FontAwesomeIcons.google,
                                color: Colors.redAccent,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                FontAwesomeIcons.phone,
                                color: Colors.orangeAccent,
                              ))
                        ],
                      )
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
