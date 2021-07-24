import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sho_tests/presentation/main/main.dart';
import 'package:sho_tests/presentation/quiz/quiz_page.dart';

import 'course_list_model.dart';

class CourseListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CourseListModel>(
        create: (_) => CourseListModel()..fetchCourses(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('コース一覧'),
          ),
          body: Consumer<CourseListModel>(builder: (context, model, child) {
            final courseList = model.courseList;
            final courseButtons = courseList
                .map((course) => SizedBox(
                      width: 330,
                      child: ElevatedButton(
                          child: Text(course.courseName),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuizPage(course)),
                            );
                          }),
                    ))
                .toList();

            return Center(
              child: Column(
                children: [
                  Text('学習したいコースを選択して下さい。'),
                  Column(
                    children: courseButtons,
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
