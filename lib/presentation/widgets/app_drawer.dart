import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/user_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    return Drawer(
      backgroundColor: const Color.fromARGB(255, 0, 40, 0),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// TOP SECTION
            Column(
              children: [
                /// HEADER
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 60, 0),
                    border: Border(
                      bottom: BorderSide(
                        color: AppConstants.famzyGold,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomProfileAvatar(
                        // imageUrl: user?.photoUrl ?? '',
                        imageUrl: '',
                        radius: 35,
                      ),

                      SizedBox(height: 10.h),

                      Text(
                        user?.name ?? 'Guest',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 5.h),

                      Text(
                        user?.email ?? '',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                /// HOME BUTTON
                _drawerButton(
                  context,
                  icon: Icons.home_rounded,
                  title: "HOME",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                /// PROFILE BUTTON
                _drawerButton(
                  context,
                  icon: Icons.person,
                  title: "PROFILE",
                  onTap: () {},
                ),

                /// MY BOOKINGS
                _drawerButton(
                  context,
                  icon: Icons.confirmation_number,
                  title: "MY BOOKINGS",
                  onTap: () {},
                ),

                /// SETTINGS
                _drawerButton(
                  context,
                  icon: Icons.settings,
                  title: "SETTINGS",
                  onTap: () {},
                ),
              ],
            ),

            /// LOGOUT
            Padding(
              padding: EdgeInsets.only(bottom: 25.h),
              child: _drawerButton(
                context,
                icon: Icons.logout_rounded,
                title: "LOGOUT",
                iconColor: Colors.red,
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = AppConstants.primaryColor,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, right: 90.w, bottom: 15.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 22.sp),

              SizedBox(width: 12.w),

              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
