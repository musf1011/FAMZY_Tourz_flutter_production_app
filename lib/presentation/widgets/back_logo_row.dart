import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/auth_provider.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BackAndLogoRow extends StatelessWidget {
  const BackAndLogoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .directional(top: 30.h, bottom: 20.h),

      child: Row(
        crossAxisAlignment: .start,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_circle_left_outlined,
              size: 40.h,
              color: AppConstants.primaryColor,
            ),
            onPressed: () {
              //tell the provider to stop loading and invalidate the current session
              final authProvider = context.read<AuthProvider>();
              authProvider.cancelAuthentication();
              authProvider.reset();
              NavigationService().navigateAndClearStack(AppRoutes.welcome);
            },
          ),

          Image.asset(
            'assets/logos/FAMZYLogo.png',
            width: .77.sw,
            height: .2.sh,
          ),
        ],
      ),
    );
  }
}
