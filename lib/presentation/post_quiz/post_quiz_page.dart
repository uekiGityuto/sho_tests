import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sho_tests/common/utility.dart';
import 'package:sho_tests/domain/Course.dart';
import 'package:sho_tests/presentation/main/main.dart';

import 'post_quiz_model.dart';

/// オリジナルクイズ投稿ページ
class PostQuizPage extends StatelessWidget {
  final Course course;

  PostQuizPage({this.course});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostQuizModel>(
        create: (_) => PostQuizModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('オリジナルクイズ投稿'),
          ),
          body: Consumer<PostQuizModel>(
            builder: (context, model, child) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('オリジナルクイズを入力して下さい。'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: '問題'),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onChanged: (text) {
                            model.question = text;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: '選択肢1'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: '選択肢2'),
                          onChanged: (text) {
                            model.option1 = text;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: '選択肢3'),
                          onChanged: (text) {
                            model.option2 = text;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '選択肢4 & 解答'),
                          onChanged: (text) {
                            model.answer = text;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: '解説'),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onChanged: (text) {
                            model.commentary = text;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 330,
                        child: ElevatedButton(
                            child: Text('クイズを投稿する'),
                            onPressed: () async {
                              try {
                                await model.postQuiz(course);
                                await Utility.getShowDialog(context, '登録しました。');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                              } catch (e) {
                                await Utility.getShowDialog(
                                    context, e.toString());
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
