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
                Text(_isCorrect ? '正解！' : '失敗'),
                Row(
                  children: [
                    Text('正解：'),
                    Text(_quiz.answer),
                  ],
                ),
                Row(
                  children: [
                    Text('解説：'),
                    Expanded(
                      child: Text(
                        _quiz.commentary,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 330,
                  child: model.isEnd
                      ? ElevatedButton(
                          child: Text('結果確認'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultPage(_quizList)),
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
                this._isOriginal
                    ? SizedBox(
                        width: 330,
                        child: ElevatedButton(
                            child: Text('このクイズをオリジナル問題集から削除'),
                            onPressed: () async {
                              final isDeleted = await model.deleteQuiz(_quiz);
                              Utility.getShowDialog(
                                  context, isDeleted ? '削除しました。' : "既に削除済みです。");
                            }),
                      )
                    : SizedBox(
                        width: 330,
                        child: ElevatedButton(
                            child: Text('オリジナル問題集に追加'),
                            onPressed: () async {
                              final isCompleted =
                                  await model.addOriginalQuizzes(_quiz);
                              Utility.getShowDialog(
                                  context,
                                  isCompleted
                                      ? 'オリジナル問題集に追加しました。'
                                      : '既に登録済みです。');
                            }),
                      ),
              ],
            );
          }),
        ));
  }
}
