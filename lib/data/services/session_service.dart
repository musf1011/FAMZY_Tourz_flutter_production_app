//created by: FAMZY CodeWorks
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_session_status.dart';

class SessionService {
  static final _auth = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance;

  static Future<UserSessionStatus> getSessionStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      final isProfileCompleted = prefs.getBool('isProfileCompleted') ?? false;

      if (!isLoggedIn) {
        return UserSessionStatus(
          isLoggedIn: false,
          isEmailVerified: false,
          hasAdditionalInfo: false,
          isProfileCompleted: false,
        );
      }
      if (isProfileCompleted) {
        return UserSessionStatus(
          isLoggedIn: true,
          isProfileCompleted: true,
          isEmailVerified: true,
          hasAdditionalInfo: true,
        );
      }

      bool? isEmailVerified = prefs.getBool('isEmailVerified');
      if (isEmailVerified == null) {
        // Reload user
        await _auth.currentUser!.reload();
        final user = _auth.currentUser!;

        isEmailVerified = user.emailVerified;
        await prefs.setBool('isEmailVerified', isEmailVerified);
      }

      // Check cached additional info
      bool? hasAge = prefs.getBool('hasAge');

      if (hasAge == null) {
        // Reload user
        await _auth.currentUser!.reload();
        final user = _auth.currentUser!;
        final doc = await _db.collection('users').doc(user.uid).get();
        hasAge = doc.data()?['age'] != null;
        await prefs.setBool('hasAge', hasAge);
      }

      if (isEmailVerified && hasAge) {
        await prefs.setBool('isProfileCompleted', true);
      }

      return UserSessionStatus(
        isLoggedIn: true,
        isProfileCompleted: isProfileCompleted,
        isEmailVerified: isEmailVerified,
        hasAdditionalInfo: hasAge,
      );
    } catch (e) {
      return UserSessionStatus(
        isLoggedIn: false,
        isEmailVerified: false,
        hasAdditionalInfo: false,
        isProfileCompleted: false,
      );
    }
  }
}
