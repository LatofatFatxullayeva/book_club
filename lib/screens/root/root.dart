import 'package:book_club/screens/home/home.dart';
import 'package:book_club/screens/login/login.dart';
import 'package:book_club/screens/no_group/no_group.dart';
import 'package:book_club/screens/splash/splash_screen.dart';
import 'package:book_club/states/current_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  unknown,
  notLoggedIn,
  notInGroup,
  inGroup,
}

class MyRoot extends StatefulWidget {
  const MyRoot({super.key});

  @override
  State<MyRoot> createState() => _MyRootState();
}

class _MyRootState extends State<MyRoot> {
  AuthStatus _authStatus = AuthStatus.unknown;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.onStartUp();
    if (_returnString == "success") {
      if (_currentUser.getCurrentUser.groupId != null) {
             setState(() {
          _authStatus = AuthStatus.inGroup;
        });
      } else {
        setState(() {
          _authStatus = AuthStatus.notInGroup;
        });
      }
    }else{
           setState(() {
          _authStatus = AuthStatus.notLoggedIn;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.unknown:
        retVal = SplashScreen();
        break;
      case AuthStatus.notLoggedIn:
        retVal = LoginScreen();
        break;

      case AuthStatus.notInGroup:
        retVal = NoGroup();
        break;
      case AuthStatus.inGroup:
        retVal = HomeScreen();
        break;

      default:
    }
    return retVal;
  }

  late Widget retVal;
}
