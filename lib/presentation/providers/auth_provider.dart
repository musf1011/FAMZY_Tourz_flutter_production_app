// // // // // import 'package:famzy_tourz_v2/routes/app_routes.dart';
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // // import 'package:shared_preferences/shared_preferences.dart';

// // // // // import '../../data/services/google_auth_service.dart';

// // // // // class AuthProvider extends ChangeNotifier {
// // // // //   final FirebaseAuth _auth = FirebaseAuth.instance;

// // // // //   bool _loading = false;
// // // // //   bool get loading => _loading;

// // // // //   final GoogleAuthService _googleAuth = GoogleAuthService.instance;

// // // // //   void _setLoading(bool value) {
// // // // //     _loading = value;
// // // // //     notifyListeners();
// // // // //   }

// // // // //   /// ✅ Email + Password Sign In
// // // // //   Future<void> signInWithEmail(
// // // // //     BuildContext context,
// // // // //     String email,
// // // // //     String password,
// // // // //   ) async {
// // // // //     try {
// // // // //       _setLoading(true);

// // // // //       await _auth.signInWithEmailAndPassword(
// // // // //         email: email.trim(),
// // // // //         password: password.trim(),
// // // // //       );

// // // // //       final prefs = await SharedPreferences.getInstance();
// // // // //       await prefs.setBool('isLoggedIn', true);

// // // // //       Navigator.pushReplacementNamed(context, AppRoutes.main);
// // // // //     } catch (e) {
// // // // //       _showError(context, e.toString());
// // // // //     } finally {
// // // // //       _setLoading(false);
// // // // //     }
// // // // //   }

// // // // //   /// ✅ Google Sign In
// // // // //   Future<void> signInWithGoogle(BuildContext context) async {
// // // // //     try {
// // // // //       _setLoading(true);

// // // // //       // final user = await _googleAuth.signInWithGoogle(context);
// // // // // await _googleAuth.signInWithGoogle(context);
// // // // //       // if (user != null) {
// // // // //         final prefs = await SharedPreferences.getInstance();
// // // // //         await prefs.setBool('isLoggedIn', true);

// // // // //         Navigator.pushReplacementNamed(context, AppRoutes.main);
// // // // //       // }
// // // // //     } catch (e) {
// // // // //       _showError(context, e.toString());
// // // // //     } finally {
// // // // //       _setLoading(false);
// // // // //     }
// // // // //   }

// // // // //   void _showError(BuildContext context, String msg) {
// // // // //     ScaffoldMessenger.of(context).showSnackBar(
// // // // //       SnackBar(content: Text(msg)),
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'package:famzy_tourz_v2/data/services/google_auth_service.dart';
// // // // import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
// // // // import 'package:famzy_tourz_v2/routes/app_routes.dart';
// // // // import 'package:firebase_auth/firebase_auth.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:shared_preferences/shared_preferences.dart';

// // // // class AuthProvider extends ChangeNotifier {
// // // //   final FirebaseAuth _auth = FirebaseAuth.instance;
// // // //   final NavigationService _navigation = NavigationService();
// // // //   final GoogleAuthService _googleAuth = GoogleAuthService.instance;

// // // //   bool _loading = false;
// // // //   bool get loading => _loading;

// // // //   void _setLoading(bool value) {
// // // //     _loading = value;
// // // //     notifyListeners();
// // // //   }

// // // //   /// ✅ Email + Password Sign In
// // // //   Future<void> signInWithEmail(String email, String password) async {
// // // //     try {
// // // //       _setLoading(true);

// // // //       await _auth.signInWithEmailAndPassword(
// // // //         email: email.trim(),
// // // //         password: password.trim(),
// // // //       );

// // // //       final prefs = await SharedPreferences.getInstance();
// // // //       await prefs.setBool('isLoggedIn', true);

// // // //       _navigation.navigateReplacement(AppRoutes.main);
// // // //     } catch (e) {
// // // //       _navigation.showSnackBar(e.toString());
// // // //     } finally {
// // // //       _setLoading(false);
// // // //     }
// // // //   }

// // // //   /// ✅ Google Sign In
// // // //   Future<void> signInWithGoogle(BuildContext context) async {
// // // //     try {
// // // //       _setLoading(true);

// // // //       await _googleAuth.signInWithGoogle(context);

