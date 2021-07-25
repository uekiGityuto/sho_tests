import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sho_tests/domain/Course.dart';

/// コースモデル
class CourseListModel extends ChangeNotifier {
  List<Course> courseList = [];

  /// Firestoreからコースリスト取得
  Future fetchCourses() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('courses').get();
    courseList = querySnapshot.docs.map((doc) => new Course(doc)).toList();
    courseList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    this.courseList = courseList;
    notifyListeners();
  }
}
