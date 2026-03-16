// // created by: FAMZY CodeWorks

// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/dialogs/custom_alert_dialogs.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class SignOutButton extends StatelessWidget {
//   final String buttonText;
//   final IconData icon;

//   final String dialogTitle;
//   final String dialogMessage;

//   // final bool isDanger;
//   final Color iconColor;
//   final Color confirmColor;
//   final bool isLoading;

//   final Future<void> Function() onConfirmed;

//   const SignOutButton({
//     super.key,
//     required this.buttonText,
//     required this.icon,
//     required this.dialogTitle,
//     required this.dialogMessage,
//     required this.onConfirmed,
//     // this.isDanger = true, //default it was false
//     this.iconColor = AppConstants.lightRed,
//     this.confirmColor = AppConstants.lightRed,
//     this.isLoading = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomLoadingButton(
//       isLoading: isLoading,
//       onPressed: isLoading
//           ? () {}
//           : () async {
//               final confirmed = await AppConfirmDialog.show(
//                 context,
//                 title: dialogTitle,
//                 message: dialogMessage,
//                 confirmText: buttonText,
//                 confirmColor: confirmColor,
//                 icon: icon,
//                 iconColor: iconColor,
//               );

//               if (confirmed) {
//                 await onConfirmed();
//               }
//             },
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(buttonText, style: AppConstants.elevatedButtonTextStyle),
//           SizedBox(width: 10.w),
//           Icon(icon, color: Colors.white, size: 28.r),
//         ],
//       ),
//     );
//   }
// }

// created by: FAMZY CodeWorks

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/auth_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/dialogs/custom_alert_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignOutButton extends StatelessWidget {
  final double height;
  final double width;
  // final String buttonText;
  // final IconData icon;

  // final String dialogTitle;
  // final String dialogMessage;

  // // final bool isDanger;
  // final Color iconColor;
  // final Color confirmColor;
  // final bool isLoading;

  // final Future<void> Function() onConfirmed;

  const SignOutButton({
    super.key,
    required this.height,
    required this.width,
    // required this.buttonText,
    // required this.icon,
    // required this.dialogTitle,
    // required this.dialogMessage,
    // required this.onConfirmed,
    // // this.isDanger = true, //default it was false
    // this.iconColor = AppConstants.lightRed,
    // this.confirmColor = AppConstants.lightRed,
    // this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    return CustomLoadingButton(
      height: height,
      width: width,
      isLoading: authProvider.loading,
      onPressed: authProvider.loading
          ? () {}
          : () async {
              final confirmed = await AppConfirmDialog.show(
                context,
                title: 'Sign Out',
                message: 'Are you sure you want to log out of FAMZY Tourz?',
                confirmText: 'Sign Out',
                icon: Icons.logout_rounded,
                iconColor: AppConstants.lightRed,
              );

              if (confirmed) {
                await authProvider.emailSignOut();
              }
            },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sign Out', style: AppConstants.elevatedButtonTextStyle),
          SizedBox(width: 10.w),
          Icon(Icons.logout_rounded, color: AppConstants.lightRed, size: 28.r),
        ],
      ),
    );
  }
}
