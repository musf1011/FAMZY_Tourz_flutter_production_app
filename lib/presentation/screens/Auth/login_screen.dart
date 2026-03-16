import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/auth_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/back_logo_row.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_app_background.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_glass_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_text_form_field.dart';
import 'package:famzy_tourz_v2/presentation/widgets/google_button_inkwell.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  LoginScreen({super.key});

  // final TextEditingController _email = TextEditingController();
  // final TextEditingController _password = TextEditingController();
  // bool _hidePassword = true;

  // @override
  // void dispose() {
  //   _email.dispose();
  //   _password.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    return AppBackground(
      child: Column(
        children: [
          // back and logo row
          const BackAndLogoRow(),

          // screen title
          Text('Sign In', style: AppConstants.screenTitleTextStyle),

          // cotainer form
          // Padding(
          //   padding: .fromLTRB(.05.sw, .02.sh, .05.sw, .04.sh),
          // Container(
          //   // decoration: BoxDecoration(
          //   //   border: .all(color: Colors.white, width: .5.w),
          //   //   borderRadius: .circular(15.r),
          //   //   color: AppConstants.primaryTransGColor,
          //   // ),
          //   decoration: AppConstants.glassCardDecoration,
          CustomGlassWrapper(
            topMargin: 20.h,
            bottomMargin: .05.sh,
            topPadding: 20.h,
            bottomPadding: 30.h,

            child: Form(
              key: _formKey,

              child: Column(
                children: [
                  CustTextFormField(
                    label: 'Email',
                    hint: 'you@gmail.com',
                    // controller: _email,
                    // keyboardType: TextInputType.emailAddress,
                    // keyboardType: .emailAddress,
                    onChanged: (v) {
                      authProvider.email = v;
                    },
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
                  Consumer<AuthProvider>(
                    builder: (context, auth, child) {
                      return CustTextFormField(
                        label: 'Password',
                        hint: 'Enter your password',
                        // controller: _password,
                        onChanged: (v) {
                          authProvider.password = v;
                          debugPrint(
                            '*****ligin screen : ${authProvider.password}',
                          );
                        },
                        obscureText: true,
                        isPasswordHidden: authProvider.isPasswordVisible,
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
                          // setState(() {
                          //   _hidePassword = !_hidePassword;
                          // });
                          authProvider.togglePasswordVisibility();
                        },
                      );
                    },
                  ),

                  SizedBox(height: 12.h),

                  Align(
                    alignment: .centerRight,
                    child: GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.enterEmail),
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: AppConstants.whiteColorP9,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ],
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
                      // _email.text.trim(),
                      // _password.text.trim(),
                    );
                  }
                },
                isLoading: auth.loading,
              );
            },
          ),

          SizedBox(height: .04.sh),

          Text(
            'Or continue with',
            style: TextStyle(color: AppConstants.whiteColorP9, fontSize: 12.sp),
          ),
          SizedBox(height: 15.h),

          // // google button
          Consumer<AuthProvider>(
            builder: (context, auth, child) {
              return GoogleButtonInkWell(auth: auth);
            },
          ),

          SizedBox(height: 10.h),

          const Text(
            'G O O G L E',
            style: TextStyle(color: Colors.white, fontWeight: .bold),
          ),

          SizedBox(height: 40.h),

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
                onTap: () {
                  authProvider.reset();
                  NavigationService().navigateTo(AppRoutes.signup);
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: .bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),

          // SizedBox(height: 10.h),
        ],
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