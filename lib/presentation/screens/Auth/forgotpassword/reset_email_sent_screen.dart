// created by: FAMZY CodeWorks
import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetEmailSentScreen extends StatelessWidget {
  final String email;

  const ResetEmailSentScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // prevent back
      child: Scaffold(
        body: Container(
          height: 1.sh,
          width: 1.sw,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_app.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: AppConstants.primaryTransGColor,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppConstants.whiteColorP5),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Icon
                    Icon(
                      Icons.mark_email_read_rounded,
                      size: 80.r,
                      color: AppConstants.primaryColor,
                    ),

                    SizedBox(height: 20.h),

                    /// Title
                    Text(
                      'Check Your Email',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.primaryColor,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    /// Message
                    Text(
                      'We’ve sent a password reset link to:',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Colors.white70,
                      ),
                    ),

                    SizedBox(height: 6.h),

                    Text(
                      email,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    Text(
                      'Open the link in your email to reset your password.\n'
                      'You’ll be redirected back to FAMZY Tourz automatically.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        color: Colors.white60,
                      ),
                    ),

                    SizedBox(height: 30.h),

                    /// Back to Login
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.welcome,
                          (_) => false,
                        );
                      },
                      child: Text(
                        'Back to Login',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: AppConstants.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
