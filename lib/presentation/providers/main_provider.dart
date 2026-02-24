// import 'package:famzy_tourz_v2/data/services/session_service.dart';
// import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
// import 'package:famzy_tourz_v2/routes/app_routes.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class MainProvider extends ChangeNotifier {
//   final NavigationService _navigation = NavigationService();
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   late PageController pageController;

//   int _selectedIndex = 0;
//   bool _isReady = false;

//   int get selectedIndex => _selectedIndex;
//   bool get isReady => _isReady;

//   MainProvider() {
//     pageController = PageController(initialPage: _selectedIndex);
//     initialize();
//   }

//   Future<void> initialize() async {
//     final isVerified = await SessionService.isEmailVerified();

//     if (!isVerified) {
//       await _auth.currentUser?.sendEmailVerification();

//       _navigation.navigateReplacement(AppRoutes.emailVerification);
//       return;
//     }

//     _isReady = true;
//     notifyListeners();
//   }

//   void onTabSelected(int index) {
//     _selectedIndex = index;
//     pageController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeOutQuad,
//     );
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     pageController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  late PageController pageController;

  int _selectedIndex = 0;
  // final bool _isReady = true; // Always ready now

  int get selectedIndex => _selectedIndex;
  // bool get isReady => _isReady;

  MainProvider() {
    // pageController = PageController(initialPage: _selectedIndex);
    _initController();
  }
  void _initController() {
    pageController = PageController(initialPage: _selectedIndex);
  }

  //Add this to reset the state when coming back from a Booking
  void resetToHome(int index) {
    _selectedIndex = index; // Or 0, wherever your 'Destinations' screen is

    pageController.dispose();
    _initController();
    notifyListeners();
  }

  void setTab(int index) {
    _selectedIndex = index;
    // Use jumpToPage to immediately sync the PageView without animation
    if (pageController.hasClients) {
      pageController.jumpToPage(index);
    }
    notifyListeners();
  }

  void onTabSelected(int index) {
    if (_selectedIndex == index) return;

    _selectedIndex = index;

    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutQuad,
    );

    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
