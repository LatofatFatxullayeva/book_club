// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_club/models/user.dart';
import 'package:book_club/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUser extends ChangeNotifier {
  OurUser _currentUser = OurUser();

  OurUser get getCurrentUser => _currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "error";

    try {
      User _firebaseUser = await _auth.currentUser!;
         _currentUser = await OurDatabase().getUserInfo(_firebaseUser.uid);
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signOut() async {
    String retVal = "error";

    try {
      await _auth.signOut();
      _currentUser = OurUser();
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signUpUser(
      String email, String password, String fullName) async {
    String retVal = 'error';
    OurUser _user = OurUser();
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user.uid = _authResult.user!.uid;
      _user.email = _authResult.user!.email;
      _user.fullName = fullName;
      String _returnString = await OurDatabase().createUser(_user);
      if (_returnString == "success") {
        retVal = 'success';
      }
    } catch (e) {
      retVal = e.toString();
    }

    return retVal;
  }

  Future<String> loginUserWithEmail(String email, String password) async {
    String retVal = 'error';

    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);


          _currentUser = await OurDatabase().getUserInfo(authResult.user!.uid);
      retVal = "success";
    } catch (e) {
      retVal = e.toString();
    }

    return retVal;
  }

  Future<String> loginUserWithGoogle() async {
    String retVal = 'error';
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      OurUser _user = OurUser();
      UserCredential authResult = await _auth.signInWithCredential(credential);
      if (authResult.additionalUserInfo!.isNewUser) {
        _user.uid = authResult.user!.uid;
        _user.email = authResult.user!.email;
        _user.fullName = authResult.user!.displayName;
        OurDatabase().createUser(_user);
      }

      _currentUser = await OurDatabase().getUserInfo(authResult.user!.uid);
      retVal = "success";
        }on PlatformException catch (e) {
      retVal = e.toString();
    }

    return retVal;
  }
}
