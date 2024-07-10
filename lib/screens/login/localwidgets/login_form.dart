import 'package:book_club/screens/home/home.dart';
import 'package:book_club/screens/signup/signup.dart';
import 'package:book_club/states/current_user.dart';
import 'package:book_club/widgets/our_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum LoginType {
  email,
  google,
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _loginUser({
  String? email,
  String? password,
  BuildContext? context,
  required LoginType type,
}) async {
  // Check for null context and handle it
  if (context == null) {
    print("Context is required for this operation.");
    return;
  }

  // Initialize the CurrentUser only if context is available
  CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);

  try {
    String? returnString;

    switch (type) {
      case LoginType.email:
        // Check for null email and password and handle it
        if (email == null || password == null) {
          print("Email and password are required for email login.");
          return;
        }
        returnString = await currentUser.loginUserWithEmail(email, password);
        break;
      case LoginType.google:
        returnString = await currentUser.loginUserWithGoogle();
        break;
      default:
        print("Invalid login type.");
        return;
    }

    if (returnString == "success") {
      Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
                (route) => false,
              );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(returnString),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  } catch (e) {
    print(e);
  }
  print("Ishladi2");
}

  Widget _googleButton() {
    return OutlinedButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
        elevation: const WidgetStatePropertyAll(0),
      ),
      onPressed: () {
        _loginUser(
          type: LoginType.google,
          context: context,
        );
        print("Ishladi");
      },
      child: const Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/google.png"),
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OurContainer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            child: Text(
              "Log In",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.alternate_email),
              hintText: 'Email',
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              hintText: 'Password',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.primary)),
            onPressed: () {
              _loginUser(
                type: LoginType.email,
                email: _emailController.text,
                password: _passwordController.text,
                context: context,
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "Log In",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SignupScreen(),
                ),
              );
            },
            child: const Text("Don't have an account? Sign Up here"),
          ),
          _googleButton(),
        ],
      ),
    );
  }
}
