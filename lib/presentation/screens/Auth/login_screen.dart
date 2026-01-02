// // import 'package:famzy_tourz_v2/constants.dart';
// // import 'package:famzy_tourz_v2/data/services/google_auth_service.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:google_fonts/google_fonts.dart';

// // class LoginScreen extends StatelessWidget {
// //   const LoginScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppConstants.authBgColor,
// //       body: Padding(
// //         padding: EdgeInsets.all(20.w),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: [
// //             Text(
// //               "Welcome Back!",
// //               style: GoogleFonts.poppins(
// //                 fontSize: 28.sp,
// //                 fontWeight: FontWeight.bold,
// //                 color: AppConstants.primaryColor,
// //               ),
// //             ),

// //             SizedBox(height: 10.h),

// //             Text(
// //               "Sign in to continue",
// //               style: GoogleFonts.poppins(
// //                 fontSize: 16.sp,
// //                 color: Colors.black54,
// //               ),
// //             ),

// //             SizedBox(height: 40.h),

// //             // ---------------- GOOGLE SIGN IN BUTTON ----------------
// //             ElevatedButton(
// //               style: AppConstants.googleButtonStyle,
// //               onPressed: () {
// //                 GoogleAuthService.instance.signInWithGoogle(context);
// //               },
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Image.asset("assets/logos/google_logo.png", height: 22.h),
// //                   SizedBox(width: 10.w),
// //                   Text(
// //                     "Continue with Google",
// //                     style: GoogleFonts.poppins(fontSize: 16.sp),
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             SizedBox(height: 20.h),

// //             // ---------------- EMAIL LOGIN BUTTON ----------------
// //             ElevatedButton(
// //               style: AppConstants.primaryButtonStyle,
// //               onPressed: () {
// //                 // Navigate to Email Login Screen (next step)
// //               },
// //               child: Text(
// //                 "Sign in with Email",
// //                 style: GoogleFonts.poppins(fontSize: 16.sp),
// //               ),
// //             ),

// //             SizedBox(height: 25.h),

// //             TextButton(
// //               onPressed: () {},
// //               child: Text(
// //                 "Create an account",
// //                 style: GoogleFonts.poppins(
// //                   fontSize: 14.sp,
// //                   color: AppConstants.primaryColor,
// //                   fontWeight: FontWeight.w500,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/custom_elevated_button.dart';
// import 'package:famzy_tourz_v2/routes/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import '../../providers/auth_provider.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _email = TextEditingController();
//   final TextEditingController _password = TextEditingController();
//   bool _hidePassword = true;

//   @override
//   Widget build(BuildContext context) {
//     final auth = context.watch<AuthProvider>();

//     return Scaffold(
//       body: Container(
//         height: 1.sh,
//         width: 1.sw,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/bg_app.jpg'),
//             fit: BoxFit.fill,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               /// 🔙 Back + Logo
//               Padding(
//                 padding: EdgeInsets.only(top: 15.h),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(
//                         Icons.arrow_circle_left_outlined,
//                         size: 40.h,
//                         color: AppConstants.primaryColor,
//                       ),
//                       onPressed: () => Navigator.pushReplacementNamed(
//                         context,
//                         AppRoutes.welcome,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(top: 8.h),
//                       child: Image.asset(
//                         "assets/logos/FAMZYLogo.png",
//                         width: .8.sw,
//                         height: .2.sh,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               /// TITLE
//               Text(
//                 "Sign In",
//                 style: GoogleFonts.playfairDisplay(
//                   fontSize: 40.sp,
//                   fontWeight: FontWeight.bold,
//                   color: AppConstants.primaryColor,
//                 ),
//               ),

//               /// FORM CONTAINER
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: .03.sw),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15.r),
//                     color: AppConstants.transGColor,
//                   ),
//                   child: Form(
//                     key: _formKey,
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: .03.sw),
//                       child: Column(
//                         children: [
//                           SizedBox(height: 15.h),

//                           _buildTextField(
//                             label: 'Gmail',
//                             hint: 'you@gmail.com',
//                             controller: _email,
//                             validator: (v) => v == null || v.isEmpty
//                                 ? 'Gmail required'
//                                 : null,
//                           ),

//                           SizedBox(height: .05.sh),

//                           _buildPasswordField(),

//                           SizedBox(height: 12.h),

//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: GestureDetector(
//                               // onTap: () {
//                               //   Navigator.pushNamed(
//                               //       context, AppRoutes.resetPassword);
//                               // },
//                               child: Text(
//                                 'Forgot password?',
//                                 style: TextStyle(
//                                   color: AppConstants.whiteColorP9,
//                                   fontSize: 12.sp,
//                                 ),
//                               ),
//                             ),
//                           ),

//                           SizedBox(height: 15.h),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               SizedBox(height: .04.sh),

//               /// SIGN IN BUTTON
//               SizedBox(
//                 width: .85.sw,
//                 height: 55.h,
//                 child: CustomElevatedButton(

