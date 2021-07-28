import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sho_tests/domain/Course.dart';

/// クイズ投稿モデル
class PostQuizModel extends ChangeNotifier {
  // TextFieldから取得した値
  String question = '';
  String option1 = '';
  String option2 = '';
  String option3 = '';
  String answer = '';
  String commentary = '';

  /// Firestoreにクイズ追加
  postQuiz(Course course) async {
    if (this.question.isEmpty) {
      throw ('問題を入力して下さい。');
    }
    if (this.option1.isEmpty) {
      throw ('選択肢1を入力して下さい。');
    }
    if (this.option2.isEmpty) {
      throw ('選択肢2を入力して下さい。');
    }
    if (this.option3.isEmpty) {
      throw ('選択肢3を入力して下さい。');
    }
    if (this.answer.isEmpty) {
      throw ('選択肢4 & 解答を入力して下さい。');
    }
    if (this.commentary.isEmpty) {
      throw ('入力が漏れています。全項目の入力が必要です。');
    }

    // Firestoreの参照先を取得
    CollectionReference quizzes = FirebaseFirestore.instance
        .collection('courses')
        .doc(course.documentId)
        .collection('quizzes');
    // Firestoreに追加
    await quizzes.add({
      'courseId': course.documentId,
      'question': this.question,
      'option1': this.option1,
      'option2': this.option2,
      'option3': this.option3,
      'answer': this.answer,
      'commentary': this.commentary,
      'userId': FirebaseAuth.instance.currentUser.uid,
      'isEnabled': true,
      'isExamined': true,
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    });
  }
}
