// // //created by: FAMZY CodeWorks
// // import 'package:famzy_tourz_v2/constants.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:flutter_spinkit/flutter_spinkit.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

// // class MainScreen extends StatefulWidget {
// //   const MainScreen({super.key});

// //   @override
// //   State<MainScreen> createState() => _MainScreenState();
// // }

// // class _MainScreenState extends State<MainScreen> {
// //   final Color navigationBarColor = Colors.white;
// //   final FirebaseAuth _auth = FirebaseAuth.instance;

// //   late PageController _pageController;
// //   int _selectedIndex = 0;

// //   bool _isInitialCheckComplete = false;
// //   bool _isEmailVerified = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _pageController = PageController(initialPage: _selectedIndex);
// //     _initialize();
// //   }

// //   Future<void> _initialize() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     _isEmailVerified = prefs.getBool('isEmailVerified') ?? false;

// //     if (!_isEmailVerified) {
// //       await _verifyEmailStatus();
// //     } else {
// //       setState(() => _isInitialCheckComplete = true);
// //     }
// //   }

// //   Future<void> _verifyEmailStatus() async {
// //     await _auth.currentUser?.reload();
// //     final user = _auth.currentUser;

// //     final isVerified = user?.emailVerified ?? false;

// //     if (!isVerified && mounted) {
// //       await user?.sendEmailVerification();

// //       await Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(
// //           builder: (_) => const EmailVerificationPendingScreen(),
// //         ),
// //       );
// //     } else if (mounted) {
// //       final prefs = await SharedPreferences.getInstance();
// //       await prefs.setBool('isEmailVerified', true);

// //       setState(() {
// //         _isEmailVerified = true;
// //         _isInitialCheckComplete = true;
// //       });
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _pageController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     // Initial loading
// //     if (!_isInitialCheckComplete || !_isEmailVerified) {
// //       return Scaffold(
// //         body: Center(
// //           child: SpinKitSpinningLines(color: Colors.white, size: 70.r),
// //         ),
// //       );
// //     }

// //     return AnnotatedRegion<SystemUiOverlayStyle>(
// //       value: SystemUiOverlayStyle(
// //         systemNavigationBarColor: navigationBarColor,
// //         systemNavigationBarIconBrightness: Brightness.dark,
// //       ),
// //       child: Scaffold(
// //         backgroundColor: Colors.grey,
// //         body: PageView(
// //           controller: _pageController,
// //           physics: const NeverScrollableScrollPhysics(),
// //           children: const [
// //             // ⚠️ NOT MIGRATED YET – placeholders
// //             Center(child: Text('Feed Screen')),
// //             Center(child: Text('Tour Packages')),
// //             Center(child: Text('Chat List')),
// //             Center(child: Text('Profile')),
// //           ],
// //         ),
// //         bottomNavigationBar: WaterDropNavBar(
// //           backgroundColor: AppConstants.primaryColor,
// //           waterDropColor: Colors.white,
// //           bottomPadding: 8.h,
// //           inactiveIconColor: AppConstants.whiteColorP5,
// //           selectedIndex: _selectedIndex,
// //           onItemSelected: (index) {
// //             setState(() => _selectedIndex = index);
// //             _pageController.animateToPage(
// //               index,
// //               duration: const Duration(milliseconds: 400),
// //               curve: Curves.easeOutQuad,
// //             );
// //           },
// //           barItems: [
// //             BarItem(
// //               filledIcon: Icons.festival,
// //               outlinedIcon: Icons.festival_outlined,
// //             ),
// //             BarItem(
// //               filledIcon: Icons.tour_rounded,
// //               outlinedIcon: Icons.tour_outlined,
// //             ),
// //             BarItem(
// //               filledIcon: Icons.email_rounded,
// //               outlinedIcon: Icons.email_outlined,
// //             ),
// //             BarItem(
// //               filledIcon: Icons.folder_rounded,
// //               outlinedIcon: Icons.folder_outlined,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // created by: FAMZY CodeWorks
// // import 'package:famzy_tourz_v2/constants.dart';
// // import 'package:famzy_tourz_v2/presentation/providers/main_provider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:flutter_spinkit/flutter_spinkit.dart';
// // import 'package:provider/provider.dart';
// // import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

// // class MainScreen extends StatelessWidget {
// //   const MainScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Consumer<MainProvider>(
// //       builder: (context, main, _) {
// //         if (!main.isReady) {
// //           return const Scaffold(
// //             body: Center(
// //               child: SpinKitSpinningLines(color: Colors.white, size: 70),
// //             ),
// //           );
// //         }

