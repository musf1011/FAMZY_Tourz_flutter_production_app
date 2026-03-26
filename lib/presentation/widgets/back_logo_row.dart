// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:famzy_tourz_v2/presentation/widgets/dialogs/custom_app_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/auth_provider.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';

class BackAndLogoRow extends StatelessWidget {
  final bool navigateToWelcomeScreen;
  // Function? onBackTap;
  const BackAndLogoRow({
    super.key,
    this.navigateToWelcomeScreen = true,
    // this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .directional(top: 30.h),

      child: Row(
        crossAxisAlignment: .start,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_circle_left_outlined,
              size: 40.h,
              color: AppConstants.primaryColor,
            ),
            onPressed: () async {
              if (navigateToWelcomeScreen) {
                //tell the provider to stop loading and invalidate the current session
                final authProvider = context.read<AuthProvider>();
                authProvider.cancelAuthentication();
                authProvider.reset();
                await NavigationService().navigateAndClearStack(
                  AppRoutes.welcome,
                );
              } else {
                final bool confirmed = await AppConfirmDialog.show(
                  context,
                  title: 'Discard Changes?',
                  message:
                      'Are you sure you want to leave? Your package details will not be saved.',
                  cancelText: 'Stay',
                  confirmText: 'Discard',
                );
                if (confirmed) {
                  NavigationService().pop();
                  debugPrint(
                    '*******navigate to welcome screen is false in back logo screen',
                  );
                }
                // return;
              }
            },
          ),

          Image.asset(
            AppConstants.famzyLogoimage,
            width: .77.sw,
            height: .2.sh,
          ),
        ],
      ),
    );
  }
}
