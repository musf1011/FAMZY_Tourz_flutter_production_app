// created by: FAMZY CodeWorks

import 'package:famzy_tourz_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final Color confirmColor;
  final IconData? icon;
  final bool isDanger;

  const AppConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.confirmColor = AppConstants.lightRed,
    this.icon,
    this.isDanger = false,
  });

  ///  Helper method (recommended way to use)
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color confirmColor = AppConstants.lightRed,
    IconData? icon,
    bool isDanger = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true, //user cancel buy clicking outside
      builder: (_) => AppConfirmDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        confirmColor: confirmColor,
        icon: icon,
        isDanger: isDanger,
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppConstants.secondaryTransGColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
        side: BorderSide(
          color: AppConstants.whiteColorP9,
          width: 1.r,
        ), //white p3 needed
      ),
      titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 30.h),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      actionsPadding: EdgeInsets.fromLTRB(15.w, 20.h, 15.w, 15.h),

      //title
      title: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: isDanger ? AppConstants.lightRed : AppConstants.famzyGold,
              size: 28.sp,
            ),
            SizedBox(width: 10.w),
          ],
          // Column(
          //   children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
      //   ],
      // ),
      content: SingleChildScrollView(
        child: Text(
          message,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: AppConstants.whiteColorP9,
            // fontWeight: .w500,
            letterSpacing: 0.4,
          ),
        ),
      ),

      /// ACTIONS
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.lightGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.r),
            ),
          ),
          onPressed: () => Navigator.pop(context, false),
          child: Text(
            cancelText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: confirmColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.r),
            ),
          ),
          onPressed: () => Navigator.pop(context, true),
          child: Text(
            confirmText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
