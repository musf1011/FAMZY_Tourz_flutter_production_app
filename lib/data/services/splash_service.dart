// // import 'dart:async';

// // import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
// // import 'package:famzy_tourz_v2/routes/app_routes.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // class Splashservices {
// //   final _auth = FirebaseAuth.instance;
// //   Future<void> isLogin(BuildContext context,AuthProvider auth) async{
// //     Timer(const Duration(seconds: 5), () async {
// //       await _auth.currentUser?.reload();
// //       final user = _auth.currentUser;
// //       final prefs = await SharedPreferences.getInstance();
// //       final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      
      
// //       // 1. Try to get the local value (returns null if never set)
// // bool? hasAge = prefs.getBool('hasAge');



// //       // if (isLoggedIn && user.emailVerified && hasAddInfo) {
// //       //   await NavigationService().navigateReplacement(AppRoutes.main);
// //       // }else if(isLoggedIn && !user.emailVerified){
// //      if(isLoggedIn){
      
// //       // 2. If it's null, it's a "Cache Miss" -> Go to Firebase
// // if (hasAge == null) {
// //   print("Cache Miss: Fetching profile status from Firebase...");
// //   String? uid = FirebaseAuth.instance.currentUser?.uid;
// //   hasAge = await auth.checkAndSyncProfileStatus(uid);
// // }

// // // 3. Now hasAge is guaranteed to be either true or false
// // final bool hasAddInfo = hasAge;
// //       if(!hasAddInfo && !user.emailVerified){
// //         //check in firebase that
// //       } 
// //      }    
// //       // }
// //       //  else { 
// //       //   await NavigationService().navigateReplacement(AppRoutes.welcome);
// //       // }
// //     });
// //   }
// // }




// import 'dart:async';

// import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
// import 'package:famzy_tourz_v2/routes/app_routes.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Splashservices {
//   final _auth = FirebaseAuth.instance;
//   Future<void> isLogin(BuildContext context,AuthProvider auth) async{
//     Timer(const Duration(seconds: 5), () async {
//       await _auth.currentUser?.reload();
//       final user = _auth.currentUser;
//       final prefs = await SharedPreferences.getInstance();
//       final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false; 
//       bool? hasAge = prefs.getBool('hasAge');
 
//      if(isLoggedIn){
//       if (hasAge == null) {
//         print("Cache Miss: Fetching profile status from Firebase...");
//         final String? uid = FirebaseAuth.instance.currentUser?.uid;
//         hasAge = await auth.checkAndSyncProfileStatus(uid);
//         }
//         final bool hasAddInfo = hasAge;
//       if(!hasAddInfo && !user.emailVerified){
        
//       } 
//      }     
//     });
//   }
// }
