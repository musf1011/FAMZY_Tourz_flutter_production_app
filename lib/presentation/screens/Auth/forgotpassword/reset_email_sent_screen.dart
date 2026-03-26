// created by: FAMZY CodeWorks
import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/presentation/widgets/back_logo_row.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_app_background.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetEmailSentScreen extends StatelessWidget {
  final String email;

  const ResetEmailSentScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return AppAuthBackground(
      child: Column(
        children: [
          const BackAndLogoRow(),

          /// Icon
          Icon(
            Icons.mark_email_read_rounded,
            size: 80.r,
            color: AppConstants.primaryColor,
          ),

          SizedBox(height: 10.h),

          /// Title
          Text(
            'Check Your Email',
            textAlign: TextAlign.center,
            style: AppConstants.screenTitleTextStyle,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(.03.sw, .03.sh, .03.sw, .02.sh),
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

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),

          // Suggestion: Change your middle text to this:
          Text(
            'Once you have reset your password in your browser,\n '
            'return here and tap the button below to sign in.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              color: AppConstants.transRColor,
            ),
          ),

          /// Back to Login
          TextButton(
            onPressed: () {
              NavigationService().navigateAndClearStack(AppRoutes.welcome);
            },
            child: Text(
              'Back to Login',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: AppConstants.tertiaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
