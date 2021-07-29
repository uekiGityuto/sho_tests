import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sho_tests/presentation/sign_up/sign_up_model.dart';

class ConfirmModel extends ChangeNotifier {
  /// メールアドレス確認済みかどうか
  Future<bool> isConfirmed(String email, String pass) async {
    // 再サインイン（サインインし直さないとemailVerifiedがtrueにならない）
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);
    User user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      // 確認済みであれば、Firestoreのusersコレクションにユーザ追加
      final signUpModel = new SignUpModel();
      await signUpModel.addUser();

      return true;
    }
    return false;
  }

  /// 確認メール再送
  reSendConfirm() async {
    User user = FirebaseAuth.instance.currentUser;
    await user.sendEmailVerification();
  }
}
