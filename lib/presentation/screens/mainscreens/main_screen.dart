// //created by: FAMZY CodeWorks
// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   final Color navigationBarColor = Colors.white;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   late PageController _pageController;
//   int _selectedIndex = 0;

//   bool _isInitialCheckComplete = false;
//   bool _isEmailVerified = false;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: _selectedIndex);
//     _initialize();
//   }

//   Future<void> _initialize() async {
//     final prefs = await SharedPreferences.getInstance();
//     _isEmailVerified = prefs.getBool('isEmailVerified') ?? false;

//     if (!_isEmailVerified) {
//       await _verifyEmailStatus();
//     } else {
//       setState(() => _isInitialCheckComplete = true);
//     }
//   }

//   Future<void> _verifyEmailStatus() async {
//     await _auth.currentUser?.reload();
//     final user = _auth.currentUser;

//     final isVerified = user?.emailVerified ?? false;

//     if (!isVerified && mounted) {
//       await user?.sendEmailVerification();

//       await Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (_) => const EmailVerificationPendingScreen(),
//         ),
//       );
//     } else if (mounted) {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('isEmailVerified', true);

//       setState(() {
//         _isEmailVerified = true;
//         _isInitialCheckComplete = true;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Initial loading
//     if (!_isInitialCheckComplete || !_isEmailVerified) {
//       return Scaffold(
//         body: Center(
//           child: SpinKitSpinningLines(color: Colors.white, size: 70.r),
//         ),
//       );
//     }

//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle(
//         systemNavigationBarColor: navigationBarColor,
//         systemNavigationBarIconBrightness: Brightness.dark,
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.grey,
//         body: PageView(
//           controller: _pageController,
//           physics: const NeverScrollableScrollPhysics(),
//           children: const [
//             // ⚠️ NOT MIGRATED YET – placeholders
//             Center(child: Text('Feed Screen')),
//             Center(child: Text('Tour Packages')),
//             Center(child: Text('Chat List')),
//             Center(child: Text('Profile')),
//           ],
//         ),
//         bottomNavigationBar: WaterDropNavBar(
//           backgroundColor: AppConstants.primaryColor,
//           waterDropColor: Colors.white,
//           bottomPadding: 8.h,
//           inactiveIconColor: AppConstants.whiteColorP5,
//           selectedIndex: _selectedIndex,
//           onItemSelected: (index) {
//             setState(() => _selectedIndex = index);
//             _pageController.animateToPage(
//               index,
//               duration: const Duration(milliseconds: 400),
//               curve: Curves.easeOutQuad,
//             );
//           },
//           barItems: [
//             BarItem(
//               filledIcon: Icons.festival,
//               outlinedIcon: Icons.festival_outlined,
//             ),
//             BarItem(
//               filledIcon: Icons.tour_rounded,
//               outlinedIcon: Icons.tour_outlined,
//             ),
//             BarItem(
//               filledIcon: Icons.email_rounded,
//               outlinedIcon: Icons.email_outlined,
//             ),
//             BarItem(
//               filledIcon: Icons.folder_rounded,
//               outlinedIcon: Icons.folder_outlined,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // created by: FAMZY CodeWorks
// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:famzy_tourz_v2/presentation/providers/main_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:provider/provider.dart';
// import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

// class MainScreen extends StatelessWidget {
//   const MainScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<MainProvider>(
//       builder: (context, main, _) {
//         if (!main.isReady) {
//           return const Scaffold(
//             body: Center(
//               child: SpinKitSpinningLines(color: Colors.white, size: 70),
//             ),
//           );
//         }

//         return AnnotatedRegion<SystemUiOverlayStyle>(
//           value: const SystemUiOverlayStyle(
//             systemNavigationBarColor: Colors.white,
//             systemNavigationBarIconBrightness: Brightness.dark,
//           ),
//           child: Scaffold(
//             backgroundColor: Colors.grey,
//             body: PageView(
//               controller: main.pageController,
//               physics: const NeverScrollableScrollPhysics(),
//               children: const [
//                 Center(child: Text('Feed Screen')),
//                 Center(child: Text('Tour Packages')),
//                 Center(child: Text('Chat List')),
//                 Center(child: Text('Profile')),
//               ],
//             ),
//             bottomNavigationBar: WaterDropNavBar(
//               backgroundColor: AppConstants.primaryColor,
//               waterDropColor: Colors.white,
//               bottomPadding: 8.h,
//               inactiveIconColor: AppConstants.whiteColorP5,
//               selectedIndex: main.selectedIndex,
//               onItemSelected: main.onTabSelected,
//               barItems: [
//                 BarItem(
//                   filledIcon: Icons.festival,
//                   outlinedIcon: Icons.festival_outlined,
//                 ),
//                 BarItem(
//                   filledIcon: Icons.tour_rounded,
//                   outlinedIcon: Icons.tour_outlined,
//                 ),
//                 BarItem(
//                   filledIcon: Icons.email_rounded,
//                   outlinedIcon: Icons.email_outlined,
//                 ),
//                 BarItem(
//                   filledIcon: Icons.folder_rounded,
//                   outlinedIcon: Icons.folder_outlined,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// created by: FAMZY CodeWorks
import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/main_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, main, _) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: Colors.grey,
            body: PageView(
              controller: main.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Center(
                  child: Consumer<AuthProvider>(
                    builder: (context, auth, child) {
                      return CustomLoadingButton(
                        onPressed: () {
                          print('******auth loading ${auth.loading}');
                          // auth.loading
                          //     ? null
                          //     :
                          // () {
                          print(
                            '*************************sign out button pressed',
                          );
                          auth.emailSignOut(context);
                          // };
                        },
                        isLoading: auth.loading,
                        child: auth.loading
                            ? const SpinKitSpinningLines(color: Colors.white)
                            : Row(
                                mainAxisAlignment: .spaceEvenly,
                                children: [
                                  Text(
                                    'Sign Out',
                                    style: AppConstants.elevatedButtonTextStyle,
                                  ),
                                  Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                    size: 30.r,
                                  ),
                                ],
                              ),
                      );
                    },
                  ),
                ),
                const Center(child: Text('Tour Packages')),
                const Center(child: Text('Chat List')),
                const Center(child: Text('Profile')),
              ],
            ),
            bottomNavigationBar: WaterDropNavBar(
              backgroundColor: AppConstants.primaryColor,
              waterDropColor: Colors.white,
              bottomPadding: 8.h,
              inactiveIconColor: AppConstants.whiteColorP5,
              selectedIndex: main.selectedIndex,
              onItemSelected: main.onTabSelected.call,
              barItems: [
                BarItem(
                  filledIcon: Icons.festival,
                  outlinedIcon: Icons.festival_outlined,
                ),
                BarItem(
                  filledIcon: Icons.tour_rounded,
                  outlinedIcon: Icons.tour_outlined,
                ),
                BarItem(
                  filledIcon: Icons.email_rounded,
                  outlinedIcon: Icons.email_outlined,
                ),
                BarItem(
                  filledIcon: Icons.folder_rounded,
                  outlinedIcon: Icons.folder_outlined,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
