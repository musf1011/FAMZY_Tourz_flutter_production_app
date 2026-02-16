// // import 'package:famzy_tourz_v2/data/models/package_model.dart';
// // import 'package:famzy_tourz_v2/data/services/packages-services/packages_service.dart';
// // import 'package:flutter/material.dart';

// // class AddPackageProvider extends ChangeNotifier {
// //   final formKey = GlobalKey<FormState>();

// //   String packageName = '';
// //   String duration = '';
// //   String departureDate = '';
// //   String departureTime = '';
// //   String keySpots = '';
// //   String vehicle = '';
// //   String description = '';
// //   String price = '';

// //   bool isLoading = false;
// //   bool showSuccess = false;
// //   bool showError = false;

// //   Future<void> submit(String destination) async {
// //     if (!formKey.currentState!.validate()) return;

// //     formKey.currentState!.save();
// //     isLoading = true;
// //     notifyListeners();

// //     try {
// //       await PackagesService().addPackage(
// //         PackageModel(
// //           id: DateTime.now().millisecondsSinceEpoch.toString(),
// //           packageName: packageName,
// //           duration: duration,
// //           departureDate: departureDate,
// //           departureTime: departureTime,
// //           keySpots: keySpots,
// //           vehicle: vehicle,
// //           description: description,
// //           price: price,
// //           destination: destination,
// //         ),
// //       );

// //       showSuccess = true;
// //     } catch (e) {
// //       showError = true;
// //     }

// //     isLoading = false;
// //     notifyListeners();
// //   }
// // }

// import 'package:famzy_tourz_v2/data/models/package_model.dart';
// import 'package:famzy_tourz_v2/data/services/packages-services/packages_service.dart';
// import 'package:flutter/material.dart';

// class AddPackageProvider extends ChangeNotifier {
//   final formKey = GlobalKey<FormState>();

//   String packageName = '';
//   String duration = '';
//   String date = '';
//   String time = '';
//   String keySpots = '';
//   String vehicle = '';
//   String description = '';
//   String price = '';

//   bool isLoading = false;
//   bool showSuccess = false;
//   bool showError = false;

//   void updateDate(String newDate) {
//     date = newDate;
//     notifyListeners();
//   }

//   void updateTime(String newTime) {
//     time = newTime;
//     notifyListeners();
//   }

//   void reset() {
//     showSuccess = false;
//     showError = false;
//     packageName = '';
//     // ... reset others ...
//     notifyListeners();
//   }

//   // String generateId(String name, String destinationName) {
//   //   return '${name.toLowerCase().replaceAll(' ', '_')}_${ destinationName.toLowerCase()}_${DateTime.now().millisecondsSinceEpoch}';
//   // }

//   Future<void> submit(String destinationName) async {
//     if (!formKey.currentState!.validate()) return;
//     formKey.currentState!.save();

//     isLoading = true;
//     notifyListeners();

//     try {
//       final id =
//           "${packageName.toLowerCase().replaceAll(' ', '_')}_${destinationName.toLowerCase()}_${DateTime.now().millisecondsSinceEpoch}";

//       await PackagesService().addPackage(
//         PackageModel(
//           id: id,
//           companyName:  companyName,
//           packageName: packageName,
//           duration: duration,
//           departureDate: date,
//           departureTime: time,
//           keySpots: keySpots,
//           vehicle: vehicle,
//           description: description,
//           price: price,
//           destination: destinationName,
//           packageCreatedAt:
//         ),
//       );
//       showSuccess = true;
//     } catch (e) {
//       showError = true;
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }

