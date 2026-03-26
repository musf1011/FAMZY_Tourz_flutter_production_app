// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:famzy_tourz_v2/presentation/providers/auth_providers/user_provider.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/custom_profile_avatar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// class AppDrawer extends StatelessWidget {
//   const AppDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = context.watch<UserProvider>();
//     final user = userProvider.user;

//     return Drawer(
//       backgroundColor: AppConstants.secondaryColor,
//       child: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             /// TOP SECTION
//             Column(
//               children: [
//                 /// HEADER
//                 DrawerHeader(
//                   decoration: const BoxDecoration(
//                     color: AppConstants.primaryColor,
//                     border: Border(
//                       bottom: BorderSide(
//                         color: AppConstants.famzyGold,
//                         width: 1.5,
//                       ),
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const CustomProfileAvatar(
//                         // imageUrl: user?.photoUrl ?? '',
//                         imageUrl: '',
//                         radius: 35,
//                       ),

//                       SizedBox(height: 10.h),

//                       Text(
//                         user?.name ?? 'Guest',
//                         style: GoogleFonts.playfairDisplay(
//                           fontSize: 20.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),

//                       SizedBox(height: 5.h),

//                       Text(
//                         user?.email ?? '',
//                         style: TextStyle(
//                           fontSize: 12.sp,
//                           color: Colors.white70,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 SizedBox(height: 20.h),

//                 /// HOME BUTTON
//                 _drawerButton(
//                   context,
//                   icon: Icons.home_rounded,
//                   title: "HOME",
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                 ),

//                 /// PROFILE BUTTON
//                 _drawerButton(
//                   context,
//                   icon: Icons.person,
//                   title: "PROFILE",
//                   onTap: () {},
//                 ),

//                 /// MY BOOKINGS
//                 _drawerButton(
//                   context,
//                   icon: Icons.confirmation_number,
//                   title: "MY BOOKINGS",
//                   onTap: () {},
//                 ),

//                 /// SETTINGS
//                 _drawerButton(
//                   context,
//                   icon: Icons.settings,
//                   title: "SETTINGS",
//                   onTap: () {},
//                 ),
//               ],
//             ),

//             /// LOGOUT
//             Padding(
//               padding: EdgeInsets.only(bottom: 25.h),
//               child: _drawerButton(
//                 context,
//                 icon: Icons.logout_rounded,
//                 title: "LOGOUT",
//                 iconColor: Colors.red,
//                 onTap: () async {
//                   await FirebaseAuth.instance.signOut();
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _drawerButton(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//     Color iconColor = AppConstants.primaryColor,
//   }) {
//     return Padding(
//       padding: EdgeInsets.only(left: 12.w, right: 90.w, bottom: 15.h),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(10.r),
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
//           child: Row(
//             children: [
//               Icon(icon, color: iconColor, size: 22.sp),

//               SizedBox(width: 12.w),

//               Text(
//                 title,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16.sp,
//                   letterSpacing: 3,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:famzy_tourz_v2/presentation/widgets/sign_out_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/presentation/providers/main_provider.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = context.watch<UserProvider>().user;

    return Drawer(
      width: .75.sw,
      shadowColor: AppConstants.whiteColorP5,
      elevation: 100.r,
      backgroundColor: AppConstants.secondaryTransGColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// TOP SECTION
            Column(
              children: [
                /// HEADER
                SizedBox(
                  height: .2.sh,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      // shape: BoxShape.rectangle,
                      // backgroundBlendMode: BlendMode.color,
                      boxShadow: List.filled(
                        2,
                        BoxShadow(
                          // color: AppConstants.transGrey,
                          blurStyle: BlurStyle.outer,
                          // spreadRadius: .5.r,
                          blurRadius: 5.r,
                        ),
                      ),
                      color: AppConstants.secondaryColor,

                      border: Border(
                        bottom: BorderSide(
                          color: AppConstants.famzyGold,
                          width: .5.r,
                        ),
                      ),
                    ),

                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // CustomProfileAvatar(
                          //   imageUrl: user?.photoURL ?? '',
                          //   radius: 25,
                          //   fallbackIcon: Icons.person,
                          // ),

                          // // SizedBox(height: 10.h),
                          // Text(
                          //   user?.name == '' ? 'Guestesswew' : user!.name,
                          //   // 'gerwrq',
                          //   style: GoogleFonts.playfairDisplay(
                          //     fontSize: 20.sp,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.white,
                          //   ),
                          //   textAlign: .center,
                          // ),

                          // SizedBox(height: 4.h),

                          // Text(
                          //   user?.email == '' ? 'Not Logged In' : user!.email,
                          //   style: TextStyle(
                          //     color: AppConstants.whiteColorP7,
                          //     fontSize: 12.sp,
                          //   ),
                          // ),
                          Image.asset(
                            'assets/logos/FAMZYLogo.png',
                            width: .3.sw,
                            height: .1.sh,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'FAMZY Tourz',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                /// HOME
                _drawerButton(
                  icon: Icons.home_rounded,
                  iconColor: AppConstants.lightGreen,
                  title: 'HOME',
                  onTap: () {
                    context.read<MainProvider>().setTab(0);
                    context.read<MainProvider>().initController;
                    // NavigationService().navigateTo(AppRoutes.main);
                  },
                ),

                /// PROFILE
                _drawerButton(
                  icon: Icons.person,
                  iconColor: AppConstants.lightGreen,
                  title: 'PROFILE',
                  onTap: () {
                    NavigationService().pop();
                  },
                ),

                /// COMPANIES
                _drawerButton(
                  icon: Icons.business_rounded,
                  iconColor: AppConstants.lightGreen,
                  title: 'COMPANIES',
                  onTap: () {
                    NavigationService()
                        .pop(); // Optional: Close drawer before navigating
                    NavigationService().navigateTo(AppRoutes.companies);
                  },
                ),

                /// COMPANIES
                _drawerButton(
                  icon: Icons.business_rounded,
                  iconColor: AppConstants.lightGreen,
                  title: 'ADD COMPANY',
                  onTap: () {
                    NavigationService()
                        .pop(); // Optional: Close drawer before navigating
                    NavigationService().navigateTo(AppRoutes.addCompany);
                  },
                ),

                /// MY BOOKINGS
                _drawerButton(
                  icon: Icons.confirmation_number,
                  iconColor: AppConstants.lightGreen,
                  title: 'MY BOOKINGS',
                  onTap: () {
                    NavigationService().navigateTo(AppRoutes.myBookings);
                  },
                ),

                /// SETTINGS
                _drawerButton(
                  icon: Icons.settings,
                  iconColor: AppConstants.lightGreen,
                  title: 'SETTINGS',
                  onTap: () {
                    // NavigationService().navigateTo(AppRoutes.settings);
                  },
                ),
              ],
            ),

            /// LOGOUT
            Padding(
              // padding: EdgeInsets.only(left: 10.w, right: 90.w, bottom: 25.h),
              padding: EdgeInsetsGeometry.only(bottom: 25.h, right: 10.w),
              // child: _drawerButton(
              //   icon: Icons.logout_rounded,
              //   title: 'LOGOUT',
              //   iconColor: AppConstants.lightRed,
              //   onTap: () async {
              //     await context.read<AuthProvider>().emailSignOut();
              //     // await FirebaseAuth.instance.signOut();
              //   },
              // ),
              child: SignOutButton(height: 40.h, width: .5.sw),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = AppConstants.primaryColor,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, top: 15.h, right: 75.w),
      // padding: EdgeInsetsGeometry.all(0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppConstants.primaryColor,
          ),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 22.sp),

              SizedBox(width: 10.w),

              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
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
