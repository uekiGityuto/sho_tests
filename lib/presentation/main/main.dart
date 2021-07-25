import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sho_tests/presentation/home/home_page.dart';

import 'main_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IT小テスト',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignPage(),
    );
  }
}

class SignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('ホーム'),
        ),
        body: Consumer<MainModel>(builder: (context, model, child) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 330,
                    child: ElevatedButton(
                        child: Text('Googleでサインイン'),
                        onPressed: () async {
                          await model.signInWithGoogle();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
