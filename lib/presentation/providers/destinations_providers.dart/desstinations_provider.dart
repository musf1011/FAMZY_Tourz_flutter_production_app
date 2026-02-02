// // // created by: FAMZY CodeWorks

// // import 'package:flutter/material.dart';
// // import '../../data/local/destinations_local_data.dart';
// // import '../../data/models/destination_model.dart';

// // class DestinationsProvider extends ChangeNotifier {
// //   final PageController pageController = PageController();

// //   int _currentIndex = 0;
// //   int get currentIndex => _currentIndex;

// //   List<DestinationModel> get destinations => DestinationsLocalData.destinations;

// //   DestinationModel get selectedDestination =>
// //       DestinationsLocalData.destinations[_currentIndex];

// //   void onPageChanged(int index) {
// //     _currentIndex = index;
// //     notifyListeners();
// //   }

// //   @override
// //   void dispose() {
// //     pageController.dispose();
// //     super.dispose();
// //   }
// // }

// // created by: FAMZY CodeWorks

// import 'package:famzy_tourz_v2/data/services/packages-services/admin_service.dart';
// import 'package:famzy_tourz_v2/data/services/packages-services/packages_service.dart';
// import 'package:famzy_tourz_v2/data/services/packages-services/weather_service.dart';
// import 'package:flutter/material.dart';
// import '../../data/local/destinations_local_data.dart';
// import '../../data/models/destination_model.dart';

// class DestinationsProvider extends ChangeNotifier {
//   /// ------------------ DESTINATION STATE ------------------

//   final PageController pageController = PageController();

//   int _currentIndex = 0;
//   int get currentIndex => _currentIndex;

//   List<DestinationModel> get destinations => DestinationsLocalData.destinations;

//   DestinationModel get selectedDestination =>
//       DestinationsLocalData.destinations[_currentIndex];

//   void onPageChanged(int index) {
//     _currentIndex = index;
//     notifyListeners();
//   }

//   /// ------------------ SERVICES ------------------

//   final PackagesService _packagesService = PackagesService();
//   final WeatherService _weatherService = WeatherService();
//   final AdminService _adminService = AdminService();

//   /// ------------------ PACKAGES STATE ------------------

//   List<Map<String, dynamic>> _packages = [];
//   List<Map<String, dynamic>> get packages => _packages;

//   bool _isLoadingPackages = false;
//   bool get isLoadingPackages => _isLoadingPackages;

//   Future<void> loadPackages() async {
//     _isLoadingPackages = true;
//     notifyListeners();

//     _packages = await _packagesService.fetchPackagesForDestination(
//       selectedDestination.name,
//     );

//     _isLoadingPackages = false;
//     notifyListeners();
//   }

//   /// ------------------ WEATHER STATE ------------------

//   WeatherData? _weather;
//   WeatherData? get weather => _weather;

//   bool _isLoadingWeather = false;
//   bool get isLoadingWeather => _isLoadingWeather;

//   Future<void> loadWeather() async {
//     _isLoadingWeather = true;
//     notifyListeners();

//     _weather = await _weatherService.getWeather(
//       selectedDestination.latitude,
//       selectedDestination.longitude,
//     );

//     _isLoadingWeather = false;
//     notifyListeners();
//   }

//   /// ------------------ ADMIN STATE ------------------

//   bool _isAdmin = false;
//   bool get isAdmin => _isAdmin;

//   Future<void> checkAdmin() async {
//     _isAdmin = await _adminService.isCurrentUserAdmin();
//     notifyListeners();
//   }

//   /// ------------------ PACKAGE DELETE ------------------

//   Future<void> deletePackage(String tourId) async {
//     await _packagesService.deletePackage(tourId);
//     await loadPackages(); // refresh
//   }

//   /// ------------------ INIT FOR PACKAGE SCREEN ------------------

//   Future<void> initPackagesScreen() async {
//     await checkAdmin();
//     await loadPackages();
//     await loadWeather();
//   }

