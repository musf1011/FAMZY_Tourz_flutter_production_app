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
import 'package:famzy_tourz_v2/data/services/packages-services/packages_service.dart';
import 'package:flutter/material.dart';

class AddPackageProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final PackagesService _service = PackagesService();

  /// FORM FIELDS
  String packageName = '';
  String duration = '';
  String departureDate = '';
  String departureTime = '';
  String keySpots = '';
  String vehicle = '';
  String description = '';
  String price = '';

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

  /// INIT (for edit)
  void loadForEdit(PackageModel pkg) {
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

  /// RESET
  void reset() {
    editingPackage = null;
    showSuccess = false;
    showError = false;
    notifyListeners();
  }

  /// MAIN SUBMIT
  Future<void> submitWithConfirmation({
    required String destinationName,
    required bool confirmed,
  }) async {
    if (!confirmed) return;

    await submit(destinationName);
  }

  Future<void> submit(String destinationName) async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    isLoading = true;
    notifyListeners();

    try {
      final id = isEditMode
          ? editingPackage!.id
          : "${packageName.toLowerCase().replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}";

      final package = PackageModel(
        id: id,
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
