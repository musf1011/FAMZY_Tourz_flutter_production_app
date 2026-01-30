// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AdminService {
//   static Future<String?> getUserRole() async {
//     final uid = FirebaseAuth.instance.currentUser!.uid;

//     final doc = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(uid)
//         .get();

//     return doc.data()?['role']; // 'admin', 'company', 'user'
//   }

//   static Future<bool> canManagePackages() async {
//     final role = await getUserRole();
//     return role == 'admin' || role == 'company';
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminService {
  static Future<String?> getUserRole() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc = await FirebaseFirestore.instance
        .collection('usersInfo')
        .doc(uid)
        .get();

    return doc.data()?['role']; // 'admin', 'company', 'user'
  }
}
