import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sho_tests/common/presentation/side_menu/side_menu_page.dart';
import 'package:sho_tests/common/utility.dart';
import 'package:sho_tests/domain/quiz.dart';
import 'package:sho_tests/presentation/quiz/quiz_page.dart';
import 'package:sho_tests/presentation/result/result_page.dart';

import 'answer_model.dart';

/// 解答表示ページ
class AnswerPage extends StatelessWidget {
  final Quiz _quiz;
  final bool _isCorrect;
  final List<Quiz> _quizList;
  final bool _isOriginal;

  AnswerPage(this._quiz, this._isCorrect, this._quizList, this._isOriginal);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AnswerModel>(
        create: (_) => AnswerModel()..confirmEnd(_quizList),
        child: Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
            title: Text('解答・解説'),
          ),
          endDrawer: SideMenu(),
          body: Consumer<AnswerModel>(builder: (context, model, child) {
            return Column(
              children: [
                Text(
                  _isCorrect ? '正解！' : '失敗',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.red,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, top: 8.0, right: 8.0, bottom: 0.0),
                  child: Text(
                    '正解の選択肢',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, top: 0.0, right: 8.0, bottom: 8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_quiz.answer),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, top: 8.0, right: 8.0, bottom: 0.0),
                  child: Text(
                    '解説',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, top: 0.0, right: 8.0, bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _quiz.commentary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, top: 16.0, right: 8.0, bottom: 8.0),
                  child: SizedBox(
                    width: 330,
                    child: model.isEnd
                        ? ElevatedButton(
                            child: Text('結果確認'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ResultPage(_quizList)),
                              );
                            })
                        : ElevatedButton(
                            child: Text('次の問題'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuizPage(
                                        quizList: _quizList,
                                        isOriginal: _isOriginal)),
                              );
                            }),
                  ),
                ),
                if (this._isOriginal && !model.isDeleted)
                  SizedBox(
                    width: 330,
                    child: ElevatedButton(
                        child: Text('このクイズをお気に入り問題集から削除'),
                        onPressed: () async {
                          final isDeleted = await model.deleteQuiz(_quiz);
                          Utility.getShowDialog(
                              context, isDeleted ? '削除しました。' : '既に削除済みです');
                        }),
                  ),
                if (!this._isOriginal)
                  SizedBox(
                    width: 330,
                    child: ElevatedButton(
                        child: Text('お気に入り問題集に追加'),
                        onPressed: () async {
                          final isCompleted =
                              await model.addOriginalQuizzes(_quiz);
                          Utility.getShowDialog(context,
                              isCompleted ? 'お気に入り問題集に追加しました。' : '既に登録済みです。');
                        }),
                  ),
              ],
            );
          }),
        ));
  }
}
