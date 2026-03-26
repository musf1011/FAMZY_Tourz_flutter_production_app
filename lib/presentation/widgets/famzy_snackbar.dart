import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';

enum SnackBarStatus { success, error, warning, info }

class FamzySnackBar {
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    SnackBarStatus status = SnackBarStatus.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Determine Look based on Status
    final Color color;
    final IconData icon;

    switch (status) {
      case SnackBarStatus.success:
        color = Colors.greenAccent;
        icon = Icons.check_circle_outline;
        break;
      case SnackBarStatus.error:
        color = Colors.redAccent;
        icon = Icons.error_outline;
        break;
      case SnackBarStatus.warning:
        color = AppConstants.famzyGold;
        icon = Icons.warning_amber_rounded;
        break;
      case SnackBarStatus.info:
        color = AppConstants.googleBlue;
        icon = Icons.info_outline;
    }

    ScaffoldMessenger.of(
      context,
    ).clearSnackBars(); // Remove existing ones first

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        backgroundColor:
            Colors.transparent, // We use a Container for custom styling
        duration: duration,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        content: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppConstants.blackColorP5,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: AppConstants.whiteColorP5, width: 1),
            boxShadow: [
              BoxShadow(
                color: AppConstants.blackColorP3,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 28.r),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        color: AppConstants.whiteColorP9,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