import 'package:famzy_tourz_v2/data/models/package_model.dart';
import 'package:famzy_tourz_v2/data/models/user_model.dart';
import 'package:famzy_tourz_v2/data/services/packages-services/packages_service.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/user_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/desstinations_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPackageProvider extends ChangeNotifier {
  final UserProvider _userProvider;
  AddPackageProvider(this._userProvider);

  final formKey = GlobalKey<FormState>();

  final PackagesService _service = PackagesService();

  /// FORM FIELDS
  String packageName = '';
  String packageId = '';
  String duration = '';
  String departureDate = '';
  String departureTime = '';
  String keySpots = '';
  String vehicle = '';
  String description = '';
  int price = 0;

  /// COMPANY INFO (auto-filled)
  String companyName = '';
  String companyPhotoURL = '';

  /// EDIT MODE
  PackageModel? editingPackage;
  bool get isEditMode => editingPackage != null;

  /// UI STATE
  bool isLoading = false;
  bool showSuccess = false;
  bool showError = false;

  /// Set Company Info from UserProvider
  void setCompanyInfo(AppUser user) {
    // We only set this if we aren't in edit mode
    // (In edit mode, we want to keep the original creator's name)
    if (!isEditMode) {
      companyName = user.name;
      companyPhotoURL = user.photoURL;
      // No notifyListeners() needed here if called during build/init
    }
  }

  /// INIT (for edit)
  void loadForEdit(PackageModel pkg) {
    packageId = pkg.id;
    editingPackage = pkg;
    packageName = pkg.packageName;
    duration = pkg.duration;
    departureDate = pkg.departureDate;
    departureTime = pkg.departureTime;
    keySpots = pkg.keySpots;
    vehicle = pkg.vehicle;
    description = pkg.description;
    price = pkg.price;
    companyName = pkg.companyName;
    companyPhotoURL = pkg.companyPhotoURL;
    notifyListeners();
  }

  /// RESET ALL FIELDS
  void reset() {
    editingPackage = null;
    packageName = '';
    packageId = '';
    duration = '';
    departureDate = '';
    departureTime = '';
    keySpots = '';
    vehicle = '';
    description = '';
    price = 0;
    companyName = '';
    companyPhotoURL = '';
    showSuccess = false;
    showError = false;
    isLoading = false;
    notifyListeners();
  }
  // /// MAIN SUBMIT
  // Future<void> submitWithConfirmation({
  //   required String destinationName,
  //   required AppUser user,
  //   required bool confirmed,
  // }) async {
  //   if (!confirmed) return;

  //   await submit(destinationName, user);
  // }
  Future<void> submitWithConfirmation({
    required String destinationName,
    required bool confirmed,
  }) async {
    if (!confirmed) return;

    final user = _userProvider.user;
    if (user == null) {
      showError = true;
      notifyListeners();
      return;
    }

    await submit(destinationName, user);
  }

  // 1. Updated setter that actually notifies the UI to rebuild
  void setPackageName(String value) {
    packageName = value;
    notifyListeners();
  }

  // 2. Stable Preview ID (No timestamp here so it doesn't flicker)
  // String get previewId {
  //   if (packageName.isEmpty) return '';
  //     // Get the provider instance from context
  //   return '${packageName.toLowerCase().replaceAll(' ', '_').trim()}_${companyName.toLowerCase().replaceAll(' ', '_')}_${DestinationsProvider().selectedDestination.name}_uniquecode';
  // }
  String getPreviewId(BuildContext context) {
    if (packageName.isEmpty) return '';
    final destinationsProvider = Provider.of<DestinationsProvider>(
      context,
      listen: false,
    );
    return '${packageName.toLowerCase().replaceAll(' ', '_').trim()}_${companyName.toLowerCase().replaceAll(' ', '_')}_${destinationsProvider.selectedDestination.name}_uniquecode';
  }

  Future<void> submit(String destinationName, AppUser user) async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    isLoading = true;
    notifyListeners();

    try {
      // 3. FINAL ID LOGIC: Keep existing if editing, otherwise create unique
      final String finalId = isEditMode
          ? editingPackage!.id
          : '${packageName.toLowerCase().replaceAll(' ', '_')}_${companyName.toLowerCase().replaceAll(' ', '_')}_${destinationName}_${DateTime.now().millisecondsSinceEpoch}';
      setCompanyInfo(user);
      debugPrint(
        '***id:$finalId,\n***company: $companyName,\n***companyphoto: $companyPhotoURL,\n***duration:$duration,\n***depTime:$departureTime,\n***depDate:$departureDate,\n***keyspot:$keySpots,\n***vehicle:$vehicle,\n***description:$description,\n***destinationName:$destinationName',
      );

      final package = PackageModel(
        id: finalId,
        companyName: companyName,
        companyPhotoURL: companyPhotoURL,
        packageName: packageName,
        duration: duration,
        departureDate: departureDate,
        departureTime: departureTime,
        keySpots: keySpots,
        vehicle: vehicle,
        description: description,
        price: price,
        destination: destinationName,
        packageCreatedAt: isEditMode
            ? editingPackage!.packageCreatedAt
            : DateTime.now().toIso8601String(),
        packageEditedAt: isEditMode ? DateTime.now().toIso8601String() : null,
      );

      if (isEditMode) {
        await _service.updatePackage(package);
      } else {
        await _service.addPackage(package);
      }

      showSuccess = true;
    } catch (e) {
      showError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleError(bool value) {
    showError = value;
    notifyListeners();
  }
}
