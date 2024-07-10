import 'package:book_club/screens/home/home.dart';
import 'package:book_club/screens/login/login.dart';
import 'package:book_club/states/current_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  notLoggedIn,
  loggedIn,
}

class MyRoot extends StatefulWidget {
  const MyRoot({super.key});

  @override
  State<MyRoot> createState() => _MyRootState();
}

class _MyRootState extends State<MyRoot> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.onStartUp();
    if (_returnString == "success") {
      setState(() {
      _authStatus = AuthStatus.loggedIn;
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = LoginScreen();
        break;

      case AuthStatus.loggedIn:
        retVal = HomeScreen();
        break;
      default:
    }
    return retVal;
  }

  late Widget retVal;
}
