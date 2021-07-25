import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sho_tests/presentation/course_list/course_list_page.dart';

import 'home_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(
      create: (_) => HomeModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('ホームメニュー'),
        ),
        body: Consumer<HomeModel>(builder: (context, model, child) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 330,
                    child: ElevatedButton(
                        child: Text('コースを選択'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CourseListPage(false)),
                          );
                        }),
                  ),
                  SizedBox(
                    width: 330,
                    child: ElevatedButton(
                        child: Text('オリジナルクイズを投稿'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CourseListPage(true)),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}