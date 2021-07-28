import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sho_tests/common/utility.dart';
import 'package:sho_tests/presentation/home/home_page.dart';
import 'package:sho_tests/presentation/sign_in/sign_in_with_email_model.dart';

/// メールアドレスでサインインページ
class SignInWithEmailPage extends StatelessWidget {
  final mailEditingController = TextEditingController();
  final passEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInWithEmailModel>(
        create: (_) => SignInWithEmailModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('メールアドレスでサインイン'),
          ),
          body: Consumer<SignInWithEmailModel>(
            builder: (context, model, child) {
              return Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: mailEditingController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(), hintText: 'メールアドレス'),
                    onChanged: (text) {
                      model.email = text;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passEditingController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(), hintText: 'パスワード'),
                    obscureText: true,
                    onChanged: (text) {
                      model.pass = text;
                    },
                  ),
                ),
                ElevatedButton(
                    child: Text('ログイン'),
                    onPressed: () async {
                      try {
                        await model.signIn();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } catch (e) {
                        await Utility.getShowDialog(context, e.toString());
                      }
                    })
              ]);
            },
          ),
        ));
  }
}
