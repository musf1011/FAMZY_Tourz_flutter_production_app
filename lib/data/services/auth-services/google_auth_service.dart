// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class GoogleAuthService {
//   GoogleAuthService._();
//     bool _isGoogleAuthInitialized = false;

//   static final GoogleAuthService instance = GoogleAuthService._();
//     Future<void> initialize() async {
//     if (_isGoogleAuthInitialized) return;
//     await GoogleSignIn.instance.initialize();
//     _isGoogleAuthInitialized = true;
//   }
//   /// 🔥 Sign In with Google → FirebaseAuth → Firestore
//   Future<User?> signInWithGoogle(BuildContext context) async {
//     try {
//       await initialize();

//       // Start Google sign-in (NEW API)
//       final account = await GoogleSignIn.instance.authenticate();

//       // if (account == null) return null;

//       // Get OAuth tokens
//       final authClient = account.authorizationClient;

//       final tokens = await authClient.authorizationForScopes(const [
//         "email",
//         "profile",
//       ]);

//       final accessToken = tokens?.accessToken;
//       // final idToken = tokens?.idToken;
//       final idToken = tokens?.accessToken;

//       if (accessToken == null) {
//         debugPrint("❌ Google OAuth token missing.");
//         return null;
//       }

//       // Convert Google OAuth → Firebase credential
//       final credential = GoogleAuthProvider.credential(
//         accessToken: accessToken,
//         idToken: idToken, // may be null on Android (OK)
//       );

//       // Firebase sign-in
//       final userCredential = await FirebaseAuth.instance.signInWithCredential(
//         credential,
//       );

//       final user = userCredential.user;

//       if (user == null) return null;

//       // Store user in Firestore (Create or Update)
//       await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
//         "uid": user.uid,
//         "name": user.displayName,
//         "email": user.email,
//         "photoUrl": user.photoURL,
//         "signInMethod": "google",
//         "createdAt": FieldValue.serverTimestamp(),
//         "updatedAt": FieldValue.serverTimestamp(),
//       }, SetOptions(merge: true));

//       return user;
//     } catch (e) {
//       debugPrint("🔥 Google Sign-In Error: $e");
//       return null;
//     }
//   }

