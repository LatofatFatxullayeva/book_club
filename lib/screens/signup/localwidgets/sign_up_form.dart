import 'package:book_club/states/current_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/our_container.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _signUpUser(String email, String password, BuildContext context,
      String fullName) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    try {
      String _returnString =
          await _currentUser.signUpUser(email, password, fullName);

      if (_returnString == 'success') {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_returnString),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OurContainer(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            child: Text(
              "Sign Up",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            controller: _fullNameController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
              hintText: 'Full Name',
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.alternate_email),
              hintText: 'Email',
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              hintText: 'Password',
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_open),
              hintText: 'Confirm Password',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.primary)),
            onPressed: () {
              if (_passwordController.text == _confirmPasswordController.text) {
                _signUpUser(_emailController.text, _passwordController.text,
                    context, _fullNameController.text);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Passwords do not match"),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          // TextButton(
          //   onPressed: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => LoginScreen(),
          //       ),
          //     );
          //   },
          //   child: Text("Don't have an account? Sign Up here"),
          // ),
        ],
      ),
    );
  }
}
