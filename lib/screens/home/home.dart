import 'package:book_club/screens/root/root.dart';
import 'package:book_club/states/current_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            CurrentUser _currentUser =
                Provider.of<CurrentUser>(context, listen: false);
            String _returnString = await _currentUser.signOut();
            if (_returnString == "success") {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MyRoot(),
                ),
                (route) => false,
              );
            }
          },
          child: Text("Sign Out"),
        ),
      ),
    );
  }
}
