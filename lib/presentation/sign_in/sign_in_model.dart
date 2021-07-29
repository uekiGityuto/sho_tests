import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sho_tests/presentation/sign_up/sign_up_model.dart';

/// サインインモデル
class SignInModel extends ChangeNotifier {
  /// Googleでサインイン
  signInWithGoogle() async {
    // Googleサインイン処理を開始
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // GoogleSignInAuthentication取得
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // GoogleAuthCredential作成
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Googleサインイン
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // 初回サインインの場合はFirestoreのusersコレクションにユーザ追加
    if (await _isNotRegistered()) {
      final signUpModel = new SignUpModel();
      await signUpModel.addUser();
    }
  }

  /// Firestoreのusersコレクションにユーザが存在するかどうか
  Future<bool> _isNotRegistered() async {
    String uid = FirebaseAuth.instance.currentUser.uid;
    DocumentSnapshot user =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    return user.data() == null ? true : false;
  }
}