//   onPressed: auth.loading
//       ? null
//       : () async {
//           // Unfocus keyboard first
//           FocusScope.of(context).unfocus();

//           if (_formKey.currentState!.validate()) {
//             try {
//               await auth.signInWithEmail(_email.text.trim(), _password.text);
//             } catch (e) {
//               // Error is already handled in AuthProvider
//             }
//           }
//         },
//          child: auth.loading
//       ? const SizedBox(
//           height: 24,
//           width: 24,
//           child: CircularProgressIndicator(
//             color: Colors.white,
//             strokeWidth: 2,
//           ),
//         )
//       : Text(
//           "SIGN IN",
//           style: AppConstants.elevatedButtonTextStyle,
//         ),
// ),
//                 // child: CustomElevatedButton( onPressed: auth.loading
//                 //       ? null
//                 //       : () {
//                 //           if (_formKey.currentState!.validate()) {
//                 //             auth.signInWithEmail(_email.text, _password.text);
//                 //           }
//                 //         },
//                 //         child:  auth.loading
//                 //       ? const CircularProgressIndicator(color: Colors.white)
//                 //       : Text(
//                 //           "SIGN IN",
//                 //           style: AppConstants.elevatedButtonTextStyle,
//                 //         ),
//                 //         ),
//                 // child: ElevatedButton(
//                 //   style: AppConstants.primaryButtonStyle,
//                 //   onPressed:
//                 //   child:
//                 // ),
//               ),

//               SizedBox(height: .07.sh),

//               Text(
//                 "Or continue with",
//                 style: TextStyle(
//                   color: AppConstants.whiteColorP9,
//                   fontSize: 12.sp,
//                 ),
//               ),
//               SizedBox(height: 12.h),

//               /// GOOGLE BUTTON
//               IconButton(
//                 icon: Image.asset('assets/logos/google_logo.png', height: 40.h),
//                 onPressed: auth.loading
//                     ? null
//                     : () => auth.signInWithGoogle(context),
//               ),

//               SizedBox(height: 10.h),

//               /// SIGN UP LINK
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Don’t have an account?",
//                     style: TextStyle(
//                       color: AppConstants.whiteColorP9,
//                       fontSize: 12.sp,
//                     ),
//                   ),
//                   const SizedBox(width: 5),
//                   GestureDetector(
//                     // onTap: () => Navigator.pushReplacementNamed(
//                     //   context,
//                     //   AppRoutes.signUp,
//                     // ),
//                     child: const Text(
//                       "Sign Up",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(height: 30.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Gmail field
//   Widget _buildTextField({
//     required String label,
//     required String hint,
//     required TextEditingController controller,
//     required String? Function(String?) validator,
//   }) {
//     return TextFormField(
//       controller: controller,
//       style: const TextStyle(color: Colors.white),
//       validator: validator,
//       keyboardType: TextInputType.emailAddress,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: AppConstants.whiteColorP9),
//         hintText: hint,
//         hintStyle: TextStyle(color: AppConstants.whiteColorP5),
//       ),
//     );
//   }

