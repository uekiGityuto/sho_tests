import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SideMenuModel extends ChangeNotifier {
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
