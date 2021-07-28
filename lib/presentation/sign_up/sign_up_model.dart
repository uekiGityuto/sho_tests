import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

/// サインアップモデル
class SignUpModel extends ChangeNotifier {
  /// Firestoreのusersコレクションにユーザ追加
  Future addUser(UserCredential userCredential) async {
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
