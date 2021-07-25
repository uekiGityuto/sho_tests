import 'package:cloud_firestore/cloud_firestore.dart';
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
    if (this.question.isEmpty ||
        this.option1.isEmpty ||
        this.option2.isEmpty ||
        this.option3.isEmpty ||
        this.answer.isEmpty ||
        this.commentary.isEmpty) {
      throw ('入力が漏れています。全項目の入力が必要です。');
    }

    // Firestoreに追加
    CollectionReference quizzes = FirebaseFirestore.instance
        .collection('courses')
        .doc(course.documentId)
        .collection('quizzes');

    await quizzes.add({
      'id': '', // TODO: 考える
      'question': this.question,
      'option1': this.option1,
      'option2': this.option2,
      'answer': this.answer,
      'commentary': this.commentary,
      'userId': '', // TODO: FireAuthから取得
      'isEnabled': true,
      'isExamined': true,
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    });
  }
}
