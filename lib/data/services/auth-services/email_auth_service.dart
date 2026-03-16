import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailAuthService {
  EmailAuthService._();
  static final EmailAuthService instance = EmailAuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //create account with email & password
  Future<UserCredential> signUpWithEmail(String email, String password) async {
    debugPrint('****email auth service class $email and $password');
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    return credential;
  }

  //save user data into firestor
  Future<void> saveUserToFirestore({
    required String userId,
    required String fullName,
    required String email,
    required int age,
    required String gender,
    String photoUrl = '',
  }) async {
    debugPrint(
      '***1st step $email and $userId , **$fullName , ** $age , ***$gender ,',
    );
    await _firestore.collection('usersInfo').doc(userId).set({
      'userId': userId,
      'name': fullName,
      'email': email,
      'age': age,
      'gender': gender,
      'photoUrl': photoUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  //send Email verification
  Future<void> sendVerificationEmail(User? user) async {
    user ??= _auth.currentUser;
    await user?.sendEmailVerification();
  }
}
