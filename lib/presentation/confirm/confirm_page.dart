import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sho_tests/common/utility.dart';
import 'package:sho_tests/presentation/home/home_page.dart';
import 'confirm_model.dart';

class ConfirmPage extends StatelessWidget {
  final email;
  final pass;

  ConfirmPage(this.email, this.pass);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConfirmModel>(
        create: (_) => ConfirmModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('確認'),
          ),
          body: Consumer<ConfirmModel>(
            builder: (context, model, child) {
              return Center(
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('確認メールを送信しましたので、\n'
                          'メール内のリンクを押下して認証して下さい。\n'
                          '認証後に「次へ」ボタンを押下して下さい。')),
                  SizedBox(
                    width: 330,
                    child: ElevatedButton(
                        child: Text('次へ'),
                        onPressed: () async {
                          if (await model.isConfirmed(email, pass)) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          } else {
                            Utility.getShowDialog(context,
                                'まだメール確認が完了していません。\n確認メール内のリンクをクリックしてください。');
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        child: Text('確認メールを再送する',
                            style: const TextStyle(
                              color: Color(0xff1558d6),
                              decoration: TextDecoration.underline,
                            )),
                        onTap: () async {
                          await model.reSendConfirm();
                          Utility.getShowDialog(context, '確認メールを再送しました。');
                        }),
                  ),
                ]),
              );
            },
          ),
        ));
  }
}
