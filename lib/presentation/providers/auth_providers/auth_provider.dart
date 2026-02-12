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
//created by: FAMZY CodeWorks
import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:famzy_tourz_v2/data/services/auth-services/email_auth_service.dart';
import 'package:famzy_tourz_v2/data/services/auth-services/firestor_user_service.dart';
import 'package:famzy_tourz_v2/data/services/auth-services/google_auth_service.dart';
import 'package:famzy_tourz_v2/data/services/auth-services/password_reset_service.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/data/services/session_service.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/user_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/dialogs/custom_alert_dialogs.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final NavigationService _navigation = NavigationService();
  final GoogleAuthService _googleAuth = GoogleAuthService.instance;

  final UserProvider _userProvider;

  AuthProvider(this._userProvider);
  bool _loading = false;
  bool get loading => _loading;

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void resetLoading() {
    _loading = false;
    notifyListeners();
  }

  String? _uid;
  String? get uid => _uid;

  bool get isAuthenticated => _uid != null;

  void setUid(String uid) {
    _uid = uid;
    notifyListeners();
  }

  void clear() {
    _uid = null;
    notifyListeners();
  }

  // //check profile completeness
  // Future<bool> checkAndSyncProfileStatus(String uid) async {
  //   try {
  //     final doc = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(uid)
  //         .get();

  //     final data = doc.data();
  //     final bool hasAge = data != null && data['age'] != null;

  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('hasAge', hasAge);

  //     return hasAge;
  //   } catch (e) {
  //     // In production, log this error to a service like Sentry or Crashlytics
  //     return false;
  //   }
  // }

  int _requestSessionId = 0; // The "Cancel Token" counter
  // Call this when the user clicks "Back"
  void cancelAuthentication() {
    _requestSessionId++; // This invalidates the current signInWithEmail "session"
    _setLoading(false);
    debugPrint('******loading in cancel auth= $loading');
    notifyListeners();
  }

  //email & password signin for existing account
  Future<void> signInWithEmail(String email, String password) async {
    // // Increment counter to mark a NEW request session
    // final int sessionId = ++_activeRequestCounter;
    // Capture the ID at the start of THIS specific function call
    final int currentSessionId = _requestSessionId;
    try {
      _setLoading(true);

      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // --- THE CANCEL CHECK ---
      // If the user pressed 'Back', cancelAuthentication() was called,
      // incrementing _requestSessionId. Now currentId != _requestSessionId.
      if (currentSessionId != _requestSessionId) return;

      final firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        setUid(firebaseUser.uid);
        // Load user data via UserProvider if context is available
        await _userProvider.loadUser(firebaseUser.uid);
        debugPrint('*****here we go to sign in');
      }
      debugPrint('***no way');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      await HapticFeedback.lightImpact();

      _navigation.showSnackBar(
        title: 'Welcome Back',
        message: 'Signed in successfully',
        type: ContentType.success,
      );

      final status = await SessionService.getSessionStatus();
      print('****sign in is email verified: ${status.isEmailVerified}');
      print('****has additioinal info: ${status.hasAdditionalInfo}');
      print('****is logged in: ${status.isLoggedIn}');
      print('****is profile completed : ${status.isProfileCompleted}');

      // 2. Final check before we trigger ANY navigation side effects
      if (currentSessionId == _requestSessionId) {
        if (!status.isEmailVerified) {
          await handleEmailVerification(null);
        } else if (!status.hasAdditionalInfo) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _navigation.navigateAndClearStack(AppRoutes.additionalInfoScreen);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _navigation.navigateAndClearStack(AppRoutes.main);
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Sign In Failed',
        message: _getFirebaseErrorMessage(e.code),
        type: ContentType.failure,
      );
    } catch (e) {
      if (currentSessionId != _requestSessionId) return;
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Error',
        message: 'Something went wrong. Please try again',
        type: ContentType.failure,
      );
    } finally {
      // Only set loading to false if this is still the active session
      if (currentSessionId == _requestSessionId) {
        _setLoading(false);
      }
    }
  }

  Future<void> signInWithGoogle() async {
    final currentSessionId = _requestSessionId;
    try {
      _setLoading(true);

      final result = await _googleAuth.signInWithGoogle();

      //user cancelled
      if (result == null) {
        _setLoading(false);
        return;
      }
      debugPrint('***here we go isnnew user: ${result.isNewUser}');

      if (currentSessionId != _requestSessionId) return;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setBool('isEmailVerified', true);

      await HapticFeedback.lightImpact();

      _navigation.showSnackBar(
        title: 'Success',
        message: 'Signed in with Google',
        type: ContentType.success,
      );
      if (result.isNewUser) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _navigation.navigateAndClearStack(AppRoutes.additionalInfoScreen);
        });
      }
      //load user info if already registered
      final firebaseUser = _auth.currentUser;

      if (firebaseUser != null) {
        debugPrint('********doen"$firebaseUser');
        setUid(firebaseUser.uid);
        await _userProvider.loadUser(firebaseUser.uid);
      }

      //to ask where to go
      final status = await SessionService.getSessionStatus();

      if (currentSessionId == _requestSessionId) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!status.hasAdditionalInfo) {
            _navigation.navigateAndClearStack(AppRoutes.additionalInfoScreen);
            return;
          }
          _navigation.navigateAndClearStack(AppRoutes.main);
        });
      }
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
    final currentSessionId = _requestSessionId;
    try {
      _setLoading(true);

      debugPrint('*****submitting');
      await FirestoreUserService.addInfo(age, gender);
      if (currentSessionId != _requestSessionId) return;
      debugPrint('*****submitted');
      await HapticFeedback.lightImpact();

      _navigation.showSnackBar(
        title: 'Profile Updated',
        message: 'Your information has been saved',
        type: ContentType.success,
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasAge', true);
      await prefs.setBool('isProfileCompleted', true);

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
    final currentSessionId = _requestSessionId;
    try {
      _setLoading(true);

      debugPrint('***1st step');
      //create firebase user
      final userCred = await EmailAuthService.instance.signUpWithEmail(
        email,
        password,
      );
      if (currentSessionId != _requestSessionId) return;
      debugPrint('***2nd step');
      final user = userCred.user;
      if (user == null) {
        throw Exception('Failed to create user.');
      }
      setUid(user.uid);
      await _userProvider.loadUser(user.uid);

      debugPrint('***3rd step');
      //save user in Firestore
      await EmailAuthService.instance.saveUserToFirestore(
        uid: user.uid,
        fullName: fullName,
        email: email,
        age: age,
        gender: gender ?? '',
        photoUrl: '',
      );

      if (currentSessionId != _requestSessionId) return;
      debugPrint('***4thst step');
      //logged in saved locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setBool('hasAdditionalInfo', true);
      await handleEmailVerification(user);

      _navigation.showSnackBar(
        title: 'Account Created',
        message: 'Verification email has been sent',
        type: ContentType.success,
      );
      debugPrint('***5th step');
      // await prefs.setBool('isProfileCompleted', true);
      // print('*****is logged in: ${getbool}');

      // //send verification email
      // await EmailAuthService.instance.sendVerificationEmail(user);

      // await HapticFeedback.lightImpact();

      // // _navigation.showSnackBar(
      // //   title: 'Account Created',
      // //   message: 'Verification email has been sent',
      // //   type: ContentType.success,
      // // );

      // // _setLoading(false);
      // // 2. NORMAL SESSION FLOW
      // final status = await SessionService.getSessionStatus();
      // print('******signup screen: is logged in: ${status.isLoggedIn}');
      // print('******is profile completed: ${status.isProfileCompleted}');
      // print('******has additional info: ${status.hasAdditionalInfo}');
      // print('******is email verified: ${status.isEmailVerified}');
      // //navigate to email verification pending screen
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   _navigation.navigateAndClearStack(AppRoutes.emailVerification);
      // });
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
    }
  }

  Future<void> handleEmailVerification(User? user) async {
    try {
      await EmailAuthService.instance.sendVerificationEmail(user);
      await HapticFeedback.lightImpact();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigation.navigateAndClearStack(AppRoutes.emailVerification);
      });
    } catch (e) {
      _navigation.showSnackBar(
        title: 'Error in Sending verification Email',
        message: 'Error: $e',
      );
    } finally {
      _setLoading(false);
    }
  }

  String _getFirebaseErrorMessage(String code) {
    switch (code) {
      // --- AUTH SPECIFIC ---
      case 'wrong-password':
        return 'Incorrect Password';
      case 'invalid-credential':
        return 'Invalid email or password';
      case 'user-not-found':
        return 'No account found with this email';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'invalid-email':
        return 'Invalid email format';
      case 'email-already-in-use':
        return 'Email is already registered';
      case 'weak-password':
        return 'Password is too weak';
      // --- DEEP LINK / ACTION CODE SPECIFIC ---
      case 'invalid-action-code':
        return 'This link is invalid, expired, or has already been used.';
      case 'expired-action-code':
        return 'This link has expired. Please request a new one.';
      case 'action-code-settings-invalid':
        return 'There was a configuration error. Please contact support.';
      // --- GENERAL ---
      case 'network-request-failed':
        return 'No internet connection. Please check your network.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
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
      const Duration(seconds: 10),
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
    if (_emailChecking) return;

    try {
      _emailChecking = true;
      notifyListeners();

      await _auth.currentUser?.reload();
      final user = _auth.currentUser;

      // print('user*****: ${user!.emailVerified}');
      // 2. NORMAL SESSION FLOW
      // final status = await SessionService.getSessionStatus();
      // print('******email pending screen: is logged in: ${status.isLoggedIn}');
      // print('******is profile completed: ${status.isProfileCompleted}');
      // print('******has additional info: ${status.hasAdditionalInfo}');
      // print('******is email verified: ${status.isEmailVerified}');
      if (user != null && user.emailVerified) {
        _verificationTimer?.cancel();
        _cooldownTimer?.cancel();

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isEmailVerified', true);
        await prefs.setBool('isProfileCompleted', true);

        // _setLoading(false);

        //////******navigate without await to avoid finally block interference
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _navigation.navigateAndClearStack(AppRoutes.main);
        });
      }
    } catch (e) {
      _navigation.showSnackBar(
        title: 'Status Check Failed',
        message: 'We encountered a minor issue while checking...',
        type: ContentType.warning,
      );
    } finally {
      _emailChecking = false;
      _setLoading(false);
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
  }

  Future<void> emailSignOut() async {
    try {
      _setLoading(true);
      _navigation.showSnackBar(
        title: 'Signing you out',
        message: 'You will be signed out and returned to the welcome screen',
        type: ContentType.help,
        duration: 2,
      );

      //  Sign out from all services
      await _auth.signOut();
      // await GoogleSignIn.instance.signOut();
      await GoogleAuthService.instance.googleSignOut();

      // //clear Local Data base
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.clear(); //total reset for safety
      await SessionService.clearSession();

      await HapticFeedback.lightImpact();

      _setLoading(false);

      await _navigation.navigateAndClearStack(AppRoutes.welcome);
    } catch (e) {
      _setLoading(false);
      _navigation.showSnackBar(
        title: 'Sign out failed',
        message: 'Please check your connection and try again.',
        type: ContentType.failure,
      );
    }
  }

  //reset password logic

  //vilidate email
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    if (!isValidEmail(email)) {
      _navigation.showSnackBar(
        title: 'Invalid Email',
        message: 'Please enter a valid email address',
        type: ContentType.failure,
      );
      return;
    }

    //ask confirmation using custom dialog
    final confirmed = await AppConfirmDialog.show(
      context,
      title: 'Confirm Email',
      message: 'Is this email correct?\n\n$email',
      confirmText: 'Send Reset Link',
      icon: Icons.mark_email_read_rounded,
    );

    if (!confirmed) return;

    try {
      _setLoading(true);

      await PasswordResetService.sendResetEmail(email);

      await HapticFeedback.lightImpact();

      _navigation.showSnackBar(
        title: 'Email Sent',
        // message: 'Password reset link sent to $email',
        message:
            'If an account exists for $email, you will receive a reset link shortly.',
        type: ContentType.success,
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigation.navigateReplacement(
          AppRoutes.resetEmailSent,
          arguments: email,
        );
      });
    } on FirebaseAuthException catch (e) {
      _navigation.showSnackBar(
        title: 'Reset Email Sending Failed',
        message: _getFirebaseErrorMessage(e.code),
        type: ContentType.failure,
      );
    } finally {
      _setLoading(false);
    }
  }

  bool _showResetSuccessAnimation = false;
  bool get showResetSuccessAnimation => _showResetSuccessAnimation;
  //reset password screen
  Future<void> confirmResetPassword({
    required String oobCode,
    required String newPassword,
  }) async {
    try {
      _setLoading(true);

      await _auth.confirmPasswordReset(code: oobCode, newPassword: newPassword);
      _showResetSuccessAnimation = true;
      notifyListeners();

      _navigation.showSnackBar(
        title: 'Password ',
        message:
            'Your password has been reset successfully \nEnter credentials to Log In',
        type: ContentType.success,
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigation.navigateAndClearStack(AppRoutes.welcome);
      });
    } on FirebaseAuthException catch (e) {
      print('$e');
      _navigation.showSnackBar(
        title: 'Reset Failed',
        message: _getFirebaseErrorMessage(e.code),
        // message: '$e',
        type: ContentType.failure,
      );
      // If the link is dead, send them back to start the process over
      if (e.code == 'invalid-action-code') {
        Future.delayed(const Duration(seconds: 2), () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _navigation.navigateAndClearStack(AppRoutes.welcome);
          });
        });
      }
    } finally {
      _setLoading(false);
    }
  }

  // Function to handle cleanup after animation finishes
  void onResetAnimationComplete() {
    _showResetSuccessAnimation = false;
    notifyListeners();
    _navigation.navigateAndClearStack(AppRoutes.login);
  }
}