// // // //       final prefs = await SharedPreferences.getInstance();
// // // //       await prefs.setBool('isLoggedIn', true);

// // // //       _navigation.navigateReplacement(AppRoutes.main);
// // // //     } catch (e) {
// // // //       _navigation.showSnackBar(e.toString());
// // // //     } finally {
// // // //       _setLoading(false);
// // // //     }
// // // //   }
// // // // }

// // // import 'package:famzy_tourz_v2/data/services/google_auth_service.dart';
// // // import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
// // // import 'package:famzy_tourz_v2/routes/app_routes.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';

// // // class AuthProvider extends ChangeNotifier {
// // //   final FirebaseAuth _auth = FirebaseAuth.instance;
// // //   final NavigationService _navigation = NavigationService();
// // //   final GoogleAuthService _googleAuth = GoogleAuthService.instance;

// // //   bool _loading = false;
// // //   bool get loading => _loading;

// // //   void _setLoading(bool value) {
// // //     _loading = value;
// // //     notifyListeners();
// // //   }

// // //   /// ✅ Email + Password Sign In
// // //   Future<void> signInWithEmail(String email, String password) async {
// // //     try {
// // //       _setLoading(true);

// // //       await _auth.signInWithEmailAndPassword(
// // //         email: email.trim(),
// // //         password: password.trim(),
// // //       );

// // //       final prefs = await SharedPreferences.getInstance();
// // //       await prefs.setBool('isLoggedIn', true);

// // //       // Navigate to main screen
// // //       WidgetsBinding.instance.addPostFrameCallback((_) {
// // //         _navigation.navigateReplacement(AppRoutes.main);
// // //       });
// // //     } catch (e) {
// // //       // Show error
// // //       _navigation.showSnackBar(
// // //         _getFirebaseErrorMessage(e.toString()), // Better error messages
// // //       );
// // //     } finally {
// // //       _setLoading(false);
// // //     }
// // //   }

// // //   /// ✅ Google Sign In - FIXED (no BuildContext parameter)
// // //   Future<void> signInWithGoogle(context) async {
// // //     try {
// // //       _setLoading(true);

// // //       await _googleAuth.signInWithGoogle(context);

// // //       final prefs = await SharedPreferences.getInstance();
// // //       await prefs.setBool('isLoggedIn', true);

// // //       // Navigate to main screen
// // //       WidgetsBinding.instance.addPostFrameCallback((_) {
// // //         _navigation.navigateReplacement(AppRoutes.main);
// // //       });
// // //     } catch (e) {
// // //       _navigation.showSnackBar(e.toString());
// // //     } finally {
// // //       _setLoading(false);
// // //     }
// // //   }

// // //   // Helper method for better error messages
// // //   String _getFirebaseErrorMessage(String error) {
// // //     if (error.contains('wrong-password') ||
// // //         error.contains('invalid-credential')) {
// // //       return 'Invalid email or password';
// // //     } else if (error.contains('user-not-found')) {
// // //       return 'No account found with this email';
// // //     } else if (error.contains('user-disabled')) {
// // //       return 'This account has been disabled';
// // //     } else if (error.contains('too-many-requests')) {
// // //       return 'Too many attempts. Please try again later';
// // //     } else if (error.contains('network-request-failed')) {
// // //       return 'Network error. Please check your connection';
// // //     } else if (error.contains('invalid-email')) {
// // //       return 'Invalid email format';
// // //     } else {
// // //       return 'Login failed. Please try again';
// // //     }
// // //   }
// // // }

// // // lib/presentation/providers/auth_provider.dart

// // import 'package:famzy_tourz_v2/data/services/email_auth_service.dart';
// // import 'package:famzy_tourz_v2/data/services/google_auth_service.dart';
// // import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
// // import 'package:famzy_tourz_v2/routes/app_routes.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // class AuthProvider extends ChangeNotifier {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final NavigationService _navigation = NavigationService();
// //   final GoogleAuthService _googleAuth = GoogleAuthService.instance;

// //   bool _loading = false;
// //   bool get loading => _loading;

// //   void _setLoading(bool value) {
// //     _loading = value;
// //     notifyListeners();
// //   }

// //   //email & password signin for existing account
// //   Future<void> signInWithEmail(String email, String password) async {
// //     try {
// //       _setLoading(true);

