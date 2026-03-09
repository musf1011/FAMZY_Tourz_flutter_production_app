import 'package:famzy_tourz_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showBookingClosedSnackBar(BuildContext context, {bool isFull = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppConstants.transGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(
          color: isFull ? AppConstants.famzyGold : AppConstants.lightRed,
          width: 1,
        ),
      ),
      content: Row(
        children: [
          Icon(
            isFull ? Icons.event_seat : Icons.timer_off_outlined,
            color: isFull ? AppConstants.famzyGold : AppConstants.lightRed,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isFull ? 'Sold Out!' : 'Trip Expired',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  isFull
                      ? 'No more seats available for this tour.'
                      : 'This tour has already departed.',
                  style: TextStyle(
                    color: AppConstants.whiteColorP7,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 1),
      margin: EdgeInsets.all(20.w),
    ),
  );
}
