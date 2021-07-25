import 'package:cloud_firestore/cloud_firestore.dart';

/// コース
class Course {
  String documentId;
  String courseName;
  DateTime createdAt;
  DateTime updatedAt;

  Course(QueryDocumentSnapshot doc) {
    this.documentId = doc.id;
    this.courseName = doc['courseName'];
    final Timestamp createdAt = doc['createdAt'];
    this.createdAt = createdAt.toDate();
    final Timestamp updatedAt = doc['updatedAt'];
    this.updatedAt = updatedAt.toDate();
  }
}
