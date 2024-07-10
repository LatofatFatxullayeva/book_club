import 'package:book_club/screens/login/localwidgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                Padding(
                  padding: EdgeInsets.all(60),
                  child: Image.asset("assets/logo.png"),
                ),
                LoginForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
