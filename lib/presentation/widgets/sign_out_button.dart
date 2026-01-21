// created by: FAMZY CodeWorks

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/dialogs/custom_alert_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class SignOutButton extends StatelessWidget {
//   final String title;
//   final String message;
//   final String buttonText;
//   final Color confirmColor;

//   const SignOutButton({
//     super.key,
//     this.title = 'Sign Out',
//     this.message = 'Are you sure you want to log out of FAMZY Tourz?',
//     this.buttonText = 'Sign Out',
//     this.confirmColor = Colors.red,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AuthProvider>(
//       builder: (context, auth, _) {
//         return CustomLoadingButton(
//           isLoading: auth.loading,
//           onPressed: auth.loading
//               ? () {}
//               : () async {
//                   final confirmed = await AppConfirmDialog.show(
//                     context,
//                     title: title,
//                     message: message,
//                     confirmText: buttonText,
//                     confirmColor: confirmColor,
//                     icon: Icons.logout_rounded,
//                     isDanger: true,
//                   );

//                   if (confirmed) {
//                     await auth.emailSignOut();
//                   }
//                 },
//           child: auth.loading
//               ? const SpinKitSpinningLines(
//                   color: Colors.white,
//                   size: 28,
//                 )
//               : Row(
//                   mainAxisAlignment:  .center,
//                   children: [
//                     Text(
//                       buttonText,
//                       style: AppConstants.elevatedButtonTextStyle,
//                     ),
//                     SizedBox(width: 10.w),
//                     Icon(
//                       Icons.logout_rounded,
//                       color: Colors.white,
//                       size: 22.sp,
//                     ),
//                   ],
//                 ),
//         );
//       },
//     );
//   }
// }
class ConfirmActionButton extends StatelessWidget {
  final String buttonText;
  final IconData icon;

  final String dialogTitle;
  final String dialogMessage;

  final bool isDanger;
  final Color confirmColor;
  final bool isLoading;

  final Future<void> Function() onConfirmed;

  const ConfirmActionButton({
    super.key,
    required this.buttonText,
    required this.icon,
    required this.dialogTitle,
    required this.dialogMessage,
    required this.onConfirmed,
    this.isDanger = true, //default it was false
    this.confirmColor = Colors.red,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomLoadingButton(
      isLoading: isLoading,
      onPressed:
          // isLoading
          //     ? () {}
          //     :
          () async {
            final confirmed = await AppConfirmDialog.show(
              context,
              title: dialogTitle,
              message: dialogMessage,
              confirmText: buttonText,
              confirmColor: confirmColor,
              icon: icon,
              isDanger: isDanger,
            );

            if (confirmed) {
              await onConfirmed();
            }
          },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(buttonText, style: AppConstants.elevatedButtonTextStyle),
          SizedBox(width: 10.w),
          Icon(icon, color: Colors.white, size: 28.r),
        ],
      ),
    );
  }
}
