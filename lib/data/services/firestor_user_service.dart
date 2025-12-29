// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class FirestoreUserService {
//   static final _db = FirebaseFirestore.instance;
//   static final _auth = FirebaseAuth.instance;

//   static Future<void> saveUserToFirestore() async {
//     final user = _auth.currentUser;

//     if (user != null) {
//       await _db.collection('users').doc(user.uid).set({
//         'uid': user.uid,
//         'name': user.displayName,
//         'email': user.email,
//         'photoUrl': user.photoURL,
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreUserService {
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;
  static Future<void> createNewUserInfo() async {
    final user = _auth.currentUser;
    if (user == null) return;
    await _firestore.collection('usersInfo').doc(user.uid).set({
      'userId': user.uid,
      'name': user.displayName ?? '',
      'email': user.email,
      'photoURL': user.photoURL,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> addInfo(int age, String gender) async {
    final user = _auth.currentUser;
    if (user == null) return;
    await _firestore.collection('usersInfo').doc(user.uid).update({
      'age': age,
      'gender': gender,
    });
  }

  static Future<void> updateUserInfo(Map<String, dynamic> data) async {
    final user = _auth.currentUser;
    if (user == null) return;
    await _firestore.collection('usersInfo').doc(user.uid).update({
      ...data,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // static Future<void
}
  // static Future<void> saveUserToFirestore({
  //   int? age,
  //   String? gender,
  //   bool isNewUser = false,
  //   Map<String, dynamic>? updatedData,
  // }) async {
  //   final user = _auth.currentUser;

  //   if (user == null) return;

  //   var data = <String, dynamic>{};

  //   if (isNewUser) {
  //     data = <String, dynamic>{
  //       'uid': user.uid,
  //       'name': user.displayName,
  //       'email': user.email,
  //       'photoUrl': user.photoURL,
  //       'updatedAt': FieldValue.serverTimestamp(),
  //       'createdAt': FieldValue.serverTimestamp(),
  //     };
  //   } else if (updatedData != null) {
  //     data = updatedData;
  //   } else {
  //     data['age'] = age;
  //     data['gender'] = gender;
  //   }
  //   await _db
  //       .collection('users')
  //       .doc(user.uid)
  //       .set(data, SetOptions(merge: true));
  // }
