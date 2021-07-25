import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sho_tests/presentation/post_quiz/post_quiz_page.dart';
import 'package:sho_tests/presentation/quiz/quiz_page.dart';

import 'course_list_model.dart';

/// コース選択ページ
class CourseListPage extends StatelessWidget {
  final bool isPost;

  CourseListPage(this.isPost);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CourseListModel>(
        create: (_) => CourseListModel()..fetchCourses(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('コース一覧'),
          ),
          body: Consumer<CourseListModel>(builder: (context, model, child) {
            // Firestoreから取得したデータを元にコース選択ボタン作成
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
                                  builder: (context) => isPost
                                      ? PostQuizPage(course: course)
                                      : QuizPage(course: course)),
                            );
                          }),
                    ))
                .toList();

            if (!this.isPost) {
              // オリジナル問題集ボタンをコース一覧に追加
              final favoriteQuizButton = SizedBox(
                width: 330,
                child: ElevatedButton(
                    child: Text('オリジナル問題集'),
                    onPressed: () async {
                      // オリジナル問題集を作成
                      await model.getOriginalQuizList();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                QuizPage(quizList: model.quizList)),
                      );
                    }),
              );
              courseButtons.add(favoriteQuizButton);
            }

            return Center(
              child: Column(
                children: [
                  Text(this.isPost
                      ? 'クイズを追加したいコースを選択して下さい'
                      : '学習したいコースを選択して下さい。'),
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
