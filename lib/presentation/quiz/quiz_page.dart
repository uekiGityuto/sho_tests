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
  final bool isOriginal;

  QuizPage({this.course, this.quizList, this.isOriginal});
  // {
  // if (this.course == null && this.quizList == null) {
  //   throw ArgumentError('courseとquizListの両方がnullだとエラーです。');
  // }

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
                                  builder: (context) => AnswerPage(
                                      model.quiz,
                                      option.isCorrect,
                                      model.quizList,
                                      this.isOriginal)),
                            );
                          }),
                    ),
                  )
                  .toList();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '問題',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
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
                                model.quiz == null ? '' : model.quiz.question),
                          ),
                        )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '選択肢',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      children: optionList,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                          '${model.answeringNum}問目/全${model.totalQuizNum}問'),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