// //       await _auth.signInWithEmailAndPassword(
// //         email: email.trim(),
// //         password: password.trim(),
// //       );

// //       final prefs = await SharedPreferences.getInstance();
// //       await prefs.setBool('isLoggedIn', true);

// //       WidgetsBinding.instance.addPostFrameCallback((_) {
// //         _navigation.navigateReplacement(AppRoutes.main);
// //       });
// //     } catch (e) {
// //       _navigation.showSnackBar(_getFirebaseErrorMessage(e.toString()));
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }

// //   /// google sign in for existing users
// //   Future<void> signInWithGoogle() async {
// //     try {
// //       _setLoading(true);

// //       // GoogleAuthService handles firestore saving for new users
// //       await _googleAuth.signInWithGoogle(_navigation.context!);

// //       final prefs = await SharedPreferences.getInstance();
// //       await prefs.setBool('isLoggedIn', true);

// //       WidgetsBinding.instance.addPostFrameCallback((_) {
// //         _navigation.navigateReplacement(AppRoutes.main);
// //       });
// //     } catch (e) {
// //       _navigation.showSnackBar(e.toString());
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }

// //   //if new, signn up using e-mail & password
// //   Future<void> signUpWithEmail({
// //     required String fullName,
// //     required String email,
// //     required String password,
// //     required int age,
// //     required String? gender,
// //   }) async {
// //     try {
// //       _setLoading(true);

// //       //create firebase user
// //       final userCred = await EmailAuthService.instance.signUpWithEmail(
// //         email,
// //         password,
// //       );
// //       final user = userCred.user;
// //       if (user == null) {
// //         throw Exception('Failed to create user.');
// //       }

// //       //save user in Firestore
// //       await EmailAuthService.instance.saveUserToFirestore(
// //         uid: user.uid,
// //         fullName: fullName,
// //         email: email,
// //         age: age,
// //         gender: gender ?? '',
// //         photoUrl: '',
// //       );

// //       //logged in saved locally
// //       final prefs = await SharedPreferences.getInstance();
// //       await prefs.setBool('isLoggedIn', true);

// //       //send verification email
// //       await EmailAuthService.instance.sendVerificationEmail(user);

// //       //navigate to email verification pending screen
// //       WidgetsBinding.instance.addPostFrameCallback((_) {
// //         _navigation.navigateReplacement(AppRoutes.emailVerification);
// //       });
// //     } catch (e) {
// //       _navigation.showSnackBar(e.toString());
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }

// //   // firebase error messages
// //   String _getFirebaseErrorMessage(String error) {
// //     if (error.contains('wrong-password') ||
// //         error.contains('invalid-credential')) {
// //       return 'Invalid email or password';
// //     } else if (error.contains('user-not-found')) {
// //       return 'No account found with this email';
// //     } else if (error.contains('user-disabled')) {
// //       return 'This account has been disabled';
// //     } else if (error.contains('too-many-requests')) {
// //       return 'Too many attempts. Please try again later';
// //     } else if (error.contains('network-request-failed')) {
// //       return 'Network error. Please check your connection';
// //     } else if (error.contains('invalid-email')) {
// //       return 'Invalid email format';
// //     } else {
// //       return 'Operation failed. Please try again';
// //     }
// //   }
// // }

// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:famzy_tourz_v2/data/services/email_auth_service.dart';
// import 'package:famzy_tourz_v2/data/services/google_auth_service.dart';
// import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
// import 'package:famzy_tourz_v2/routes/app_routes.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthProvider extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final NavigationService _navigation = NavigationService();
//   final GoogleAuthService _googleAuth = GoogleAuthService.instance;

//   bool _loading = false;
//   bool get loading => _loading;

//   void _setLoading(bool value) {
//     _loading = value;
//     notifyListeners();
//   }

//   //email & password signin for existing account
//   Future<void> signInWithEmail(String email, String password) async {
//     try {
//       _setLoading(true);

//       await _auth.signInWithEmailAndPassword(
//         email: email.trim(),
//         password: password.trim(),
//       );

//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('isLoggedIn', true);

