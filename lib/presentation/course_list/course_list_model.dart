import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sho_tests/domain/Course.dart';
import 'package:sho_tests/domain/quiz.dart';

/// コースモデル
class CourseListModel extends ChangeNotifier {
  List<Course> courseList = [];
  List<Quiz> quizList = [];

  /// Firestoreからコースリスト取得
  Future fetchCourses() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('courses').get();
    courseList = querySnapshot.docs.map((doc) => new Course(doc)).toList();
    courseList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    this.courseList = courseList;
    notifyListeners();
  }

  /// お気に入り問題集作成
  Future getOriginalQuizList() async {
    String uid = FirebaseAuth.instance.currentUser.uid;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favoriteQuizzes')
        .get();

    final quizList =
        querySnapshot.docs.map((doc) async => await _getQuiz(doc)).toList();
    this.quizList = await Future.wait(quizList);
    notifyListeners();
  }

  /// クイズ取得
  Future<Quiz> _getQuiz(QueryDocumentSnapshot<Map<String, dynamic>> doc) async {
    String courseId = doc['courseId'];
    String quizId = doc['quizId'];

    final docSnapshot = await FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId)
        .collection('quizzes')
        .doc(quizId)
        .get();

    return new Quiz.original(docSnapshot.data(), quizId);
  }
}
