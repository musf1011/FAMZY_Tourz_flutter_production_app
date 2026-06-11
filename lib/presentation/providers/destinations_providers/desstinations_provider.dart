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
  late PageController _pageController;
  PageController get pageController => _pageController;
  DestinationsProvider() {
    // This runs only once when the app starts or provider is created
    _pageController = PageController(initialPage: _currentIndex);

    debugPrint('Page controller: $_currentIndex');
  }

  /// ================= DESTINATION STATE =================

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  List<DestinationModel> get destinations => DestinationsLocalData.destinations;

  DestinationModel get selectedDestination =>
      DestinationsLocalData.destinations[_currentIndex];

  void onPageChanged(int index) {
    // _currentIndex = index;
    // notifyListeners();

    // Use Future.microtask to delay the update until the build is done
    Future.microtask(() {
      if (_currentIndex != index) {
        _currentIndex = index;
        debugPrint('index updated****: $_currentIndex');
        notifyListeners();
      }
    });
  }

  // // 2. Add a jump method to use when the screen loads
  // void syncController() {
  //   if (pageController.hasClients) {
  //     pageController.jumpToPage(_currentIndex);
  //   }
  // }

  /// ================= SERVICES =================
  final PackagesService _packagesService = PackagesService();
  final WeatherService _weatherService = WeatherService();

  /// ================= PACKAGES STATE =================

  List<PackageModel> _packages = [];
  List<PackageModel> get packages => _packages;

  bool _isLoadingPackages = false;
  bool get isLoadingPackages => _isLoadingPackages;

  // Future<void> loadPackages() async {
  //   _packages = [];
  //   _isLoadingPackages = true;
  //   notifyListeners();

  //   final raw = await _packagesService.fetchPackages(selectedDestination.name);
  //   _packages = raw.map((e) => PackageModel.fromMap(e)).toList();
  //   _isLoadingPackages = false;
  //   notifyListeners();
  // }
  Future<void> loadPackages() async {
    _packages = [];
    _isLoadingPackages = true;
    notifyListeners();

    try {
      debugPrint(
        '****selected destination in provider: ${selectedDestination.name}',
      );
      final raw = await _packagesService.fetchPackages(
        selectedDestination.name,
      );

      // 1. Convert raw data to models
      final allPackages = raw.map((e) => PackageModel.fromMap(e)).toList();
      debugPrint('****got raw ${allPackages.length}');
      // 2. Filter and Sort
      final now = DateTime.now();

      _packages =
          allPackages.where((package) {
              // Keep only if departure is in the future
              return package.departureDateTime.isAfter(now);
            }).toList()
            // Sort by nearest departure date first
            ..sort(
              (a, b) => a.departureDateTime.compareTo(b.departureDateTime),
            );
      debugPrint('***packages:${allPackages.first.packageName}');
    } catch (e) {
      debugPrint('Error loading packages: $e');
      // Handle error state if necessary
    } finally {
      _isLoadingPackages = false;
      notifyListeners();
    }
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
      // THE MAGIC TRICK: If the app is busy building,
      // wait a millisecond to notify.
      await Future.microtask(() => notifyListeners());
      // notifyListeners();
    }
  }

  /// ================= ADMIN STATE =================
  String? _userRole;
  String? get userRole => _userRole;

  bool get canManagePackages => _userRole == 'admin' || _userRole == 'company';
  // Specific role checks for UI logic
  bool get isAdmin => _userRole == 'admin';
  bool get isCompany => _userRole == 'company';
  bool get isUser => _userRole == 'user' || _userRole == null;
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
    await _packagesService.deletePackage(package.packageId);
    await loadPackages();
  }

  /// ================= PACKAGE REACTIVATE =================
  Future<void> reactivatePackage(PackageModel package) async {
    // await _packagesService.reactivatePackage(package.packageId);
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

  /// ================= PACKAGE DETAIL STATE =================

  // PackageModel? _selectedPackage;
  // PackageModel? get selectedPackage => _selectedPackage;

  // int _seatCount = 1;
  // int get seatCount => _seatCount;

  // int get totalPrice {
  //   if (_selectedPackage == null) return 0;
  //   return _seatCount * _selectedPackage!.price;
  // }

  // /// select package
  // void selectPackage(PackageModel package) {
  //   _selectedPackage = package;
  //   _seatCount = 1;
  //   notifyListeners();
  // }

  // /// increase seats
  // void increaseSeat() {
  //   if (_seatCount < 5) {
  //     _seatCount++;
  //     notifyListeners();
  //   }
  // }

  // /// decrease seats
  // void decreaseSeat() {
  //   debugPrint('****seat decreased $_seatCount');
  //   if (_seatCount > 1) {
  //     _seatCount--;

  //     notifyListeners();
  //   }
  // }
}
