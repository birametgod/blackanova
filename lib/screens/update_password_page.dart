import 'package:blackanova/all_imprts.dart';
import 'package:blackanova/widgets/my_text_button.dart';
import 'package:blackanova/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);
  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  bool passwordVisibility = true;
  final newPasswordController = TextEditingController();
  final newPasswordController1 = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    newPasswordController1.dispose();
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
          icon: const Image(
            width: 24,
            color: Colors.black,
            image: Svg('assets/images/back_arrow.svg'),
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
                            "Change password ?",
                             style: AppTextStyles.blackanova.alegreyaSubTitle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                           Text(
                            "You can update your password here.",
                             style: AppTextStyles.blackanova.alegreyaDescription,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          MyTextField(
                            hintText: 'Current Password',
                            isPassword: true,
                            isPasswordVisible: passwordVisibility,
                            inputType: TextInputType.text,
                            myController: passwordController,
                            onTap: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
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
                          ),
                          MyTextField(
                            hintText: 'New Password',
                            isPassword: true,
                            isPasswordVisible: passwordVisibility,
                            inputType: TextInputType.text,
                            myController: newPasswordController,
                            onTap: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
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
                          ),
                          MyTextField(
                            hintText: 'New Password, again',
                            isPassword: true,
                            isPasswordVisible: passwordVisibility,
                            inputType: TextInputType.text,
                            myController: newPasswordController,
                            onTap: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
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

                    const SizedBox(
                      height: 20,
                    ),

                    MyTextButton(
                      backgroundColor: AppColors.blackanova.blackanovaOrange,
                      buttonName: 'Change Password',
                      onTap: () {},
                    ),
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
