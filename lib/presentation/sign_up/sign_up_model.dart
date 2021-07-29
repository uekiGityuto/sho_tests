import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

/// サインアップモデル
class SignUpModel extends ChangeNotifier {
  /// Firestoreのusersコレクションにユーザ追加
  Future addUser() async {
    // Firestoreからusersコレクション取得
    CollectionReference collection =
        FirebaseFirestore.instance.collection('users');
    final user = FirebaseAuth.instance.currentUser;

    // 追加対象データを準備
    Map<String, dynamic> data = <String, dynamic>{
      'userName': user.displayName,
      'isManager': false,
      'isEnabled': true,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    // usersコレクションにユーザ追加
    await collection.doc(user.uid).set(data);
  }
}
