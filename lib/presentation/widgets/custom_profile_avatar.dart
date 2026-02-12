import 'package:famzy_tourz_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final double borderWidth;
  final IconData fallbackIcon;

  const CustomProfileAvatar({
    super.key,
    required this.imageUrl,
    this.radius = 40.0,
    this.borderWidth = 1.0,
    this.fallbackIcon = Icons.business,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppConstants.whiteColorP5,
          width: borderWidth.r,
        ),
      ),
      child: CircleAvatar(
        radius: radius.r,
        backgroundColor: AppConstants.secondaryColor,
        backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
        child: imageUrl.isEmpty
            ? Icon(
                fallbackIcon,
                color: Colors.white,
                size: radius.r, // Icon scales with avatar size
              )
            : null,
      ),
    );
  }
}
