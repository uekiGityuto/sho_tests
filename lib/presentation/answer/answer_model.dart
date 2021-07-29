import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sho_tests/domain/quiz.dart';

/// 解答モデル
class AnswerModel extends ChangeNotifier {
  bool isEnd;
  bool isDeleted = false;

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

  /// お気に入り問題集に追加
  Future<bool> addOriginalQuizzes(Quiz quiz) async {
    String uid = FirebaseAuth.instance.currentUser.uid;

    CollectionReference favoriteQuizzes = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favoriteQuizzes');

    // 既に登録済みかどうか確認
    final querySnapshot = await favoriteQuizzes
        .where('courseId', isEqualTo: quiz.courseId)
        .where('quizId', isEqualTo: quiz.documentId)
        .limit(1)
        .get();

    // 登録済みの場合は追加しない
    if (querySnapshot.docs.length >= 1) {
      return false;
    }

    // Firestoreに追加
    await favoriteQuizzes.add({
      'courseId': quiz.courseId,
      'quizId': quiz.documentId,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return true;
  }

  /// 削除
  Future<bool> deleteQuiz(Quiz quiz) async {
    if (this.isDeleted) {
      return false;
    }

    String uid = FirebaseAuth.instance.currentUser.uid;

    CollectionReference favoriteQuizzes = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favoriteQuizzes');

    // 削除対象ドキュメント取得
    final querySnapshot = await favoriteQuizzes
        .where('courseId', isEqualTo: quiz.courseId)
        .where('quizId', isEqualTo: quiz.documentId)
        .get();

    // ドキュメント削除
    querySnapshot.docs.forEach((doc) async {
      await doc.reference.delete();
    });
    this.isDeleted = true;
    notifyListeners();
    return true;
  }
}
