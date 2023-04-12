import 'package:blackanova/all_imprts.dart';
import 'package:blackanova/services/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


class BottomBar extends StatefulWidget {

  final BuildContext parentContext;

  const BottomBar({Key? key, required this.parentContext}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  final _formKey = GlobalKey<FormState>();
  late TextEditingController phoneController;
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
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () {
              signInWithGoogle(context);
            },
            icon: const Icon(
              FontAwesomeIcons.google,
              color: Colors.redAccent,
            )),
        IconButton(
            onPressed: () {
              showDialog(
                  context: widget.parentContext,
                  builder: (_){
                    return  AlertDialog(
                      title: Text("What is your phone number ?",
                          style: AppTextStyles.blackanova.alegreyaSubTitle),
                      contentPadding: const EdgeInsets.all(20.0),
                      content: Form(
                        key: _formKey,
                        child: Column(
                          children:[
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
                        ) ,
                      ),
                      actions: [
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: Text('Cancel',
                              style:
                              AppTextStyles.blackanova.alegreyaSubTitleForAlertDialog),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Processing Data')),
                                );
                                await signInWithPhoneNumber(widget.parentContext, phoneNumber.trim());
                              }
                            },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFFE7C56),
                          ),
                            child: Text(
                              'Confirm',
                              style: AppTextStyles.blackanova.regularPoppins,
                            ),

                        )
                      ],
                    );
                  }
              );
            },
            icon: const Icon(
              FontAwesomeIcons.phone,
              color: Colors.orangeAccent,
            ))
      ],
    );
  }
}