//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _navigation.navigateReplacement(AppRoutes.main);
//       });
//     } catch (e) {
//       _navigation.showSnackBar(
//         title: 'Sign In Failed',
//         message: _getFirebaseErrorMessage(e.toString()),
//         type: ContentType.failure,
//       );
//     } finally {
//       _setLoading(false);
//     }
//   }

//   /// google sign in for existing users
//   Future<void> signInWithGoogle() async {
//     try {
//       _setLoading(true);

//       // GoogleAuthService handles firestore saving for new users
//       await _googleAuth.signInWithGoogle(_navigation.context!);

//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('isLoggedIn', true);

//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _navigation.navigateReplacement(AppRoutes.main);
//       });
//     } catch (e) {
//       _navigation.showSnackBar(
//         title: 'Google Sign In Failed',
//         message: e.toString(),
//         type: ContentType.failure,
//       );
//     } finally {
//       _setLoading(false);
//     }
//   }

//   //if new, signn up using e-mail & password
//   Future<void> signUpWithEmail({
//     required String fullName,
//     required String email,
//     required String password,
//     required int age,
//     required String? gender,
//   }) async {
//     try {
//       _setLoading(true);

//       //create firebase user
//       final userCred = await EmailAuthService.instance.signUpWithEmail(
//         email,
//         password,
//       );
//       final user = userCred.user;
//       if (user == null) {
//         throw Exception('Failed to create user.');
//       }

//       //save user in Firestore
//       await EmailAuthService.instance.saveUserToFirestore(
//         uid: user.uid,
//         fullName: fullName,
//         email: email,
//         age: age,
//         gender: gender ?? '',
//         photoUrl: '',
//       );

//       //logged in saved locally
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('isLoggedIn', true);

//       //send verification email
//       await EmailAuthService.instance.sendVerificationEmail(user);

//       //navigate to email verification pending screen
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _navigation.navigateReplacement(AppRoutes.emailVerification);
//       });
//     } catch (e) {
//       _navigation.showSnackBar(
//         title: 'Sign Up Failed',
//         message: e.toString(),
//         type: ContentType.failure,
//       );
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // firebase error messages
//   String _getFirebaseErrorMessage(String error) {
//     if (error.contains('wrong-password') ||
//         error.contains('invalid-credential')) {
//       return 'Invalid email or password';
//     } else if (error.contains('user-not-found')) {
//       return 'No account found with this email';
//     } else if (error.contains('user-disabled')) {
//       return 'This account has been disabled';
//     } else if (error.contains('too-many-requests')) {
//       return 'Too many attempts. Please try again later';
//     } else if (error.contains('network-request-failed')) {
//       return 'Network error. Please check your connection';
//     } else if (error.contains('invalid-email')) {
//       return 'Invalid email format';
//     } else {
//       return 'Operation failed. Please try again';
//     }
//   }
// }

