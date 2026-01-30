// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:famzy_tourz_v2/data/services/google_auth_service.dart';
// import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
// import 'package:famzy_tourz_v2/routes/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SignUpController {
//   final TextEditingController fullName = TextEditingController();
//   final TextEditingController email = TextEditingController();
//   final TextEditingController password = TextEditingController();
//   final TextEditingController confirmPassword = TextEditingController();
//   final TextEditingController age = TextEditingController();

//   String? gender;

//   final ValueNotifier<bool> isLoading = ValueNotifier(false);

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> signUp(BuildContext context) async {
//     if (password.text.trim() != confirmPassword.text.trim()) {
//       NavigationService().showSnackBar("Passwords do not match");
//       return;
//     }

//     isLoading.value = true;

//     try {
//       final userCred = await _auth.createUserWithEmailAndPassword(
//         email: email.text.trim(),
//         password: password.text.trim(),
//       );

//       await _firestore.collection("UserDetails").doc(userCred.user!.uid).set({
//         "fullName": fullName.text.trim(),
//         "email": email.text.trim(),
//         "age": int.tryParse(age.text.trim()) ?? 0,
//         "gender": gender,
//         "createdAt": FieldValue.serverTimestamp(),
//         "userId": userCred.user!.uid,
//         "photoURL": "",
//       });

//       // store login status
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setBool("isLoggedIn", true);

//       // Navigate to email verification screen → OR → main screen
//       NavigationService().navigateReplacement(AppRoutes.main);
//     } catch (e) {
//       NavigationService().showSnackBar(e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> signInWithGoogle(BuildContext context) async {
//     await GoogleAuthService.instance.signInWithGoogle(context);
//   }
// }
