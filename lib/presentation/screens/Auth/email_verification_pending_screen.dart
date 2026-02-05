// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../constants.dart';
// import '../../../routes/app_routes.dart';

// class EmailVerificationPendingScreen extends StatefulWidget {
//   const EmailVerificationPendingScreen({super.key});

//   @override
//   State<EmailVerificationPendingScreen> createState() =>
//       _EmailVerificationPendingScreenState();
// }

// class _EmailVerificationPendingScreenState
//     extends State<EmailVerificationPendingScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   bool isLoading = false;
//   bool isChecking = false;
//   bool canResendEmail = false;

//   int resendCooldown = 60;

//   Timer? _verificationTimer;
//   Timer? _cooldownTimer;

//   @override
//   void initState() {
//     super.initState();
//     _startVerificationCheck();
//     _startCooldownTimer();
//   }

//   @override
//   void dispose() {
//     _verificationTimer?.cancel();
//     _cooldownTimer?.cancel();
//     super.dispose();
//   }

//   /// 🔁 Periodically check email verification
//   void _startVerificationCheck() {
//     _verificationTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
//       await _checkEmailVerification();
//     });
//   }

//   /// ⏱ Cooldown for resend button
//   void _startCooldownTimer() {
//     _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
//       if (resendCooldown > 0) {
//         setState(() => resendCooldown--);
//       } else {
//         if (!canResendEmail) {
//           setState(() => canResendEmail = true);
//         }
//       }
//     });
//   }

//   /// ✅ Check verification status
//   Future<void> _checkEmailVerification() async {
//     if (isChecking) return;

//     try {
//       setState(() => isChecking = true);

//       await _auth.currentUser?.reload();
//       final user = _auth.currentUser;

//       if (user != null && user.emailVerified) {
//         _verificationTimer?.cancel();

//         // locally store
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setBool('isEmailVerified', true);

//         if (!mounted) return;

//         Navigator.pushReplacementNamed(context, AppRoutes.main);
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error checking verification: $e')),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() => isChecking = false);
//       }
//     }
//   }

//   /// 📧 Resend verification email
//   Future<void> resendVerificationEmail() async {
//     if (!canResendEmail) return;

//     setState(() {
//       isLoading = true;
//       canResendEmail = false;
//       resendCooldown = 60;
//     });

//     try {
//       await _auth.currentUser?.sendEmailVerification();

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Verification email resent')),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() => canResendEmail = true);
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Error: $e')));
//       }
//     } finally {
//       if (mounted) setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false, // 🚫 prevent back
//       child: Scaffold(
//         body: Container(
//           height: 1.sh,
//           width: 1.sw,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/bg_app.jpg'),
//               fit: BoxFit.fill,
//             ),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(height: 20.h),

//                 /// BACK + LOGO
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10.w),
//                   child: Row(
//                     crossAxisAlignment: .start,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           _auth.signOut();
//                           Navigator.pushReplacementNamed(
//                             context,
//                             AppRoutes.welcome,
//                           );
//                         },
//                         child: Icon(
//                           Icons.arrow_circle_left_outlined,
//                           size: 40.h,
//                           color: AppConstants.primaryColor,
//                         ),
//                       ),
//                       Expanded(
//                         child: Image.asset(
//                           'assets/logos/FAMZYLogo.png',
//                           height: .18.sh,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 SizedBox(height: 10.h),

