// class AppUser {
//   final String uid;
//   final String name;
//   final String email;
//   final int age;
//   final String gender;
//   final String photoUrl;
//   final DateTime createdAt;

//   const AppUser({
//     required this.uid,
//     required this.name,
//     required this.email,
//     required this.age,
//     required this.gender,
//     required this.photoUrl,
//     required this.createdAt,
//   });

//   factory AppUser.fromMap(Map<String, dynamic> map) {
//     return AppUser(
//       uid: map['uid'],
//       name: map['name'],
//       email: map['email'],
//       age: map['age'],
//       gender: map['gender'],
//       photoUrl: map['photoUrl'] ?? '',
//       createdAt: map['createdAt']?.toDate() ?? DateTime.now(),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'name': name,
//       'email': email,
//       'age': age,
//       'gender': gender,
//       'photoUrl': photoUrl,
//       'createdAt': createdAt,
//       'updatedAt': DateTime.now(),
//     };
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String userId;
  final String idPassport;
  final String name;
  final String email;
  final int age;
  final String gender;
  final String photoURL;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AppUser({
    required this.idPassport,
    required this.userId,
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.photoURL,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      idPassport: map['idPassport'] ?? '',
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      age: map['age'],
      // age: _parseAge(map['age']),
      gender: map['gender'] ?? '',
      photoURL: map['photoURL'] ?? '',
      role: map['role'] ?? 'user',
      // createdAt: (map['createdAt'] as Timestamp).toDate(),
      // updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      // Safety check: if null, use current time
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),

      updatedAt: map['updatedAt'] != null
          ? (map['updatedAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  // // Helper to prevent crashes if age is stored as a String "" in Firestore
  // static int _parseAge(dynamic age) {
  //   if (age == null || age == '') return 0;
  //   if (age is int) return age;
  //   return int.tryParse(age.toString()) ?? 0;
  // }

  Map<String, dynamic> toMap() {
    return {
      'idPassport': idPassport,
      'userId': userId,
      'name': name,
      'email': email,
      'age': age,
      'gender': gender,
      'photoURL': photoURL,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
