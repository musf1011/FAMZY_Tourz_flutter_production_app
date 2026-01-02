// created by: FAMZY CodeWorks
import 'package:firebase_auth/firebase_auth.dart';

class PasswordResetService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> sendResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }
}