// //         return AnnotatedRegion<SystemUiOverlayStyle>(
// //           value: const SystemUiOverlayStyle(
// //             systemNavigationBarColor: Colors.white,
// //             systemNavigationBarIconBrightness: Brightness.dark,
// //           ),
// //           child: Scaffold(
// //             backgroundColor: Colors.grey,
// //             body: PageView(
// //               controller: main.pageController,
// //               physics: const NeverScrollableScrollPhysics(),
// //               children: const [
// //                 Center(child: Text('Feed Screen')),
// //                 Center(child: Text('Tour Packages')),
// //                 Center(child: Text('Chat List')),
// //                 Center(child: Text('Profile')),
// //               ],
// //             ),
// //             bottomNavigationBar: WaterDropNavBar(
// //               backgroundColor: AppConstants.primaryColor,
// //               waterDropColor: Colors.white,
// //               bottomPadding: 8.h,
// //               inactiveIconColor: AppConstants.whiteColorP5,
// //               selectedIndex: main.selectedIndex,
// //               onItemSelected: main.onTabSelected,
// //               barItems: [
// //                 BarItem(
// //                   filledIcon: Icons.festival,
// //                   outlinedIcon: Icons.festival_outlined,
// //                 ),
// //                 BarItem(
// //                   filledIcon: Icons.tour_rounded,
// //                   outlinedIcon: Icons.tour_outlined,
// //                 ),
// //                 BarItem(
// //                   filledIcon: Icons.email_rounded,
// //                   outlinedIcon: Icons.email_outlined,
// //                 ),
// //                 BarItem(
// //                   filledIcon: Icons.folder_rounded,
// //                   outlinedIcon: Icons.folder_outlined,
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// // created by: FAMZY CodeWorks
// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:famzy_tourz_v2/presentation/providers/auth_provider.dart';
// import 'package:famzy_tourz_v2/presentation/providers/main_provider.dart';
// import 'package:famzy_tourz_v2/presentation/screens/mainscreens/destinations/destinations_screen.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/sign_out_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

// class MainScreen extends StatelessWidget {
//   const MainScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<MainProvider>(
//       builder: (context, main, _) {
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
//               children: [
// Center(
//   child: Consumer<AuthProvider>(
//     builder: (context, auth, _) {
//       return ConfirmActionButton(
//         buttonText: 'Sign Out',
//         icon: Icons.logout_rounded,
//         dialogTitle: 'Sign Out',
//         dialogMessage:
//             'Are you sure you want to log out of FAMZY Tourz?',
//         isDanger: true,
//         confirmColor: Colors.red,
//         isLoading: auth.loading,
//         onConfirmed: () => auth.emailSignOut(),
//       );
//     },
//   ),
// ),
// const DestinationsScreen(),
// const Center(child: Text('Chat List')),
// const Center(child: Text('Profile')),
//               ],
//             ),
//             bottomNavigationBar: WaterDropNavBar(
// backgroundColor: AppConstants.primaryColor,
// waterDropColor: Colors.white,
// bottomPadding: 8.h,
// inactiveIconColor: AppConstants.whiteColorP5,
// selectedIndex: main.selectedIndex,
// onItemSelected: main.onTabSelected.call,
// barItems: [
//   BarItem(
//     filledIcon: Icons.festival,
//     outlinedIcon: Icons.festival_outlined,
//   ),
//   BarItem(
//     filledIcon: Icons.tour_rounded,
//     outlinedIcon: Icons.tour_outlined,
//   ),
//   BarItem(
//     filledIcon: Icons.email_rounded,
//     outlinedIcon: Icons.email_outlined,
//   ),
//   BarItem(
//     filledIcon: Icons.folder_rounded,
//     outlinedIcon: Icons.folder_outlined,
//   ),
// ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:famzy_tourz_v2/presentation/providers/auth_provider.dart';
// import 'package:famzy_tourz_v2/presentation/providers/main_provider.dart';
// import 'package:famzy_tourz_v2/presentation/screens/mainscreens/destinations/destinations_screen.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/sign_out_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

// class MainScreen extends StatelessWidget {
//   const MainScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<MainProvider>(
//       builder: (context, main, _) {
//         return PopScope(
//           canPop: false, // Prevents the app from closing immediately
//           onPopInvokedWithResult: (bool didPop, dynamic result) async {
//             if (didPop) return; // If already popped, do nothing

//             // Show the confirmation dialog
//             final shouldExit = await showDialog<bool>(
//               context: context,
//               builder: (context) => AlertDialog(
//                 title: const Text('Exit App'),
//                 content: const Text('Do you want to exit FAMZY Tourz?'),
//                 actions: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context, false),
//                     child: const Text('No'),
//                   ),
//                   TextButton(
//                     onPressed: () => Navigator.pop(context, true),
//                     child: const Text(
//                       'Exit',
//                       style: TextStyle(color: Colors.red),
//                     ),
//                   ),
//                 ],
//               ),
//             );

