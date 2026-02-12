// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:famzy_tourz_v2/data/models/user_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserProvider extends ChangeNotifier {
//   AppUser? _user;
//   AppUser? get user => _user;

//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   bool get isLoggedIn => _user != null;
//   UserProvider() {
//     // Initialize
//     _init();
//   }

//   Future<void> _init() async {
//     // First try to load from local storage
//     await loadUserFromPrefs();

//     // Then listen to Firebase Auth changes
//     _auth.authStateChanges().listen((firebaseUser) {
//       if (firebaseUser != null) {
//         loadUser(firebaseUser.uid);
//       } else {
//         clear();
//       }
//     });
//   }

//   Future<void> loadUser(String uid) async {
//     final doc = await FirebaseFirestore.instance
//         .collection('usersInfo')
//         .doc(uid)
//         .get();

//     if (!doc.exists) return;

//     if (doc.exists) {
//       debugPrint('***USSSser exist: ${doc.data()}');
//       _user = AppUser.fromMap(doc.data()!);

//       debugPrint('***user exist: $_user');
//       notifyListeners();
//     }
//   }

//   Future<void> loadUserFromPrefs() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final userJson = prefs.getString('current_user');

//       if (userJson != null) {
//         final userMap = json.decode(userJson);
//         _user = AppUser.fromMap(userMap);
//         debugPrint('***user loaded from prefs: $_user');
//         // Save user data locally
//         await _saveUserToPrefs(_user!);
//         notifyListeners();
//       }
//     } catch (e) {
//       debugPrint('Error loading user from prefs: $e');
//     }
//   }

//   Future<void> _saveUserToPrefs(AppUser user) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final userJson = json.encode(user.toMap());
//       await prefs.setString('current_user', userJson);
//     } catch (e) {
//       debugPrint('Error saving user to prefs: $e');
//     }
//   }

//   Future<void> clear() async {
//     _user = null;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('current_user');
//     notifyListeners();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famzy_tourz_v2/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  AppUser? _user;
  AppUser? get user => _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get isLoggedIn => _auth.currentUser != null;

  UserProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    final firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      await loadUser(firebaseUser.uid);
    }

    _auth.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser != null) {
        await loadUser(firebaseUser.uid);
      } else {
        clear();
      }
    });
  }

  Future<void> loadUser(String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('usersInfo')
        .doc(uid)
        .get();

    if (!doc.exists) return;

    _user = AppUser.fromMap(doc.data()!);
    notifyListeners();
  }

  void clear() {
    _user = null;
    notifyListeners();
  }
}
