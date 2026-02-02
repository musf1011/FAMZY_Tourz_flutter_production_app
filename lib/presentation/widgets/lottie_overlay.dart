import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:famzy_tourz_v2/constants.dart';

class LottieOverlay extends StatelessWidget {
  final String assetPath;
  final VoidCallback onAnimationComplete;
  final double? size;
  final Color? backgroundColor;

  const LottieOverlay({
    super.key,
    required this.assetPath,
    required this.onAnimationComplete,
    this.size,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Ensure it covers the whole screen
      height: 1.sh,
      width: 1.sw,
      // Default to your semi-transparent theme color
      color: backgroundColor ?? AppConstants.blackColorP7,
      child: Center(
        child: Lottie.asset(
          assetPath,
          width: size ?? 180.w,
          height: size ?? 180.h,
          repeat: false,
          onLoaded: (composition) {
            // Automatically triggers the callback when the json finishes
            Future.delayed(composition.duration, onAnimationComplete);
          },
        ),
      ),
    );
  }
}
