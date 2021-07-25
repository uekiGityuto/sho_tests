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
  String totalQuizNum;
  String answeringNum;

  /// Firestoreからクイズ取得
  getQuiz({Course course, List<Quiz> quizList}) async {
    if (quizList != null) {
      // 引数のクイズリストをモデルのクイズリストにセット
      this.quizList = quizList;
    } else {
      // Firestoreからクイズリスト取得
      final querySnapshot = await FirebaseFirestore.instance
          .collection('courses')
          .doc(course.documentId)
          .collection('quizzes')
          .get();
      this.quizList = querySnapshot.docs
          .map((doc) => new Quiz(doc.data(), doc.id))
          .toList();
    }

    // トータルのクイズ数と今何問目かを取得
    this.totalQuizNum = this.quizList.length.toString();
    this.answeringNum =
        (this.quizList.where((quiz) => quiz.isAnswered).length + 1).toString();

    // クイズリストから有効なクイズをランダムに1問取得
    List<Quiz> targetQuizList = this
        .quizList
        .where((quiz) => quiz.isEnabled && quiz.isExamined && !quiz.isAnswered)
        .toList();
    _shuffle(targetQuizList);
    this.quiz = targetQuizList[0];

    // クイズの選択肢をシャッフル
    Option option1 = new Option(this.quiz.option1, false);
    Option option2 = new Option(this.quiz.option2, false);
    Option option3 = new Option(this.quiz.option3, false);
    Option option4 = new Option(this.quiz.answer, true);
    this.optionList = [option1, option2, option3, option4];
    _shuffle(this.optionList);

    notifyListeners();
  }

  /// クイズリストの更新
  updateQuizList() async {
    //出題済みクイズの情報を更新する
    print(this.quizList.length);
    this.quizList = this
        .quizList
        .where((quiz) => quiz.documentId != this.quiz.documentId)
        .toList();
    this.quizList.add(this.quiz);

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
