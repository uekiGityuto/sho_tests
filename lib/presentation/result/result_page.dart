import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sho_tests/common/presentation/side_menu/side_menu_page.dart';
import 'package:sho_tests/domain/quiz.dart';
import 'package:sho_tests/presentation/course_list/course_list_page.dart';

import 'result_model.dart';

/// 結果表示ページ
class ResultPage extends StatelessWidget {
  final List<Quiz> _quizList;

  ResultPage(this._quizList);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ResultModel>(
        create: (_) => ResultModel()..confirmResult(_quizList),
        child: Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
            title: Text('結果'),
          ),
          endDrawer: SideMenu(),
          body: Consumer<ResultModel>(builder: (context, model, child) {
            return Center(
              child: Column(
                children: [
                  Text(
                      '${model.totalQuizNum}問中、${model.correctedQuizNum}問正解！！'),
                  SizedBox(
                    width: 330,
                    child: ElevatedButton(
                        child: Text('コース選択に戻る'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CourseListPage(false)),
                          );
                        }),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
