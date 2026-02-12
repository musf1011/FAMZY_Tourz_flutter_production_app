import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/add_package_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/user_provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // We watch the user provider for real-time updates
    final user = context.watch<UserProvider>().user;
    final packageProvider = context.watch<AddPackageProvider>();
    // Safety check: If user is null, don't render anything

    // if (user == null) return const Text('HERE WE GO');
    if (user == null) {
      return const Text(
        'Profile not fetched',
        style: TextStyle(color: Colors.red),
      );
    }
    // 2. Extract logic to variables for cleaner UI code
    final isEditMode = packageProvider.isEditMode;
    final companyName = isEditMode ? packageProvider.companyName : user.name;
    final companyPhotoURL = isEditMode
        ? packageProvider.companyPhotoURL
        : user.photoURL;
    return Column(
      children: [
        // --- Profile Photo ---
        // Container(
        //   decoration: BoxDecoration(
        //     shape: BoxShape.circle,
        //     border: Border.all(color: AppConstants.underline, width: 1.r),
        //   ),
        //   child: CircleAvatar(
        //     radius: 40.r,
        //     backgroundColor: AppConstants.secondaryColor,
        //     backgroundImage: user.photoURL.isNotEmpty
        //         ? NetworkImage(user.photoURL)
        //         : null,
        //     child: user.photoURL.isEmpty
        //         ? Icon(Icons.business, color: Colors.white, size: 40.r)
        //         : null,
        //   ),
        // ),
        CustomProfileAvatar(
          imageUrl: isEditMode ? companyPhotoURL : user.photoURL,
        ),

        SizedBox(height: 8.h),

        // --- Company Name ---
        Text(
          isEditMode ? companyName : user.name,
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
