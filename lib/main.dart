import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sho_tests/presentation/home/home_page.dart';
import 'package:sho_tests/presentation/sign_in/sign_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isSignedIn =
        FirebaseAuth.instance.currentUser == null ? false : true;
    return MaterialApp(
      title: 'IT小テスト',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isSignedIn ? HomePage() : SignInPage(),
    );
  }
}
