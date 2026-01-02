import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/back_logo_row.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_app_background.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EnterEmailForResetScreen extends StatefulWidget {
  const EnterEmailForResetScreen({super.key});

  @override
  State<EnterEmailForResetScreen> createState() =>
      _EnterEmailForResetScreenState();
}

class _EnterEmailForResetScreenState extends State<EnterEmailForResetScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  late AnimationController _animController;

  @override
  void dispose() {
    _emailController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const BackAndLogoRow(),
            // screen title
            Text(
              ' Forgot Password?',
              style: GoogleFonts.playfairDisplay(
                fontSize: 40.sp,
                fontWeight: .bold,
                color: AppConstants.primaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(.03.sw, 20.h, .03.sw, 40.h),
              child: Card(
                color: AppConstants.primaryTransGColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  side: BorderSide(color: Colors.white, width: .5.w),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 15.h),
                      Text(
                        'Enter your email to receive a password reset link.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 25.h),

                      /// Email Field
                      Form(
                        key: _formKey,
                        child: CustTextFormField(
                          controller: _emailController,
                          label: 'Email',
                          hint: 'you@example.com',
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) => val == null || val.isEmpty
                              ? 'Email required'
                              : null,
                        ),
                      ),

                      SizedBox(height: 30.h),
                    ],
                  ),
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
          ],
        ),
      ),
    );
  }
}
