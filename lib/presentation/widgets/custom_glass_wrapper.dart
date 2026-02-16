import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:famzy_tourz_v2/constants.dart';

class CustomGlassWrapper extends StatelessWidget {
  final Widget child;
  final double? verticalPadding;
  final double? margin;

  const CustomGlassWrapper({
    super.key,
    required this.child,
    this.verticalPadding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppConstants.primaryTransGColor,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppConstants.whiteColorP5, width: 0.5.w),
      ),
      padding: EdgeInsets.fromLTRB(
        0.05.sw,
        verticalPadding ?? 0.03.sh,
        0.05.sw,
        verticalPadding ?? 0.03.sh,
      ),
      margin: EdgeInsets.symmetric(vertical: margin ?? 0),
      child: child,
    );
  }
}
