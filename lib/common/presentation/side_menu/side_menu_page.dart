import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sho_tests/common/presentation/side_menu/side_menu_model.dart';
import 'package:sho_tests/presentation/home/home_page.dart';
import 'package:sho_tests/presentation/main/main.dart';

/// サイドメニュー
class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ChangeNotifierProvider<SideMenuModel>(
        create: (_) => SideMenuModel(),
        child: Consumer<SideMenuModel>(builder: (context, model, child) {
          return ListView(children: [
            Ink(
              child: ListTile(
                title: Text('ホームに戻る'),
                leading: Icon(Icons.logout),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              ),
            ),
            Ink(
              child: ListTile(
                title: Text('サインアウト'),
                leading: Icon(Icons.logout),
                onTap: () async {
                  await model.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignPage(),
                    ),
                  );
                },
              ),
            ),
          ]);
        }),
      ),
    );
  }
}