//   Future<void> signOut() async {
//     await GoogleSignIn.instance.signOut();
//     await FirebaseAuth.instance.signOut();
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class GoogleAuthService {
// //   // GoogleAuthService._();

// //   // static final GoogleAuthService instance = GoogleAuthService._();

// //   final _googleSignIn = GoogleSignIn.instance;

// //   AuthService() {
// //     _initializeGoogleSignIn();
// //   }

// //   Future<void> _initializeGoogleSignIn() async {
// //     try {
// //       await _googleSignIn.initialize();
// //       _isGoogleAuthInitialized = true;
// //     } catch (e) {
// //       print('Failed to initialize Google Sign-In: $e');
// //     }
// //   }

// //   /// 🔥 Sign In with Google → FirebaseAuth → Firestore
// //   Future<User?> signInWithGoogle(BuildContext context) async {
// //     try {
// //       await initialize();

// //       // Start Google sign-in (NEW API)
// //       final account = await GoogleSignIn.instance.authenticate();

// //       // if (account == null) return null;

// //       // Get OAuth tokens
// //       final authClient = account.authorizationClient;

// //       final tokens = await authClient.authorizationForScopes(const [
// //         "email",
// //         "profile",
// //       ]);

// //       final accessToken = tokens?.accessToken;
// //       // final idToken = tokens?.idToken;
// //       final idToken = tokens?.accessToken;

// //       if (accessToken == null) {
// //         debugPrint("❌ Google OAuth token missing.");
// //         return null;
// //       }

// //       // Convert Google OAuth → Firebase credential
// //       final credential = GoogleAuthProvider.credential(
// //         accessToken: accessToken,
// //         idToken: idToken, // may be null on Android (OK)
// //       );

// //       // Firebase sign-in
// //       final userCredential = await FirebaseAuth.instance.signInWithCredential(
// //         credential,
// //       );

// //       final user = userCredential.user;

// //       if (user == null) return null;

// //       // Store user in Firestore (Create or Update)
// //       await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
// //         "uid": user.uid,
// //         "name": user.displayName,
// //         "email": user.email,
// //         "photoUrl": user.photoURL,
// //         "signInMethod": "google",
// //         "createdAt": FieldValue.serverTimestamp(),
// //         "updatedAt": FieldValue.serverTimestamp(),
// //       }, SetOptions(merge: true));

// //       return user;
// //     } catch (e) {
// //       debugPrint("🔥 Google Sign-In Error: $e");
// //       return null;
// //     }
// //   }

// //   Future<void> signOut() async {
// //     await GoogleSignIn.instance.signOut();
// //     await FirebaseAuth.instance.signOut();
// //   }
// // }

// // class GoogleAuthClass {
// //   authFunction() {
// //     _authInitialization();
// //   }

// //   Future _authInitialization() async {
// //     GoogleSignIn.instance.initialize();
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class GoogleAuthService {
//   GoogleAuthService._();
//   static final GoogleAuthService instance = GoogleAuthService._();

//   bool _initialized = false;

//   Future<void> initialize() async {
//     if (_initialized) return;
//     await GoogleSignIn.instance.initialize();
//     _initialized = true;
//   }

//   /// ✅ This is now 100% V1 behavior but with google_sign_in 7.2+
//   Future<void> signInWithGoogle(BuildContext context) async {
//     try {
//       await initialize();

//       // Start NEW Google sign in flow
//       final account = await GoogleSignIn.instance.authenticate();

//       if (account == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Google Sign-In canceled.")),
//         );
//         return;
//       }

//       // Get tokens (NEW API)
//       final authClient = account.authorizationClient;

//       final tokens = await authClient.authorizationForScopes(const [
//         "email",
//         "profile",
//       ]);

//       final accessToken = tokens?.accessToken;
//       // final idToken = tokens?.idToken;
//       final idToken = tokens?.accessToken;
//       // final idToken = googleAuthCredential.idToken;

//       if (accessToken == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Unable to retrieve Google token.")),
//         );
//         return;
//       }

//       // Firebase credential
//       final credential = GoogleAuthProvider.credential(
//         accessToken: accessToken,
//         idToken: idToken, // null is OK on Android
//       );

//       // Firebase login
//       final userCredential = await FirebaseAuth.instance.signInWithCredential(
//         credential,
//       );

//       final user = userCredential.user;
//       if (user == null) return;

//       // Check if new user (V1 behavior)
//       final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

//       // Save login locally (V1 behavior)
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('isLoggedIn', true);

//       if (isNewUser) {
//         // ✅ Same Firestore structure as V1
//         await FirebaseFirestore.instance
//             .collection('UserDetails')
//             .doc(user.uid)
//             .set({
//               'userId': user.uid,
//               'fullName': user.displayName,
//               'email': user.email,
//               'photoURL': user.photoURL,
//               'gender': null,
//               'age': null,
//               'createdAt': FieldValue.serverTimestamp(),
//             });

//         // Navigate to Add Info screen
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => AdditionalInfoScreen(user: user),
//           ),
//         );
//       } else {
//         // Existing user → MainScreen
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => MainScreen()),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Sign-In failed: $e")));
//     }
//   }

//   Future<void> signOut() async {
//     await GoogleSignIn.instance.signOut();
//     await FirebaseAuth.instance.signOut();
//   }
// }

import 'package:famzy_tourz_v2/data/models/google_signin_model.dart';
import 'package:famzy_tourz_v2/data/services/auth-services/firestor_user_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleAuthService {
  GoogleAuthService._();
  static final GoogleAuthService instance = GoogleAuthService._();

  // final NavigationService _navigation = NavigationService();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    await GoogleSignIn.instance.initialize();
    _initialized = true;
  }

  // Future<void> signInWithGoogle(BuildContext context) async {
  //   try {
  //     await initialize();
  //     print('****google initialized');

  //     //start new google sign in flow
  //     final account = await GoogleSignIn.instance.authenticate();
  //     print('****account authenticated');

  //     // Get tokens (NEW API)
  //     final authClient = account.authorizationClient;

  //     final tokens = await authClient.authorizationForScopes(const [
  //       "email",
  //       "profile",
  //     ]);
  //     print('****email & profile tokens are created');

  //     final accessToken = tokens?.accessToken;
  //     // final idToken = tokens?.accessToken;
  //     print('****acces tokens are collected');

  //     // Get the standard authentication object
  //     final googleAuth = account.authentication;

  //     // Use the tokens directly from the authentication object
  //     // final credential = GoogleAuthProvider.credential(
  //     //   idToken: googleAuth.idToken,
  //     // );
  //     final idToken = googleAuth.idToken;

  //     print('****id tokens are collected');

  //     if (accessToken == null) {
  //       _navigation.showSnackBar(
  //         title: 'Google Token not found',
  //         message: 'Unable to retrieve Google Token',
  //         type: ContentType.failure,
  //       );
  //       return;
  //     }

  //     // Firebase credential
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: accessToken,
  //       idToken: idToken,
  //     );

  //     print('****credentials from firebase are got');

  //     // Firebase login
  //     final userCredential = await FirebaseAuth.instance.signInWithCredential(
  //       credential,
  //     );
  //     print('****login done');
  //     final user = userCredential.user;
  //     if (user == null) return;

  //     // Check if new user (V1 behavior)
  //     final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

  //     // Save login locally (V1 behavior)
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('isLoggedIn', true);

  //     print('****islogedin true made');
  //     if (isNewUser) {
  //       print('****new user spotted');
  //       //  firestore_user_service.dart
  //       await FirestoreUserService.saveUserToFirestore();
  //       print('****firestore data saved');
  //       _navigation.navigateTo(AppRoutes.additionalInfoScreen, arguments: user);
  //       print('****navigationdone');
  //     } else {
  //       // if Existing user → MainScreen
  //       _navigation.navigateReplacement(AppRoutes.main);
  //     }
  //   } catch (e) {
  //     _navigation.showSnackBar(
  //       title: 'Google Sign-In failed',
  //       message: e.toString(),
  //       type: ContentType.failure,
  //     );
  //   }
  // }

  // Future<GoogleSignInResult?> signInWithGoogle() async {
  //   await initialize();
  //   //start new google sign in flow
  //   final account = await GoogleSignIn.instance.authenticate();

  //   //get tokens
  //   final authClient = account.authorizationClient;
  //   final tokens = await authClient.authorizationForScopes(const [
  //     'email',
  //     'profile',
  //   ]);

  //   final accessToken = tokens?.accessToken;
  //   final googleAuth = account.authentication;
  //   final idToken = googleAuth.idToken;

  //   if (accessToken == null || idToken == null) {
  //     throw FirebaseAuthException(
  //       code: 'missing-google-token',
  //       message: 'Google token not found',
  //     );
  //   }

  //   //firebase credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: accessToken,
  //     idToken: idToken,
  //   );

  //   // Firebase login
  //   final userCredential = await FirebaseAuth.instance.signInWithCredential(
  //     credential,
  //   );

  //   final user = userCredential.user;
  //   if (user == null) {
  //     throw FirebaseAuthException(
  //       code: 'null-user',
  //       message: 'Authentication failed',
  //     );
  //   }

  //   final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

  //   if (isNewUser) {
  //     await FirestoreUserService.saveUserToFirestore();
  //   }

  //   return GoogleSignInResult(user: user, isNewUser: isNewUser);
  // }
  Future<GoogleSignInResult?> signInWithGoogle() async {
    await initialize();

    // timeout handling
    final account = await GoogleSignIn.instance.authenticate().timeout(
      const Duration(seconds: 60),
    );

    // // user cancelled google picker
    // if (account == null) {
    //   return null;
    // }

    final authClient = account.authorizationClient;
    final tokens = await authClient.authorizationForScopes(const [
      'email',
      'profile',
    ]);

    final accessToken = tokens?.accessToken;
    final googleAuth = account.authentication;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null) {
      throw FirebaseAuthException(
        code: 'missing-google-token',
        message: 'Google token not found',
      );
    }

    final credential = GoogleAuthProvider.credential(
      accessToken: accessToken,
      idToken: idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    final user = userCredential.user;
    if (user == null) return null;

    final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

    // save base user data for new users
    if (isNewUser) {
      await FirestoreUserService.createNewUserInfo();
    }

    return GoogleSignInResult(user: user, isNewUser: isNewUser);
  }

  Future<void> googleSignOut() async {
    await GoogleSignIn.instance.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
