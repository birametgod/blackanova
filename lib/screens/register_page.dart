import 'package:blackanova/all_imprts.dart';
import 'package:blackanova/providers/base_model.dart';
import 'package:blackanova/services/authentication.dart';
import 'package:blackanova/widgets/bottom_bar.dart';
import 'package:blackanova/widgets/my_text_button.dart';
import 'package:blackanova/widgets/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

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

  PhoneNumber number = PhoneNumber(isoCode: 'FR');
  String phoneNumber = "";

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
    final providerAuth = Provider.of<BaseModel>(context);

    return Scaffold(
      backgroundColor: AppColors.blackanova.background,
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
                                    phoneNumber = number.phoneNumber!;
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
                              isPasswordVisible: providerAuth.passwordVisible,
                              inputType: TextInputType.text,
                              myController: passwordController,
                              onTap: () {
                                providerAuth.passwordVisible = !providerAuth.passwordVisible;
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
                      RichText(
                          text: TextSpan(
                              text: "Already have an account ?",
                              style:
                              AppTextStyles.blackanova.alegreyaDescription,
                              children: [
                                TextSpan(
                                  text: 'Sign In',
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
                          backgroundColor:
                              AppColors.blackanova.blackanovaYellow,
                          buttonName: 'Register',
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Processing Data')),
                              );
                              createWithEmailAndPassword(emailController.text, passwordController.text, nameController.text, phoneNumber.trim(),context);
                            }
                          }),
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
