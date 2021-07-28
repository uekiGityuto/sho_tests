import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// サイドメニューモデル
class SideMenuModel extends ChangeNotifier {
  /// サインアウト
  Future signOut() async {
    if (GoogleSignIn().currentUser != null) {
      await GoogleSignIn().disconnect(); // サインイン時にアカウントを選択出来るようにする
    }
    await FirebaseAuth.instance.signOut();
  }
}