import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famzy_tourz_v2/data/services/email_auth_service.dart';
import 'package:famzy_tourz_v2/data/services/firestor_user_service.dart';
import 'package:famzy_tourz_v2/data/services/google_auth_service.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/data/services/session_service.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final NavigationService _navigation = NavigationService();
  final GoogleAuthService _googleAuth = GoogleAuthService.instance;

  // AuthProvider() {
  //   startEmailVerificationFlow();
  // }

  bool _loading = false;
  bool get loading => _loading;

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  //check profile completeness
  Future<bool> checkAndSyncProfileStatus(String uid) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      final data = doc.data();
      final bool hasAge = data != null && data['age'] != null;

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasAge', hasAge);

      return hasAge;
    } catch (e) {
      // In production, log this error to a service like Sentry or Crashlytics
      print('Error syncing profile status: $e');
      return false;
    }
  }

  //email & password signin for existing account
  Future<void> signInWithEmail(String email, String password) async {
    try {
      _setLoading(true);

      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      await HapticFeedback.lightImpact();

      _navigation.showSnackBar(
        title: 'Welcome Back',
        message: 'Signed in successfully',
        type: ContentType.success,
      );

      final status = await SessionService.getSessionStatus();

      print('*********navigation to be held in sign in');

      WidgetsBinding.instance.addPostFrameCallback((_) {
        // _navigation.navigateAndClearStack(AppRoutes.main);
        if (!status.isEmailVerified) {
          _navigation.navigateReplacement(AppRoutes.emailVerification);
          return;
        }

        if (!status.hasAdditionalInfo) {
          _navigation.navigateReplacement(AppRoutes.additionalInfoScreen);
          return;
        }

        _navigation.navigateReplacement(AppRoutes.main);
      });
    } on FirebaseAuthException catch (e) {
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Sign In Failed',
        message: _getFirebaseErrorMessage(e.code),
        type: ContentType.failure,
      );
    } catch (e) {
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Error',
        message: 'Something went wrong. Please try again',
        type: ContentType.failure,
      );
    } finally {
      _setLoading(false);
      print('*************finally of sign in button called');
    }
  }

  // //  google sign in for existing users
  // Future<void> signInWithGoogle() async {
  //   try {
  //     _setLoading(true);

  //     // GoogleAuthService class handles firestore saving for new users
  //     await _googleAuth.signInWithGoogle();

  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('isLoggedIn', true);

  //     HapticFeedback.lightImpact();

  //     _navigation.showSnackBar(
  //       title: 'Success',
  //       message: 'Signed in with Google',
  //       type: ContentType.success,
  //     );

  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       _navigation.navigateReplacement(AppRoutes.main);
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     HapticFeedback.mediumImpact();
  //     _navigation.showSnackBar(
  //       title: 'Google Sign In Failed',
  //       message: _getFirebaseErrorMessage(e.code),
  //       type: ContentType.failure,
  //     );
  //   } catch (e) {
  //     HapticFeedback.mediumImpact();
  //     _navigation.showSnackBar(
  //       title: 'Error',
  //       message: 'Google sign in failed. Please try again',
  //       type: ContentType.failure,
  //     );
  //   } finally {
  //     _setLoading(false);
  //   }
  // }

  // //  google sign in
  // Future<void> signInWithGoogle() async {
  //   try {
  //     _setLoading(true);
  //     //GoogleAuthService class handles firestore saving for new users
  //     final result = await _googleAuth.signInWithGoogle();

  //     //user cancelled google signin do nothing
  //     if (result == null) {
  //       return;
  //     }

  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('isLoggedIn', true);

  //     await HapticFeedback.lightImpact();

  //     _navigation.showSnackBar(
  //       title: 'Success',
  //       message: 'Signed in with Google',
  //       type: ContentType.success,
  //     );

  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       if (result.isNewUser) {
  //         _navigation.navigateReplacement(
  //           AppRoutes.additionalInfoScreen,
  //           arguments: result.user,
  //         );
  //       } else {
  //         _navigation.navigateReplacement(AppRoutes.main);
  //       }
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     HapticFeedback.mediumImpact();
  //     _navigation.showSnackBar(
  //       title: 'Google Sign In Failed',
  //       message: _getFirebaseErrorMessage(e.code),
  //       type: ContentType.failure,
  //     );
  //   } catch (_) {
  //     HapticFeedback.mediumImpact();
  //     _navigation.showSnackBar(
  //       title: 'Error',
  //       message: 'Google sign in failed. Please try again',
  //       type: ContentType.failure,
  //     );
  //   } finally {
  //     _setLoading(false);
  //   }
  // }

  // Future<void> signInWithGoogle() async {
  //   try {
  //     _setLoading(true);

  //     final result = await _googleAuth
  //         .signInWithGoogle()
  //         .timeout(const Duration(seconds: 15))
  //         .then((value) {
  //           return;
  //         });

  //     // user cancelled google sign in
  //     if (result == null) {
  //       return;
  //     }

  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('isLoggedIn', true);

  //     final hasAddInfo = await checkAndSyncProfileStatus(result.user.uid);
  //     // // check profile completeness
  //     // final doc = await FirebaseFirestore.instance
  //     //     .collection('users')
  //     //     .doc(result.user.uid)
  //     //     .get();

  //     // final data = doc.data();
  //     // final hasAddInfo = data != null && data['age'] != null;
  //     // // final hasGender = data != null && data['gender'] != null; //one is enough
  //     // await prefs.setBool('hasAge', hasAddInfo);

  //     await HapticFeedback.lightImpact();

  //     _navigation.showSnackBar(
  //       title: 'Success',
  //       message: 'Signed in with Google',
  //       type: ContentType.success,
  //     );

  //     WidgetsBinding.instance.addPostFrameCallback((_) async {
  //       if (!hasAddInfo) {
  //         await _navigation.navigateReplacement(AppRoutes.additionalInfoScreen);
  //       } else {
  //         await prefs.setBool('isProfileCompleted', true);
  //         await _navigation.navigateReplacement(AppRoutes.main);
  //       }
  //     });
  //   } on TimeoutException {
  //     await HapticFeedback.mediumImpact();
  //     _navigation.showSnackBar(
  //       title: 'Timeout',
  //       message: 'Google sign in took too long. Please try again',
  //       type: ContentType.warning,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     await HapticFeedback.mediumImpact();
  //     _navigation.showSnackBar(
  //       title: 'Google Sign In Failed',
  //       message: _getFirebaseErrorMessage(e.code),
  //       type: ContentType.failure,
  //     );
  //   } catch (_) {
  //     await HapticFeedback.mediumImpact();
  //     _navigation.showSnackBar(
  //       title: 'Error',
  //       message: 'Google sign in failed. Please try again',
  //       type: ContentType.failure,
  //     );
  //   } finally {
  //     _setLoading(false);
  //   }
  // }
  Future<void> signInWithGoogle() async {
    try {
      _setLoading(true);

      final result = await _googleAuth.signInWithGoogle();
      // .timeout(
      //   const Duration(seconds: 15),
      // );

      //user cancelled
      if (result == null) {
        _setLoading(false);
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      await HapticFeedback.lightImpact();

      _navigation.showSnackBar(
        title: 'Success',
        message: 'Signed in with Google',
        type: ContentType.success,
      );

      //to ask where to go
      final status = await SessionService.getSessionStatus();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!status.isEmailVerified) {
          _navigation.navigateReplacement(AppRoutes.emailVerification);
          return;
        }

        if (!status.hasAdditionalInfo) {
          _navigation.navigateReplacement(AppRoutes.additionalInfoScreen);
          return;
        }

        _navigation.navigateReplacement(AppRoutes.main);
      });
    } on TimeoutException {
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Timeout',
        message: 'Google sign in took too long. Please try again',
        type: ContentType.warning,
      );
    } on FirebaseAuthException catch (e) {
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Google Sign In Failed',
        message: _getFirebaseErrorMessage(e.code),
        type: ContentType.failure,
      );
    } catch (_) {
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Error',
        message: 'Google sign in failed. Please try again',
        type: ContentType.failure,
      );
    } finally {
      _setLoading(false);
    }
  }

  Future<void> submitAdditionalInfo({
    required int age,
    required String gender,
  }) async {
    try {
      _setLoading(true);

      await FirestoreUserService.addInfo(age, gender);

      await HapticFeedback.lightImpact();

      _navigation.showSnackBar(
        title: 'Profile Updated',
        message: 'Your information has been saved',
        type: ContentType.success,
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigation.navigateReplacement(AppRoutes.main);
      });
    } catch (_) {
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Error',
        message: 'Failed to save information',
        type: ContentType.failure,
      );
    } finally {
      _setLoading(false);
    }
  }

  //if new, signn up using email & password
  Future<void> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
    required int age,
    required String? gender,
  }) async {
    try {
      _setLoading(true);

      //create firebase user
      final userCred = await EmailAuthService.instance.signUpWithEmail(
        email,
        password,
      );
      final user = userCred.user;
      if (user == null) {
        throw Exception('Failed to create user.');
      }

      //save user in Firestore
      await EmailAuthService.instance.saveUserToFirestore(
        uid: user.uid,
        fullName: fullName,
        email: email,
        age: age,
        gender: gender ?? '',
        photoUrl: '',
      );

      //logged in saved locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      // await prefs.setBool('isProfileCompleted', true);

      //send verification email
      await EmailAuthService.instance.sendVerificationEmail(user);

      await HapticFeedback.lightImpact();

      _navigation.showSnackBar(
        title: 'Account Created',
        message: 'Verification email has been sent',
        type: ContentType.success,
      );

      _setLoading(false);
      //navigate to email verification pending screen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigation.navigateAndClearStack(AppRoutes.emailVerification);
      });
    } on FirebaseAuthException catch (e) {
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Sign Up Failed',
        message: _getFirebaseErrorMessage(e.code),
        type: ContentType.failure,
      );
    } catch (e) {
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Error',
        message: 'Sign up failed. Please try again',
        type: ContentType.failure,
      );
    } finally {
      _setLoading(false);
      print('***setloadin before email verify pend screen: $_loading');
    }
  }

  // firebase error messages
  String _getFirebaseErrorMessage(String code) {
    switch (code) {
      case 'wrong-password':
      case 'invalid-credential':
        return 'Invalid email or password';
      case 'user-not-found':
        return 'No account found with this email';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later';
      case 'network-request-failed':
        return 'Network error. Please check your connection';
      case 'invalid-email':
        return 'Invalid email format';
      case 'email-already-in-use':
        return 'Email is already registered';
      case 'weak-password':
        return 'Password is too weak';
      default:
        return 'Operation failed. Please try again';
    }
  }

  bool _emailChecking = false;
  bool _canResendEmail = false;
  int _resendCooldown = 60;

  bool get emailChecking => _emailChecking;
  bool get canResendEmail => _canResendEmail;
  int get resendCooldown => _resendCooldown;

  Timer? _verificationTimer;
  Timer? _cooldownTimer;

  void startEmailVerificationFlow() {
    _navigation.showSnackBar(
      title: 'Action Required!',
      message: 'Please check your inbox to activate your account.',
      type: ContentType.warning,
    );
    _startVerificationCheck();
    _startCooldownTimer();
  }

  void _startVerificationCheck() {
    _verificationTimer?.cancel();
    _verificationTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => checkEmailVerification(),
    );
  }

  void _startCooldownTimer() {
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_resendCooldown > 0) {
        _resendCooldown--;
      } else {
        _canResendEmail = true;
      }
      notifyListeners();
    });
  }

  Future<void> checkEmailVerification() async {
    print('************email checking start loading is now $_loading');
    if (_emailChecking) return;

    try {
      print('************email checking trying');
      _emailChecking = true;
      notifyListeners();

      print('************email checking trying4');
      await _auth.currentUser?.reload();
      print('************email checking trying1');
      final user = _auth.currentUser;

      print('************email checking trying3');
      if (user != null && user.emailVerified) {
        print('************email checking trying2');
        _verificationTimer?.cancel();
        _cooldownTimer?.cancel();

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isEmailVerified', true);
        await prefs.setBool('isProfileCompleted', true);
        print('********isemail in pend scrn:  true');
        print('********isprofilecompleted in pend scrn: true');

        _setLoading(false);

        // await _navigation.navigateAndClearStack(AppRoutes.main);
        //////******navigate without await to avoid finally block interference
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _navigation.navigateAndClearStack(AppRoutes.main);
        });
      }
    }
    ////*****no finally block because it wait for await navigation
    finally {
      _emailChecking = false;
      print('************email checking done loading is $_loading');
    }
  }

  Future<void> resendVerificationEmail() async {
    if (!_canResendEmail) return;

    _setLoading(true);
    _canResendEmail = false;
    _resendCooldown = 60;
    notifyListeners();

    try {
      await _auth.currentUser?.sendEmailVerification();

      _navigation.showSnackBar(
        title: 'Email Sent',
        message: 'Verification email has been resent',
        type: ContentType.success,
      );
    } finally {
      _setLoading(false);
    }
  }

  void disposeEmailVerificationFlow() {
    _verificationTimer?.cancel();
    _cooldownTimer?.cancel();
    checkEmailVerification();
    print('***setloadin in pend screen after disposal: $_loading');
  }

  Future<void> emailSignOut(BuildContext context) async {
    try {
      print('******sigout access set loading is $_loading');
      _setLoading(true);

      await _auth.signOut();
      print('******sign out auth done');

      await GoogleSignIn.instance.signOut(); //only gmail signout

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
      await prefs.remove('isProfileCompleted');
      await prefs.clear();

      print('*****sign out shared preference cleared only isLoggedIn');

      await HapticFeedback.lightImpact();

      _setLoading(false);
      print('***** isloading before nav to welcome');

      print('***setloadin before welcome screen: $_loading');
      await _navigation.navigateAndClearStack(AppRoutes.welcome);
    } catch (e) {
      _navigation.showSnackBar(title: 'Sign out failed:', message: '$e');
    } finally {
      _setLoading(false);
      print('******loading is false now after nav to welcom done');
    }
  }
}
