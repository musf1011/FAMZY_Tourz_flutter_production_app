//created by: FAMZY CodeWorks
import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/back_logo_row.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_app_background.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String oob;
  const ResetPasswordScreen({super.key, required this.oob});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _hidePassword = true;
  bool showSuccessAnimation = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Stack(
      children: [
        AppBackground(
          child: Column(
            children: [
              const BackAndLogoRow(),

              Text('Reset Password', style: AppConstants.screenTitleTextStyle),

              Padding(
                padding: EdgeInsets.fromLTRB(.03.sw, .05.sh, .03.sw, .07.sh),
                child: Container(
                  decoration: AppConstants.glassCardDecoration,
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: .05.sw,
                        vertical: .01.sh,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),

                          CustTextFormField(
                            controller: _password,
                            label: 'New Password',
                            hint: 'Enter new password',
                            obscureText: true,
                            isPasswordHidden: _hidePassword,
                            toggleVisibility: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                            validator: (v) => v == null || v.length < 6
                                ? 'Minimum 6 characters'
                                : null,
                          ),

                          SizedBox(height: 12.h),

                          CustTextFormField(
                            controller: _confirmPassword,
                            label: 'Confirm Password',
                            hint: 'Re-enter password',
                            obscureText: true,
                            isPasswordHidden: _hidePassword,
                            toggleVisibility: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Confirm password';
                              }
                              if (v != _password.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              CustomLoadingButton(
                text: 'UPDATE PASSWORD',
                isLoading: auth.loading,
                onPressed: () {
                  FocusScope.of(context).unfocus();

                  if (_formKey.currentState!.validate()) {
                    auth.confirmResetPassword(
                      oobCode: widget.oob,
                      newPassword: _password.text.trim(),
                    );
                  }
                },
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
        // // ✅ SUCCESS OVERLAY
        // if (showSuccessAnimation)
        //   Container(
        //     height: 1.sh,
        //     width: 1.sw,
        //     color: AppConstants.blackColorP7,
        //     child: Center(
        //       child: Lottie.asset(
        //         'assets/animations/success.json',
        //         width: 150.w,
        //         height: 150.h,
        //         repeat: false,
        //         onLoaded: (composition) {
        //           Future.delayed(composition.duration, () {
        //             if (mounted) {
        //               setState(() => showSuccessAnimation = false);
        //               NavigationService().navigateAndClearStack(
        //                 AppRoutes.login,
        //               );
        //             }
        //           });
        //         },
        //       ),
        //     ),
        //   ),
        // ✅ SUCCESS OVERLAY (Controlled by Provider)
        if (auth.showResetSuccessAnimation)
          Container(
            height: 1.sh,
            width: 1.sw,
            color: AppConstants.blackColorP7,
            child: Center(
              child: Lottie.asset(
                'assets/animations/success.json',
                width: 150.w,
                height: 150.h,
                repeat: false,
                onLoaded: (composition) {
                  // Wait for the animation duration, then tell Provider we are done
                  Future.delayed(composition.duration, () {
                    auth.onResetAnimationComplete();
                  });
                },
              ),
            ),
          ),
      ],
    );
  }
}
