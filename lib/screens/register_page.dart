import 'package:blackanova/all_imprts.dart';
import 'package:blackanova/screens/phone_page.dart';
import 'package:blackanova/screens/signin_page.dart';
import 'package:blackanova/widgets/my_text_button.dart';
import 'package:blackanova/widgets/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordVisible = false;
  PhoneNumber number = PhoneNumber(isoCode: 'FR');
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
        child: Form(
          key: _formKey,
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
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
                                }),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 9, horizontal:20),
                                decoration: BoxDecoration(
                                  boxShadow:  const [
                                    BoxShadow(
                                      color: Color(0xffDDDDDD),
                                      blurRadius: 6.0,
                                      spreadRadius: 2.0,
                                      offset: Offset(0.0, 0.0),
                                    )
                                  ] ,
                                  color: AppColors.blackanova.background,
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    width: 1.4,
                                    color: AppColors.blackanova.background,
                                  ),
                                ),
                                child: InternationalPhoneNumberInput(
                                  onInputChanged: (PhoneNumber number) {
                                    debugPrint(number.phoneNumber);
                                  },
                                  onInputValidated: (bool value) {
                                    debugPrint('$value');
                                  },
                                  autoValidateMode: AutovalidateMode.disabled,
                                  textStyle: AppTextStyles.blackanova.alegreyaFieldTitle,
                                  selectorTextStyle: AppTextStyles.blackanova.alegreyaFieldTitle,
                                  initialValue: number,
                                  textFieldController: phoneController,
                                  formatInput: false,
                                  inputBorder: InputBorder.none,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your number';
                                    }
                                    return null;
                                  },
                                  onSaved: (PhoneNumber number) {
                                    print('On Saved: $number');
                                  },
                                ),
                              ),
                            ),
                            MyTextField(
                              hintText: 'Password',
                              isPassword: true,
                              isPasswordVisible: isPasswordVisible,
                              inputType: TextInputType.text,
                              myController: passwordController,
                              onTap: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              validator: (value) {
                                RegExp passwordValid =
                                    RegExp(AppRegex.authentication.password);
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                } else if (value.length < 6) {
                                  return '6 characters or plus';
                                } else if (!passwordValid.hasMatch(value)) {
                                  return 'Password should contain Capital, small letter & Number & Special';
                                }
                                return null;
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
                          const SizedBox(
                            width: 10.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const SignInPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign In",
                              style: AppTextStyles
                                  .blackanova.alegreyaDescription
                                  .copyWith(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextButton(
                          backgroundColor:
                              AppColors.blackanova.blackanovaYellow,
                          buttonName: 'Register',
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  print('The password provided is too weak.');
                                } else if (e.code == 'email-already-in-use') {
                                  print(
                                      'The account already exists for that email.');
                                }
                              } catch (e) {
                                print(e);
                              }
                            }
                          }),
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>  const PhoneLogin(),
                                  ),
                                );
                              },
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
