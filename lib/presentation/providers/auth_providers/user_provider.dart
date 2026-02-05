import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famzy_tourz_v2/data/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  AppUser? _user;
  AppUser? get user => _user;

  bool get isLoggedIn => _user != null;

  Future<void> loadUser(String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('usersInfo')
        .doc(uid)
        .get();
    debugPrint('user exist: ${doc.exists}');
    if (doc.exists) {
      _user = AppUser.fromMap(doc.data()!);
      notifyListeners();
    }
  }

  void clear() {
    _user = null;
    notifyListeners();
  }
}