//   /// Password field
//   Widget _buildPasswordField() {
//     return TextFormField(
//       controller: _password,
//       style: const TextStyle(color: Colors.white),
//       obscureText: _hidePassword,
//       decoration: InputDecoration(
//         labelText: "Password",
//         labelStyle: TextStyle(color: AppConstants.whiteColorP9),
//         hintText: 'password',
//         hintStyle: TextStyle(color: AppConstants.whiteColorP5),
//         suffixIcon: IconButton(
//           icon: Icon(
//             _hidePassword ? Icons.visibility_off : Icons.visibility,
//             color: AppConstants.whiteColorP9,
//           ),
//           onPressed: () {
//             setState(() {
//               _hidePassword = !_hidePassword;
//             });
//           },
//         ),
//       ),
//       validator: (v) {
//         if (v == null || v.isEmpty) return 'Password required';
//         return null;
//       },
//     );
//   }
// }

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/widgets/back_logo_row.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_app_background.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_text_form_field.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _hidePassword = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // back and logo row
            const BackAndLogoRow(),

            // screen title
            Text(
              '  Sign In',
              style: GoogleFonts.playfairDisplay(
                fontSize: 40.sp,
                fontWeight: .bold,
                color: AppConstants.primaryColor,
              ),
            ),

            // cotainer form
            Padding(
              padding: .fromLTRB(.03.sw, .03.sh, .03.sw, .05.sh),
              child: Container(
                decoration: BoxDecoration(
                  border: .all(color: Colors.white, width: .5.w),
                  borderRadius: .circular(15.r),
                  color: AppConstants.primaryTransGColor,
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: .fromLTRB(.05.sw, .03.sh, .05.sw, .03.sh),
                    child: Column(
                      children: [
                        // SizedBox(height: 15.h),

                        // // email field
                        // TextFormField(
                        //   controller: _email,
                        //   style: const TextStyle(color: Colors.white),
                        //   keyboardType: TextInputType.emailAddress,
                        //   decoration: InputDecoration(
                        //     labelText: 'Email',
                        //     labelStyle: TextStyle(
                        //       color: AppConstants.whiteColorP9,
                        //     ),
                        //     hintText: 'you@gmail.com',
                        //     hintStyle: TextStyle(
                        //       color: AppConstants.whiteColorP5,
                        //     ),
                        //     prefixIcon: Icon(
                        //       Icons.email,
                        //       color: AppConstants.whiteColorP9,
                        //     ),
                        //   ),
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Email is required';
                        //     }
                        //     if (!RegExp(
                        //       r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        //     ).hasMatch(value)) {
                        //       return 'Enter a valid email';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // SizedBox(height: .05.sh),
                        CustTextFormField(
                          label: 'Email',
                          hint: 'you@gmail.com',
                          controller: _email,
                          // keyboardType: TextInputType.emailAddress,
                          // keyboardType: .emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        CustTextFormField(
                          label: 'Password',
                          hint: 'Enter your password',
                          controller: _password,
                          obscureText: true,
                          isPasswordHidden: _hidePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          toggleVisibility: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                        ),

                        // password field
                        // TextFormField(
                        //   controller: _password,
                        //   style: const TextStyle(color: Colors.white),
                        //   obscureText: _hidePassword,
                        //   decoration: InputDecoration(
                        //     labelText: "Password",
                        //     labelStyle: TextStyle(
                        //       color: AppConstants.whiteColorP9,
                        //     ),
                        //     hintText: 'Enter your password',
                        //     hintStyle: TextStyle(
                        //       color: AppConstants.whiteColorP5,
                        //     ),
                        //     prefixIcon: Icon(
                        //       Icons.lock,
                        //       color: AppConstants.whiteColorP9,
                        //     ),
                        //     suffixIcon: IconButton(
                        //       icon: Icon(
                        //         _hidePassword
                        //             ? Icons.visibility_off
                        //             : Icons.visibility,
                        //         color: AppConstants.whiteColorP9,
                        //       ),
                        //       onPressed: () {
                        //         setState(() {
                        //           _hidePassword = !_hidePassword;
                        //         });
                        //       },
                        //     ),
                        //   ),
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Password is required';
                        //     }
                        //     if (value.length < 6) {
                        //       return 'Password must be at least 6 characters';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        SizedBox(height: 12.h),

                        Align(
                          alignment: .centerRight,
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.enterEmail,
                            ),
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: AppConstants.whiteColorP9,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 15.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Consumer<AuthProvider>(
              builder: (context, auth, child) {
                return CustomLoadingButton(
                  text: 'SIGN IN',
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      auth.signInWithEmail(
                        _email.text.trim(),
                        _password.text.trim(),
                      );
                    }
                  },
                  isLoading: auth.loading,
                );
              },
            ),

            SizedBox(height: .06.sh),

            Text(
              'Or continue with',
              style: TextStyle(
                color: AppConstants.whiteColorP9,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 12.h),

            // // google button
            Consumer<AuthProvider>(
              builder: (context, auth, child) {
                return InkWell(
                  // 1. Manually handle the disabled state for InkWell
                  onTap: auth.loading ? null : () => auth.signInWithGoogle(),
                  borderRadius: .circular(12),
                  child: Opacity(
                    // 2. Visually show it's disabled
                    opacity: auth.loading ? 0.5 : 1.0,
                    child: Image.asset(
                      'assets/logos/google_logo.png',
                      height: 50.h,
                      width: 50.h,
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 10.h),

            const Text(
              'G O O G L E',
              style: TextStyle(color: Colors.white, fontWeight: .bold),
            ),

            SizedBox(height: 20.h),

            // sign up row
            Row(
              mainAxisAlignment: .center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: AppConstants.whiteColorP9,
                    fontSize: 14.sp,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, AppRoutes.signup),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontWeight: .bold),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}




// /// SIGN IN BUTTON
              // Consumer<AuthProvider>(
              //   builder: (context, auth, child) {
              //     return SizedBox(
              //       width: .85.sw,
              //       height: 55.h,
              //       child: CustomElevatedButton(
              //         onPressed: auth.loading
              //             ? null
              //             : () {
              //                 // Unfocus keyboard first
              //                 FocusScope.of(context).unfocus();

              //                 if (_formKey.currentState!.validate()) {
              //                   // No async needed here - AuthProvider handles it
              //                   auth.signInWithEmail(
              //                     _email.text.trim(),
              //                     _password.text.trim(),
              //                   );
              //                 }
              //               },
              //         child: auth.loading
              //             ? SizedBox(
              //                 height: 24,
              //                 width: 24,
              //                 child: CircularProgressIndicator(
              //                   color: Colors.white,
              //                   strokeWidth: 2,
              //                 ),
              //               )
              //             : Text(
              //                 "SIGN IN",
              //                 style: AppConstants.elevatedButtonTextStyle,
              //               ),
              //       ),
              //     );
              //   },
              // ),