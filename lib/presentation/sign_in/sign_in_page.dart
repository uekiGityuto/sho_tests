import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:sho_tests/presentation/home/home_page.dart';
import 'package:sho_tests/presentation/sign_in/sign_in_with_email_page.dart';
import 'package:sho_tests/presentation/sign_up/sign_up_with_email_page.dart';

import 'sign_in_model.dart';

/// サインインページ
class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInModel>(
      create: (_) => SignInModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('サインイン'),
          automaticallyImplyLeading: false,
        ),
        body: Consumer<SignInModel>(builder: (context, model, child) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('サインインして下さい。'),
                  SizedBox(
                    width: 330,
                    child: SignInButton(Buttons.Google, onPressed: () async {
                      await model.signInWithGoogle();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }),
                  ),
                  SizedBox(
                    width: 330,
                    child: SignInButton(Buttons.Email, onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInWithEmailPage()),
                      );
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(color: Colors.black),
                  ),
                  InkWell(
                    child: Text('アカウントがない方はこちらから登録して下さい。',
                        style: const TextStyle(
                          color: Color(0xff1558d6),
                          decoration: TextDecoration.underline,
                        )),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpWithEmailPage(),
                      ),
                    ),
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