//   @override
//   void dispose() {
//     pageController.dispose();
//     super.dispose();
//   }
// }

// created by: FAMZY CodeWorks

import 'package:famzy_tourz_v2/data/models/package_model.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../data/local/destinations_local_data.dart';
import '../../../data/models/destination_model.dart';
import '../../../data/services/packages-services/admin_service.dart';
import '../../../data/services/packages-services/packages_service.dart';
import '../../../data/services/packages-services/weather_service.dart';

class DestinationsProvider extends ChangeNotifier {
  /// ================= DESTINATION STATE =================

  final PageController pageController = PageController();

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  List<DestinationModel> get destinations => DestinationsLocalData.destinations;

  DestinationModel get selectedDestination =>
      DestinationsLocalData.destinations[_currentIndex];

  void onPageChanged(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  /// ================= SERVICES =================
  final PackagesService _packagesService = PackagesService();
  final WeatherService _weatherService = WeatherService();

  /// ================= PACKAGES STATE =================

  List<PackageModel> _packages = [];
  List<PackageModel> get packages => _packages;

  bool _isLoadingPackages = false;
  bool get isLoadingPackages => _isLoadingPackages;

  Future<void> loadPackages() async {
    _packages = [];
    _isLoadingPackages = true;
    notifyListeners();

    final raw = await _packagesService.fetchPackages(selectedDestination.name);
    _packages = raw.map((e) => PackageModel.fromMap(e)).toList();
    _isLoadingPackages = false;
    notifyListeners();
  }

  //missing card's functions
  void bookPackage(PackageModel package) {
    // Later connect to booking flow
    debugPrint('Booking package: ${package.packageName}');
  }

  void editPackage(PackageModel package) {
    // Later connect to edit screen
    debugPrint('Editing package: ${package.packageName}');
  }

  /// ================= LOCATON PERMISSION=================
  // inside DestinationsProvider
  bool _isLocationGranted = false;
  bool get isLocationGranted => _isLocationGranted;

  Future<void> checkAndRequestLocation() async {
    // 1. Check current status without showing a popup
    final status = await Permission.location.status;

    if (status.isGranted) {
      _isLocationGranted = true;
    } else if (status.isDenied) {
      // 2. Only show the popup if it hasn't been permanently denied
      final result = await Permission.location.request();
      _isLocationGranted = result.isGranted;
    }

    notifyListeners();
  }

  /// ================= WEATHER STATE =================
  /// (Your WeatherService returns MapString,dynamic)
  Map<String, dynamic>? _weather;
  Map<String, dynamic>? get weather => _weather;

  bool _isLoadingWeather = false;
  bool get isLoadingWeather => _isLoadingWeather;

  Future<void> loadWeather() async {
    _isLoadingWeather = true;
    notifyListeners();
    try {
      _weather = await _weatherService.fetchWeather(
        selectedDestination.latitude,
        selectedDestination.longitude,
      );
    } catch (e) {
      debugPrint('error fetching weather adat');
    } finally {
      _isLoadingWeather = false;
      notifyListeners();
    }
  }

  /// ================= ADMIN STATE =================
  String? _userRole;
  String? get userRole => _userRole;

  bool get canManagePackages => _userRole == 'admin' || _userRole == 'company';

  Future<void> checkUserRole() async {
    _userRole = await AdminService.getUserRole();
    notifyListeners();
  }

  /// ================= PACKAGE ADD =================
  Future<void> addNewPackage(PackageModel package) async {
    await _packagesService.addPackage(package);
    await loadPackages(); // refresh list after adding
  }

  /// ================= PACKAGE DELETE =================
  Future<void> deletePackage(PackageModel package) async {
    await _packagesService.deletePackage(package.id);
    await loadPackages();
  }

  /// ================= INIT FOR PACKAGE SCREEN =================
  Future<void> initPackagesScreen() async {
    await checkUserRole();
    await loadPackages();
    await loadWeather();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
