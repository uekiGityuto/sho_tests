import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  String documentId;
  String id;
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

  Quiz(QueryDocumentSnapshot doc) {
    this.documentId = doc.id;
    this.id = doc['id'];
    this.question = doc['question'];
    this.option1 = doc['option1'];
    this.option2 = doc['option2'];
    this.option3 = doc['option3'];
    this.answer = doc['answer'];
    this.commentary = doc['commentary'];
    this.userId = doc['userId'];
    this.isEnabled = doc['isEnabled'];
    this.isExamined = doc['isExamined'];
    final Timestamp createdAt = doc['createdAt'];
    this.createdAt = createdAt.toDate();
    final Timestamp updatedAt = doc['updatedAt'];
    this.updatedAt = updatedAt.toDate();
  }
}
