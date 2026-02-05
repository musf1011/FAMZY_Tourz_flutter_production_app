import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/user_provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // We watch the user provider for real-time updates
    final user = context.watch<UserProvider>().user;

    // Safety check: If user is null, don't render anything
    if (user == null) return const SizedBox.shrink();
    debugPrint('**** user: $user');

    return Column(
      children: [
        // --- Profile Photo ---
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppConstants.underline, width: 2.r),
          ),
          child: CircleAvatar(
            radius: 40.r,
            backgroundColor: AppConstants.secondaryColor,
            backgroundImage: user.photoUrl.isNotEmpty
                ? NetworkImage(user.photoUrl)
                : null,
            child: user.photoUrl.isEmpty
                ? Icon(Icons.business, color: Colors.white, size: 40.r)
                : null,
          ),
        ),

        SizedBox(height: 8.h),

        // --- Company Name ---
        Text(
          user.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),

        // Bottom padding to separate from the form fields
        SizedBox(height: 16.h),
      ],
    );
  }
}
