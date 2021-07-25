import 'package:cloud_firestore/cloud_firestore.dart';

/// クイズ
class Quiz {
  // Firestoreから取得した値をセット
  String documentId;
  String courseId;
  String question;
  String option1;
  String option2;
  String option3;
  String answer;
  String commentary;
  String userId;
  bool isEnabled;
  bool isExamined;
  DateTime createdAt;
  DateTime updatedAt;
  // ユーザ操作に合わせてセット
  bool isAnswered;
  bool isCorrect;

  Quiz(Map<String, dynamic> data, String docId) {
    this.documentId = docId;
    this.courseId = data['courseId'];
    this.question = data['question'];
    this.option1 = data['option1'];
    this.option2 = data['option2'];
    this.option3 = data['option3'];
    this.answer = data['answer'];
    this.commentary = data['commentary'];
    this.userId = data['userId'];
    this.isEnabled = data['isEnabled'];
    this.isExamined = data['isExamined'];
    final Timestamp createdAt = data['createdAt'];
    this.createdAt = createdAt.toDate();
    final Timestamp updatedAt = data['updatedAt'];
    this.updatedAt = updatedAt.toDate();
    // 初期状態はfalse
    this.isAnswered = false;
    this.isCorrect = false;
  }
}
