import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

/// メールアドレスでサインインモデル
class SignInWithEmailModel extends ChangeNotifier {
  String email = '';
  String pass = '';

  /// メールアドレスでサインイン
  Future signIn() async {
    if (email.isEmpty) {
      throw ('メールアドレスを入力して下さい。');
    }
    if (pass.isEmpty) {
      throw ('パスワードを入力して下さい。');
    }

    try {
      // メールアドレスでサインイン
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);

      // メールアドレスが確認済みかどうか
      User user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        throw ('メールアドレスの確認が必要です。\n'
            '確認メールを送信しましたので、メール内のリンクを押下して認証して下さい。\n'
            '確認後、再度サインインして下さい。');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('メールアドレスまたはパスワードが異なります。');
      } else if (e.code == 'wrong-password') {
        throw ('メールアドレスまたはパスワードが異なります。');
      } else {
        throw ('ログインに失敗しました。');
      }
    } catch (e) {
      throw ('ログインに失敗しました。');
    }
  }
}
