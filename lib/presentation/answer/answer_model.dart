import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  /// オリジナル問題集に追加
  Future addOriginalQuizzes(Quiz quiz) async {
    String uid = FirebaseAuth.instance.currentUser.uid;

    CollectionReference favoriteQuizzes = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favoriteQuizzes');

    await favoriteQuizzes.add({
      'courseId': quiz.courseId,
      'quizId': quiz.documentId,
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    });
  }
}