//                 /// TITLE
//                 Text(
//                   'Verify Your Email',
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.playfairDisplay(
//                     fontSize: 28.sp,
//                     fontWeight: FontWeight.bold,
//                     color: AppConstants.primaryColor,
//                   ),
//                 ),

//                 SizedBox(height: 20.h),

//                 /// CONTENT CARD
//                 Padding(
//                   padding: EdgeInsets.all(20.w),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15.r),
//                       color: AppConstants.transGColor,
//                     ),
//                     padding: EdgeInsets.all(20.w),
//                     child: Column(
//                       children: [
//                         Text(
//                           'A verification email has been sent to your email address.\n\nPlease verify your email to continue.',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.poppins(
//                             fontSize: 15.sp,
//                             color: Colors.white,
//                           ),
//                         ),

//                         SizedBox(height: 30.h),

//                         /// RESEND BUTTON
//                         SizedBox(
//                           width: double.infinity,
//                           height: 50.h,
//                           child: ElevatedButton(
//                             style: AppConstants.primaryButtonStyle,
//                             onPressed: canResendEmail
//                                 ? resendVerificationEmail
//                                 : null,
//                             child: isLoading
//                                 ? const CircularProgressIndicator(
//                                     color: Colors.white,
//                                   )
//                                 : Text(
//                                     canResendEmail
//                                         ? 'Resend Verification Email'
//                                         : 'Resend in $resendCooldown sec',
//                                   ),
//                           ),
//                         ),

//                         SizedBox(height: 20.h),

//                         /// MANUAL REFRESH
//                         TextButton(
//                           onPressed: _checkEmailVerification,
//                           child: Text(
//                             'Already verified? Refresh status',
//                             style: GoogleFonts.poppins(
//                               fontSize: 14.sp,
//                               color: Colors.white,
//                               decoration: TextDecoration.underline,
//                             ),
//                           ),
//                         ),

//                         if (isChecking) ...[
//                           SizedBox(height: 10.h),
//                           Text(
//                             'Checking verification status...',
//                             style: TextStyle(
//                               color: Colors.white70,
//                               fontSize: 12.sp,
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../constants.dart';
// import '../../../routes/app_routes.dart';
// import '../../widgets/custom_loading_button.dart';

// class EmailVerificationPendingScreen extends StatefulWidget {
//   const EmailVerificationPendingScreen({super.key});

//   @override
//   State<EmailVerificationPendingScreen> createState() =>
//       _EmailVerificationPendingScreenState();
// }

// class _EmailVerificationPendingScreenState
//     extends State<EmailVerificationPendingScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   bool isLoading = false;
//   bool isChecking = false;
//   bool canResendEmail = false;

//   int resendCooldown = 60;

//   Timer? _verificationTimer;
//   Timer? _cooldownTimer;

//   @override
//   void initState() {
//     super.initState();
//     _startVerificationCheck();
//     _startCooldownTimer();
//   }

//   @override
//   void dispose() {
//     _verificationTimer?.cancel();
//     _cooldownTimer?.cancel();
//     super.dispose();
//   }

//   void _startVerificationCheck() {
//     _verificationTimer = Timer.periodic(
//       const Duration(seconds: 5),
//       (_) => _checkEmailVerification(),
//     );
//   }

//   void _startCooldownTimer() {
//     _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
//       if (resendCooldown > 0) {
//         setState(() => resendCooldown--);
//       } else {
//         setState(() => canResendEmail = true);
//       }
//     });
//   }

//   Future<void> _checkEmailVerification() async {
//     if (isChecking) return;

//     try {
//       setState(() => isChecking = true);

//       await _auth.currentUser?.reload();
//       final user = _auth.currentUser;

//       if (user != null && user.emailVerified) {
//         _verificationTimer?.cancel();

//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setBool('isEmailVerified', true);

//         if (!mounted) return;
//         Navigator.pushReplacementNamed(context, AppRoutes.main);
//       }
//     } finally {
//       if (mounted) setState(() => isChecking = false);
//     }
//   }

//   Future<void> resendVerificationEmail() async {
//     if (!canResendEmail) return;

//     setState(() {
//       isLoading = true;
//       canResendEmail = false;
//       resendCooldown = 60;
//     });

//     try {
//       await _auth.currentUser?.sendEmailVerification();
//     } finally {
//       if (mounted) setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         body: Container(
//           height: 1.sh,
//           width: 1.sw,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/bg_app.jpg'),
//               fit: BoxFit.fill,
//             ),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(height: 40.h),

//                 /// LOGO
//                 Image.asset(
//                   'assets/logos/FAMZYLogo.png',
//                   width: .8.sw,
//                   height: .2.sh,
//                 ),

//                 SizedBox(height: 10.h),

//                 /// TITLE
//                 Text(
//                   'Verify Your Email',
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.playfairDisplay(
//                     fontSize: 32.sp,
//                     fontWeight: FontWeight.bold,
//                     color: AppConstants.primaryColor,
//                   ),
//                 ),

//                 SizedBox(height: 20.h),

//                 /// CARD
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: .05.sw),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15.r),
//                       color: AppConstants.transGColor,
//                       border: Border.all(
//                         color: AppConstants.tertiaryColor,
//                         width: .5.r,
//                       ),
//                     ),
//                     padding: EdgeInsets.all(20.w),
//                     child: Column(
//                       children: [
//                         Text(
//                           'We have sent a verification email to your registered email address.\n\nPlease verify your email to continue.',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.poppins(
//                             fontSize: 15.sp,
//                             color: Colors.white,
//                           ),
//                         ),

