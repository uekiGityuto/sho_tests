import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainModel extends ChangeNotifier {
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

    // Firestoreからusersコレクション取得
    CollectionReference collection =
        FirebaseFirestore.instance.collection('users');

    // 追加対象データを準備
    Map<String, dynamic> data = <String, dynamic>{
      'userName': userCredential.user.displayName,
      'isManager': false,
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    };

    // usersコレクションにユーザ追加
    await collection.doc(userCredential.user.uid).set(data);
  }
}
