import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:famzy_tourz_v2/constants.dart';

class CustomGlassWrapper extends StatelessWidget {
  final Widget child;
  final double? topPadding;
  final double? bottomPadding;
  final double? topMargin;
  final double? bottomMargin;
  final double? height;

  const CustomGlassWrapper({
    super.key,
    required this.child,
    this.topPadding,
    this.bottomPadding,
    this.topMargin,
    this.bottomMargin,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: AppConstants.primaryTransGColor,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppConstants.whiteColorP5, width: 0.5.w),
      ),

      margin: EdgeInsets.fromLTRB(
        10.w,
        topMargin ?? 10.h,
        10.w,
        bottomMargin ?? 10.h,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          0.05.sw,
          topPadding ?? 0.00.sh,
          0.05.sw,
          bottomPadding ?? 0.0.sh,
        ),
        child: child,
      ),
    );
  }
}
