// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUser extends ChangeNotifier {
  late String? _uid;
  late String? _email;

  String get getUid => _uid!;
  String get getEmail => _email!;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "error";

    try {
      User _firebaseUser = await _auth.currentUser!;
      _uid = _firebaseUser.uid;
      _email = _firebaseUser.email!;
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
      _uid =null;
      _email = null;
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signUpUser(String email, String password) async {
    String retVal = 'error';

    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      retVal = 'success';
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

      _uid = authResult.user!.uid;
      _email = authResult.user!.email!;
      retVal = 'success';
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
      UserCredential authResult = await _auth.signInWithCredential(credential);

      _uid = authResult.user!.uid;
      _email = authResult.user!.email!;
      retVal = 'success';
    } catch (e) {
      retVal = e.toString();
    }

    return retVal;
  }
}
