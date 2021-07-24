import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sho_tests/domain/Course.dart';
import 'package:sho_tests/domain/option.dart';
import 'package:sho_tests/domain/quiz.dart';

/// クイズモデル
class QuizModel extends ChangeNotifier {
  List<Quiz> quizList = [];
  Quiz quiz;
  List<Option> optionList = [];

  /// クイズ取得
  getQuiz(Course course) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('courses')
        .doc(course.documentId)
        .collection('quizzes')
        .get();

    List<Quiz> quizList =
        querySnapshot.docs.map((doc) => new Quiz(doc)).toList();
    quizList =
        quizList.where((quiz) => quiz.isEnabled && quiz.isExamined).toList();
    this.quizList = _shuffle(quizList);

    // クイズの表示
    this.quiz = quizList[0];
    Option option1 = new Option(this.quiz.option1, false);
    Option option2 = new Option(this.quiz.option2, false);
    Option option3 = new Option(this.quiz.option3, false);
    Option option4 = new Option(this.quiz.answer, true);
    this.optionList = [option1, option2, option3, option4];
    _shuffle(this.optionList);

    // クイズリストから表示済みクイズを除去
    // this.quizList.removeAt(0);

    notifyListeners();
  }

  /// Fisher–Yates shuffle
  List _shuffle(List items) {
    var random = new Random();
    for (var i = items.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);
      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }
    return items;
  }
}
