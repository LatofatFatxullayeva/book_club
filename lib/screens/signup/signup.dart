import 'package:book_club/screens/signup/localwidgets/sign_up_form.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButton(
                      
                    ),
                  ],
                ),
                SizedBox(height: 40),
                SignUpForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
