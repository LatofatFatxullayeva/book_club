import 'package:book_club/firebase_options.dart';
import 'package:book_club/screens/root/root.dart';
import 'package:book_club/states/current_user.dart';
import 'package:book_club/utils/our_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: OurTheme().buildTheme(),
        home: MyRoot(),
      ),
    );
  }
}
