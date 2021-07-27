import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sho_tests/common/presentation/side_menu/side_menu_page.dart';
import 'package:sho_tests/domain/Course.dart';
import 'package:sho_tests/domain/quiz.dart';
import 'package:sho_tests/presentation/answer/answer_page.dart';

import 'quiz_model.dart';

/// クイズ出題ページ
class QuizPage extends StatelessWidget {
  final Course course;
  final List<Quiz> quizList;

  QuizPage({this.course, this.quizList}) {
    // if (this.course == null && this.quizList == null) {
    //   throw ArgumentError('courseとquizListの両方がnullだとエラーです。');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuizModel>(
        create: (_) => QuizModel()..getQuiz(course: course, quizList: quizList),
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
            title: Text('クイズモード'),
          ),
          endDrawer: SideMenu(),
          body: Consumer<QuizModel>(
            builder: (context, model, child) {
              final optionList = model.optionList
                  .map(
                    (option) => SizedBox(
                      width: 330,
                      child: ElevatedButton(
                          child: Text(model.quiz == null ? '' : option.text),
                          onPressed: () async {
                            // 対象クイズを解答済みに変更
                            model.quiz.isAnswered = true;
                            // 対象クイズの正誤を保存
                            model.quiz.isCorrect = option.isCorrect;
                            // クイズリスト更新
                            await model.updateQuizList();
                            // 解答表示ページに移動
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AnswerPage(model.quiz,
                                      option.isCorrect, model.quizList)),
                            );
                          }),
                    ),
                  )
                  .toList();

              return Column(
                children: [
                  Row(children: [
                    Text('問題'),
                    Expanded(
                        child: Text(
                            model.quiz == null ? '' : model.quiz.question)),
                  ]),
                  Row(children: [
                    Text('選択肢'),
                    Column(
                      children: optionList,
                    ),
                  ]),
                  Text('${model.answeringNum}問目/全${model.totalQuizNum}問'),
                ],
              );
            },
          ),
        ));
  }
}
