import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_app_background.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            // famzy logo
            Image.asset(
              'assets/logos/FAMZYLogo.png',
              width: 300.w,
              height: 200.w,
            ),

            SizedBox(height: 40.h),

            // famzy title
            Text(
              'FAMZY Tourz',
              style: GoogleFonts.playfairDisplay(
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
                color: AppConstants.primaryColor,
              ),
            ),

            SizedBox(height: 70.h),

            // sign in button
            CustomLoadingButton(
              text: 'Sign In ',
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.login);
              },
            ),
            SizedBox(height: 40.h),
            CustomLoadingButton(
              text: 'Sign Up',
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.signup);
              },
            ),

            SizedBox(height: 60.h),

            //google
            Text(
              'Or continue with',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppConstants.whiteColorP9,
              ),
            ),

            SizedBox(height: 20.h),
            // google button
            Consumer<AuthProvider>(
              builder: (context, auth, child) {
                return InkWell(
                  // 1. Manually handle the disabled state for InkWell
                  onTap: auth.loading ? null : () => auth.signInWithGoogle(),
                  borderRadius: BorderRadius.circular(12),
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
            const Text(
              'G O O G L E',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            // InkWell(
            //   onTap: () =>
            //       GoogleAuthService.instance.signInWithGoogle(context),
            //   child: Image.asset(
            //     'assets/logos/google_logo.png',
            //     height: 60.h,
            //   ),
            // ),
            // SizedBox(height: 10),
            // Text(
            //   ' G O O G L E',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
