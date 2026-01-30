import 'package:famzy_tourz_v2/data/models/package_model.dart';
import 'package:famzy_tourz_v2/data/services/packages-services/packages_service.dart';
import 'package:flutter/material.dart';

class AddPackageProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  String packageName = '';
  String duration = '';
  String date = '';
  String time = '';
  String keySpots = '';
  String vehicle = '';
  String description = '';
  String price = '';

  bool isLoading = false;
  bool showSuccess = false;
  bool showError = false;

  Future<void> submit(String destination) async {
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();
    isLoading = true;
    notifyListeners();

    try {
      await PackagesService().addPackage(
        PackageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          packageName: packageName,
          duration: duration,
          date: date,
          time: time,
          keySpots: keySpots,
          vehicle: vehicle,
          description: description,
          price: price,
          destination: destination,
        ),
      );

      showSuccess = true;
    } catch (e) {
      showError = true;
    }

    isLoading = false;
    notifyListeners();
  }
}