//             // If user confirmed, exit the app
//             if (shouldExit == true) {
//               SystemNavigator.pop();
//             }
//           },
//           child: AnnotatedRegion<SystemUiOverlayStyle>(
//             // ... rest of your existing code
//             value: const SystemUiOverlayStyle(
//               systemNavigationBarColor: Colors.white,
//               systemNavigationBarIconBrightness: Brightness.dark,
//             ),
//             child: Scaffold(
//               backgroundColor: Colors.grey,
//               body: PageView(
//                 controller: main.pageController,
//                 physics: const NeverScrollableScrollPhysics(),
//                 children: [
//                   // ... (your existing children)
//                   Center(
//                     child: Consumer<AuthProvider>(
//                       builder: (context, auth, _) {
//                         return ConfirmActionButton(
//                           buttonText: 'Sign Out',
//                           icon: Icons.logout_rounded,
//                           dialogTitle: 'Sign Out',
//                           dialogMessage:
//                               'Are you sure you want to log out of FAMZY Tourz?',
//                           isDanger: true,
//                           confirmColor: Colors.red,
//                           isLoading: auth.loading,
//                           onConfirmed: () => auth.emailSignOut(),
//                         );
//                       },
//                     ),
//                   ),
//                   const DestinationsScreen(),
//                   const Center(child: Text('Chat List')),
//                   const Center(child: Text('Profile')),
//                 ],
//               ),
//               bottomNavigationBar: WaterDropNavBar(
//                 // ... (your existing nav bar code)
//                 backgroundColor: AppConstants.primaryColor,
//                 waterDropColor: Colors.white,
//                 bottomPadding: 8.h,
//                 inactiveIconColor: AppConstants.whiteColorP5,
//                 selectedIndex: main.selectedIndex,
//                 onItemSelected: main.onTabSelected.call,
//                 barItems: [
//                   BarItem(
//                     filledIcon: Icons.festival,
//                     outlinedIcon: Icons.festival_outlined,
//                   ),
//                   BarItem(
//                     filledIcon: Icons.tour_rounded,
//                     outlinedIcon: Icons.tour_outlined,
//                   ),
//                   BarItem(
//                     filledIcon: Icons.email_rounded,
//                     outlinedIcon: Icons.email_outlined,
//                   ),
//                   BarItem(
//                     filledIcon: Icons.folder_rounded,
//                     outlinedIcon: Icons.folder_outlined,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// created by: FAMZY CodeWorks
import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/desstinations_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/main_provider.dart';
import 'package:famzy_tourz_v2/presentation/screens/admin-screens/admin_bookings_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/mainscreens/destinations/destinations_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/mainscreens/destinations/my_bookings_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/mainscreens/profile/profile_screen.dart';
import 'package:famzy_tourz_v2/presentation/widgets/dialogs/custom_app_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<DestinationsProvider>().checkUserRole();
    final userRole = context.read<DestinationsProvider>().userRole;
    return Consumer<MainProvider>(
      builder: (context, main, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (main.pageController.hasClients) {
            // Check if current page matches provider index
            // using .round() to handle potential micro-offsets during animation
            // if (main.pageController.page?.round() != main.selectedIndex) {
            //   main.pageController.jumpToPage(main.selectedIndex);
            // }
            main.pageController.jumpToPage(main.selectedIndex);
          }
        });
        return PopScope(
          canPop: false, // Intercepts the back button
          onPopInvokedWithResult: (bool didPop, dynamic result) async {
            if (didPop) return;

            // Use your custom FAMZY dialog
            final shouldExit = await AppConfirmDialog.show(
              context,
              title: 'Exit App',
              message: 'Are you sure you want to close FAMZY Tourz?',
              confirmText: 'Exit',
              cancelText: 'Stay',
              iconColor: AppConstants.lightRed,
              confirmColor: AppConstants.lightRed,
              icon: Icons.exit_to_app_rounded,
            );

            if (shouldExit == true) {
              // await SystemNavigator.pop(); // Closes the app
              NavigationService().pop();
            }
          },
          child: AnnotatedRegion<SystemUiOverlayStyle>(
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
                  // Center(
                  //   child: Consumer<AuthProvider>(
                  //     builder: (context, auth, _) {
                  //       return ConfirmActionButton(
                  //         buttonText: 'Sign Out',
                  //         icon: Icons.logout_rounded,
                  //         dialogTitle: 'Sign Out',
                  //         dialogMessage:
                  //             'Are you sure you want to log out of FAMZY Tourz?',
                  //         isDanger: true,
                  //         isLoading: auth.loading,
                  //         onConfirmed: () => auth.emailSignOut(),
                  //       );
                  //     },
                  //   ),
                  // ),
                  userRole == 'admin'
                      ? const AdminBookingsScreen()
                      : const Center(child: Text('Chat List')),
                  // const Center(child: Text('Profile')),
                  const DestinationsScreen(),
                  const MyBookingsScreen(),
                  const ProfileScreen(),
                ],
              ),
              bottomNavigationBar: WaterDropNavBar(
                backgroundColor: AppConstants.primaryColor,
                waterDropColor: Colors.white,
                bottomPadding: 20.h,
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
                    filledIcon: Icons.person_4_rounded,
                    outlinedIcon: Icons.person_rounded,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
