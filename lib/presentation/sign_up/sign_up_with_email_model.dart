import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sho_tests/presentation/sign_up/sign_up_model.dart';

/// メールアドレスでサインアップモデル
class SignUpWithEmailModel extends ChangeNotifier {
  String email = '';
  String pass = '';

  /// サインアップ
  Future<void> signUp() async {
    if (email.isEmpty) {
      throw ('メールアドレスを入力して下さい。');
    }
    if (pass.isEmpty) {
      throw ('パスワードを入力して下さい。');
    }

    try {
      // サインアップ
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);

      // Firestoreのusersコレクションにユーザ追加
      // final signUpModel = new SignUpModel();
      // await signUpModel.addUser();

      // 確認メール送信
      User user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('パスワードが弱いです。');
      } else if (e.code == 'email-already-in-use') {
        throw ('メールアドレスが既に登録されています。');
      }
    } catch (e) {
      throw ('登録に失敗しました。');
    }
  }
}
