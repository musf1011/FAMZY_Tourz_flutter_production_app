import 'package:famzy_tourz_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 🔹 INFO CHIP
Widget infoChip(IconData icon, String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
    decoration: BoxDecoration(
      color: AppConstants.transWhite,
      borderRadius: BorderRadius.circular(25),
      border: Border.all(width: .5.r, color: AppConstants.whiteColorP5),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppConstants.whiteColorP9),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: Colors.white70, fontSize: 13)),
      ],
    ),
  );
}
