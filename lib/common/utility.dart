import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// ユーティリティクラス
class Utility {
  /// ダイアログ表示
  static Future<AlertDialog> getShowDialog(
      BuildContext context, String msg) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(msg),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.0))),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
