// created by FAMZY CodeWorks

import 'package:famzy_tourz_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoadingButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final double? width;
  final double? height;

  const CustomLoadingButton({
    super.key,
    this.text,
    this.child,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.width,
    this.height,
  }) : assert(
         child != null || text != null,
         'Must provide either child or text',
       );

  @override
  Widget build(BuildContext context) {
    final buttonChild =
        child ?? Text(text!, style: AppConstants.elevatedButtonTextStyle);
    return SizedBox(
      width: width ?? .8.sw,
      height: height ?? 60.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppConstants.primaryTransGColor,

          minimumSize: Size(0.75.sw, .07.sh),
          textStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
          side: BorderSide(color: Colors.white, width: .5.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: SpinKitSpinningLines(color: Colors.white, lineWidth: 2),
              )
            : buttonChild,
      ),
    );
  }
}
