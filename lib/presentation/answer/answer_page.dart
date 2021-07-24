import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sho_tests/domain/Course.dart';
import 'package:sho_tests/domain/quiz.dart';
import 'package:sho_tests/presentation/course_list/course_list_page.dart';
import 'package:sho_tests/presentation/main/main.dart';
import 'package:sho_tests/presentation/quiz/quiz_page.dart';

import 'answer_model.dart';

class AnswerPage extends StatelessWidget {
  final Quiz _quiz;
  final bool _isCorrect;
  final Course _course;

  AnswerPage(this._quiz, this._isCorrect, this._course);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AnswerModel>(
        create: (_) => AnswerModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('解答・解説'),
          ),
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
                    Text(_quiz.commentary),
                  ],
                ),
                SizedBox(
                  width: 330,
                  child: ElevatedButton(
                      child: Text('次の問題'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizPage(_course)),
                        );
                      }),
                ),
              ],
            );
          }),
        ));
  }
}