//                         SizedBox(height: 30.h),

//                         /// RESEND BUTTON
//                         CustomLoadingButton(
//                           text: canResendEmail
//                               ? 'RESEND EMAIL'
//                               : 'RESEND IN $resendCooldown s',
//                           isLoading: isLoading,
//                           onPressed:
//                               canResendEmail ? resendVerificationEmail : () {},
//                         ),

//                         SizedBox(height: 15.h),

//                         /// REFRESH
//                         TextButton(
//                           onPressed: _checkEmailVerification,
//                           child: Text(
//                             'Already verified? Refresh status',
//                             style: GoogleFonts.poppins(
//                               fontSize: 14.sp,
//                               color: Colors.white,
//                               decoration: TextDecoration.underline,
//                             ),
//                           ),
//                         ),

//                         if (isChecking) ...[
//                           SizedBox(height: 10.h),
//                           Text(
//                             'Checking verification status...',
//                             style: TextStyle(
//                               color: Colors.white70,
//                               fontSize: 12.sp,
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 20.h),

//                 /// LOG OUT
//                 TextButton(
//                   onPressed: () async {
//                     await _auth.signOut();
//                     if (!mounted) return;
//                     Navigator.pushReplacementNamed(
//                       context,
//                       AppRoutes.welcome,
//                     );
//                   },
//                   child: Text(
//                     'Back to Welcome',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 13.sp,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/auth_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_app_background.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/sign_out_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmailVerificationPendingScreen extends StatefulWidget {
  const EmailVerificationPendingScreen({super.key});

  @override
  State<EmailVerificationPendingScreen> createState() =>
      _EmailVerificationPendingScreenState();
}

class _EmailVerificationPendingScreenState
    extends State<EmailVerificationPendingScreen> {
  @override
  void initState() {
    super.initState();

    //start verification & cooldown timers
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthProvider>().startEmailVerificationFlow();
    });
  }

  @override
  void dispose() {
    context.read<AuthProvider>().disposeEmailVerificationFlow();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      notAllowPop: true,
      child: Column(
        children: [
          SizedBox(height: 30.h),

          /// LOGO
          Image.asset(
            'assets/logos/FAMZYLogo.png',
            width: .8.sw,
            height: .2.sh,
          ),

          SizedBox(height: 20.h),

          /// TITLE
          Text(
            'Verify Your Email',
            style: GoogleFonts.playfairDisplay(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: AppConstants.primaryColor,
            ),
          ),

          SizedBox(height: 30.h),

          /// CARD
          Padding(
            padding: EdgeInsets.symmetric(horizontal: .06.sw),
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: Colors.white, width: .5.w),
                color: AppConstants.primaryTransGColor,
              ),
              child: Consumer<AuthProvider>(
                builder: (context, auth, _) {
                  return Column(
                    children: [
                      Text(
                        'We’ve sent a verification email to your inbox.\n\n'
                        'Please verify your email to continue.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 30.h),

                      /// RESEND BUTTON
                      CustomLoadingButton(
                        text: auth.canResendEmail
                            ? 'Resend Verification Email'
                            : 'Resend in ${auth.resendCooldown}s',
                        isLoading: auth.loading,
                        onPressed: auth.canResendEmail
                            ? auth.resendVerificationEmail
                            : () {},
                      ),

                      SizedBox(height: 20.h),

                      /// MANUAL CHECK
                      TextButton(
                        onPressed: auth.emailChecking
                            ? null
                            // : auth.checkEmailVerification,
                            : () {
                                auth.checkEmailVerification;
                              },
                        child: Text(
                          auth.emailChecking
                              ? 'Checking...'
                              : 'Already verified? Refresh status',
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          SizedBox(height: 60.h),

          Consumer<AuthProvider>(
            builder: (context, auth, _) {
              return ConfirmActionButton(
                buttonText: 'Sign Out',
                icon: Icons.logout_rounded,
                dialogTitle: 'Sign Out',
                dialogMessage:
                    'Are you sure you want to log out of FAMZY Tourz?',
                isDanger: true,
                confirmColor: Colors.red,
                // isLoading: auth.loading,
                onConfirmed: () => auth.emailSignOut(),
              );
            },
          ),
        ],
      ),
    );
  }
}
