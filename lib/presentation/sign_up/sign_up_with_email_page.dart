import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sho_tests/common/utility.dart';
import 'package:sho_tests/presentation/confirm/confirm_page.dart';
import 'sign_up_with_email_model.dart';

///　メールアドレスでサインアップページ
class SignUpWithEmailPage extends StatelessWidget {
  final mailEditingController = TextEditingController();
  final passEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpWithEmailModel>(
      create: (_) => SignUpWithEmailModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('メールアドレスでサインアップ'),
        ),
        body: Consumer<SignUpWithEmailModel>(
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
                  child: Text('登録する'),
                  onPressed: () async {
                    try {
                      await model.signUp();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ConfirmPage(model.email, model.pass)),
                      );
                    } catch (e) {
                      await Utility.getShowDialog(context, e.toString());
                    }
                  })
            ]);
          },
        ),
      ),
    );
  }
}
