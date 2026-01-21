import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/back_logo_row.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_app_background.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_text_form_field.dart';
import 'package:famzy_tourz_v2/presentation/widgets/google_button_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EnterEmailForResetScreen extends StatefulWidget {
  const EnterEmailForResetScreen({super.key});

  @override
  State<EnterEmailForResetScreen> createState() =>
      _EnterEmailForResetScreenState();
}

class _EnterEmailForResetScreenState extends State<EnterEmailForResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Column(
        children: [
          const BackAndLogoRow(),
          // screen title
          Text('Forgot Password?', style: AppConstants.screenTitleTextStyle),
          Padding(
            padding: EdgeInsets.fromLTRB(.03.sw, .04.sh, .03.sw, .06.sh),
            child: Container(
              decoration: AppConstants.glassCardDecoration,
              padding: EdgeInsets.fromLTRB(.05.sw, .03.sh, .05.sw, .03.sh),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 15.h),
                  Text(
                    'Enter your email to receive a password reset link.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                  ),
                  SizedBox(height: 30.h),

                  /// Email Field
                  Form(
                    key: _formKey,
                    child: CustTextFormField(
                      controller: _emailController,
                      label: 'Email',
                      hint: 'you@example.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Email required' : null,
                    ),
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
          //  Button
          Consumer<AuthProvider>(
            builder: (context, auth, _) {
              return CustomLoadingButton(
                isLoading: auth.loading,
                onPressed: auth.loading
                    ? () {}
                    : () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        auth.resetPassword(
                          email: _emailController.text,
                          context: context,
                        );
                      },
                // child: auth.loading
                //     ? const SpinKitSpinningLines(color: Colors.white)
                //     :   'Send Reset Email',
                text: 'Send Rest Email',
              );
            },
          ),
          SizedBox(height: .07.sh),

          Text(
            'Or continue with',
            style: TextStyle(color: AppConstants.whiteColorP9, fontSize: 12.sp),
          ),
          SizedBox(height: 12.h),

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

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
