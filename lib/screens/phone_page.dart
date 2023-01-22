import 'package:blackanova/all_imprts.dart';
import 'package:blackanova/services/authentication.dart';
import 'package:blackanova/widgets/my_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);
  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController phoneController;
  late FocusNode _phoneFocusNode;
  PhoneNumber number = PhoneNumber(isoCode: 'FR');
  String phoneNumber = "";


  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    // manage after
    _phoneFocusNode = FocusNode();
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
      body: Form(
        key: _formKey,
        child: SafeArea(
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
                          children:[
                            Text(
                              "What is your phone number ?",
                              style: AppTextStyles.blackanova.alegreyaSubTitle,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Please choose a country code and type your phone number.",
                              style: AppTextStyles.blackanova.alegreyaDescription,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
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
                                  initialValue: number,
                                  autoValidateMode: AutovalidateMode.disabled,
                                  textStyle: AppTextStyles.blackanova.alegreyaFieldTitle,
                                  selectorTextStyle: AppTextStyles.blackanova.alegreyaFieldTitle,
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
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      MyTextButton(
                        backgroundColor: AppColors.blackanova.blackanovaOrange,
                        buttonName: 'Continuer',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            signInWithPhoneNumber(context, phoneNumber.trim());
                          }
                        },
                      ),

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
