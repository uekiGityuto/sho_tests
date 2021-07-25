import 'package:flutter/cupertino.dart';
import 'package:sho_tests/domain/quiz.dart';

/// 結果モデル
class ResultModel extends ChangeNotifier {
  String totalQuizNum;
  String correctedQuizNum;

  /// 結果確認
  confirmResult(List<Quiz> quizList) {
    this.totalQuizNum = quizList.length.toString();
    this.correctedQuizNum =
        quizList.where((quiz) => quiz.isCorrect).length.toString();
  }
}
