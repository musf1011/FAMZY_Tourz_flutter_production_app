//created by: FAMZY CodeWorks
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
      debugPrint('*****shared preference is email: $isEmailVerified ');
      //false or null means internet connection is required to send verification email
      if (isEmailVerified == null || isEmailVerified == false) {
        // Reload user
        await _auth.currentUser!.reload();
        final user = _auth.currentUser!;
        isEmailVerified = user.emailVerified;
        debugPrint('****firebase auth is email:$isEmailVerified');
        await prefs.setBool('isEmailVerified', isEmailVerified);
      }

      // Check cached additional info
      bool? hasAge = prefs.getBool('hasAge');
      debugPrint('***getsession hasAge never false?: $hasAge');

      if (hasAge == null) {
        print('******checking age in firebas:');
        // Reload user
        await _auth.currentUser!.reload();
        final user = _auth.currentUser!;
        final doc = await _db.collection('usersInfo').doc(user.uid).get();
        hasAge = doc.data()?['age'] != null;
        await prefs.setBool('hasAge', hasAge);
        await prefs.setBool('hasAdditionalInfo', hasAge);
        print('******checked age in firebas:$hasAge');
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

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    // Only remove keys related to the user session
    await prefs.remove('isLoggedIn');
    await prefs.remove('isProfileCompleted');
    await prefs.remove('isEmailVerified');
    await prefs.remove('hasAge');
    await prefs.remove('hasAdditionalInfo');
    // Add any other user-specific keys here
  }
}
