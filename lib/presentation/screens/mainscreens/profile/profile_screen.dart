import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/user_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/app_drawer.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      drawer: const AppDrawer(),

      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppConstants.primaryColor,
      ),

      body: user == null
          ? const Center(child: Text('User not found'))
          : SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  CustomProfileAvatar(
                    // imageUrl: user.photoUrl,
                    imageUrl: '',
                    radius: 50,
                  ),

                  SizedBox(height: 15.h),

                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 5.h),

                  Text(
                    user.email,
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),

                  SizedBox(height: 30.h),

                  _infoTile('Age', user.age.toString()),

                  _infoTile('Gender', user.gender),

                  _infoTile('ID / Passport', user.idPassport),
                ],
              ),
            ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: AppConstants.primaryTransGColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, color: Colors.white70),
          ),

          Text(
            value,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
