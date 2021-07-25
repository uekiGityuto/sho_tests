import 'package:flutter/cupertino.dart';
import 'package:sho_tests/domain/quiz.dart';

/// 解答モデル
class AnswerModel extends ChangeNotifier {
  bool isEnd;

  /// 全クイズ完了したかどうか確認
  confirmEnd(List<Quiz> quizList) {
    int totalQuizNum = quizList.length;
    int answeredQuizNum = quizList.where((quiz) => quiz.isAnswered).length;
    if (totalQuizNum == answeredQuizNum) {
      isEnd = true;
    } else {
      isEnd = false;
    }
  }
}
