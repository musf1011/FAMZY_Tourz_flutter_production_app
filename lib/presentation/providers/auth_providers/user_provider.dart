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
  String? _userId; //for future use
  String? get userId => _userId;
  bool? _isAdmin;
  bool? get isAdmin => _isAdmin;
  bool? _isCompany;
  bool? get isCompany => _isCompany;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _initializing = true;
  bool get initializing => _initializing;
  bool get isLoggedIn => _auth.currentUser != null;

  UserProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    //if already login
    final firebaseUser = _auth.currentUser;
    debugPrint('****initializing user provider started*******');
    if (firebaseUser != null) {
      debugPrint('****initializing user provider loading started*******');
      await loadUserFromFirestore(firebaseUser.uid);
      debugPrint('****initializing user provider loading ends*******');
    }
    //listen auth changes
    _auth.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser != null) {
        await loadUserFromFirestore(firebaseUser.uid);
      } else {
        _clearUser();
      }
    });
    _initializing = false;
    notifyListeners();
  }

  Future<void> loadUserFromFirestore(String uid) async {
    final doc = await _firestore.collection('usersInfo').doc(uid).get();

    if (!doc.exists) {
      _user = null;
      notifyListeners();
      return;
    }
    _userId = doc.id; //for future use not implemented now

    _user = AppUser.fromMap(doc.data()!);
    debugPrint(
      '****initializing user provider loading user function got doc: ${doc.id}*******',
    );
    _isAdmin = _user!.role == 'admin' ? true : false;
    _isCompany = _user!.role == 'company' ? true : false;
    debugPrint(
      '***load user function: user name ${_user!.name}, age ${user!.age}, email: ${user!.email}, userId inside doc: ${user!.userId}, userid as doc name:: ${doc.id}***',
    );
    // // 2. THE FIX: Pass both the data map AND the doc.id
    // // This ensures userId in your model is NEVER an empty string.
    // _user = AppUser.fromMap(doc.data()!, doc.id);
    notifyListeners();
  }

  void _clearUser() {
    _user = null;
    notifyListeners();
  }
}
