import 'package:blackanova/providers/base_model.dart';
import 'package:blackanova/screens/register_page.dart';
import 'package:blackanova/screens/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<BaseModel>(
        builder: (context, model, _) =>
            model.login ? const SignInPage() : const RegisterPage());
  }
}
