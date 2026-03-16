import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/user_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/app_drawer.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_background_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>().user;
    // debugPrint(
    //   '*** user data: name: ${user!.name}, email : ${user.email}, photo url: ${user.photoURL}, age ${user.age}',
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: AppConstants.appBarTextStyle),

        backgroundColor: AppConstants.primaryColor,
      ),
      drawer: const AppDrawer(),

      body: CustomBackgroundWrapper(
        imagePath: 'assets/images/bg-mainscreen.jpg',
        child: user == null
            ? const Center(child: Text('User not found'))
            : Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    CustomProfileAvatar(
                      imageUrl: user.photoUrl,
                      radius: 50,
                      fallbackIcon: Icons.person,
                    ),

                    SizedBox(height: 20.h),

                    _profileTile('Name', user.name),

                    _profileTile('Email', user.email),

                    _profileTile('Gender', user.gender),

                    _profileTile('Age', user.age.toString()),

                    _profileTile('ID / Passport', user.idPassport),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _profileTile(String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.w),

      decoration: BoxDecoration(
        color: AppConstants.primaryTransGColor,
        borderRadius: BorderRadius.circular(10.r),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70)),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
