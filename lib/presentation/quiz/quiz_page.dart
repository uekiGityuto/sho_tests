import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sho_tests/domain/Course.dart';
import 'package:sho_tests/presentation/answer/answer_page.dart';
import 'package:sho_tests/presentation/course_list/course_list_page.dart';
import 'package:sho_tests/presentation/main/main.dart';

import 'quiz_model.dart';

class QuizPage extends StatelessWidget {
  final Course _course;

  QuizPage(
    this._course,
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuizModel>(
        create: (_) => QuizModel()..getQuiz(_course),
        child: Scaffold(
          appBar: AppBar(
            title: Text('クイズモード'),
          ),
          body: Consumer<QuizModel>(builder: (context, model, child) {
            final optionList = model.optionList
                .map(
                  (option) => SizedBox(
                    width: 330,
                    child: ElevatedButton(
                        child: Text(model.quiz == null ? '' : option.text),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AnswerPage(
                                    model.quiz, option.isCorrect, _course)),
                          );
                        }),
                  ),
                )
                .toList();
            return Column(
              children: [
                Row(children: [
                  Text('問題'),
                  Text(model.quiz == null ? '' : model.quiz.question),
                ]),
                Row(children: [
                  Text('選択肢'),
                  Column(
                    children: optionList,
                  ),
                ]),
              ],
            );
          }),
        ));
  }
}
