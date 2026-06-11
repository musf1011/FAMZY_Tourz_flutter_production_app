import 'package:flutter/material.dart';
import 'package:famzy_tourz_v2/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackgroundWrapper extends StatelessWidget {
  final String imagePath;
  final Widget child;

  const CustomBackgroundWrapper({
    super.key,
    required this.imagePath,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppConstants.primaryTransGColor,
              AppConstants.blackColorP5,
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
