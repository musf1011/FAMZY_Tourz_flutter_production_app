import 'package:famzy_tourz_v2/data/models/package_model.dart';
import 'package:famzy_tourz_v2/data/models/passenger_model.dart';
import 'package:famzy_tourz_v2/data/models/user_model.dart';
import 'package:famzy_tourz_v2/data/services/packages-services/booking_services.dart';
import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  final BookingService _bookingService = BookingService();

  PackageModel? _package;
  PackageModel? get package => _package;

  int _seatCount = 1;
  int get seatCount => _seatCount;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  final List<Map<String, TextEditingController>> _controllers = [];
  List<Map<String, TextEditingController>> get controllers => _controllers;

  /// ================= SELECTION & INIT =================

  /// Called when a user clicks a package to see details
  void selectPackage(PackageModel pkg) {
    _package = pkg;
    _seatCount = 1; // Reset to 1 seat by default
    _updateControllers(); // Initialize first controller
    notifyListeners();
  }
  // /// INIT
  // void initialize(PackageModel pkg, int seats) {
  //   _package = pkg;
  //   _seatCount = seats;
  //   _generateControllers();
  // }

  void increaseSeat() {
    if (_seatCount < 5) {
      _seatCount++;
      // _generateControllers();
      _updateControllers();
      notifyListeners();
    }
  }

  void decreaseSeat() {
    if (_seatCount > 1) {
      _seatCount--;
      // _generateControllers();
      _updateControllers();
      notifyListeners();
    }
  }
  // void _generateControllers() {
  //   _controllers.clear();

  //   for (int i = 0; i < _seatCount; i++) {
  //     _controllers.add({
  //       'name': TextEditingController(),
  //       'gender': TextEditingController(),
  //       'id': TextEditingController(),
  //       'age': TextEditingController(),
  //     });
  //   }

  //   notifyListeners();
  // }
  /// Logic to add/remove controllers without wiping existing text
  void _updateControllers() {
    // 1. If we need more controllers
    while (_controllers.length < _seatCount) {
      _controllers.add({
        'name': TextEditingController(),
        'gender': TextEditingController(),
        'id': TextEditingController(),
        'age': TextEditingController(),
      });
    }
    // 2. If we need fewer (User decreased seats)
    while (_controllers.length > _seatCount) {
      final removed = _controllers.removeLast();
      for (var c in removed.values) {
        c.dispose(); // Clean up memory
      }
    }
  }

  void prefillFirstPassenger(AppUser? user) {
    if (user == null) return;
    if (_controllers.isEmpty) return;

    final first = _controllers[0];

    // Only fill if empty (avoid overwriting user edits)
    if (first['name']!.text.isEmpty) {
      first['name']!.text = user.name;
    }

    if (first['gender']!.text.isEmpty) {
      first['gender']!.text = user.gender;
    }

    if (first['age']!.text.isEmpty && user.age > 0) {
      first['age']!.text = user.age.toString();
    }

    notifyListeners();
  }

  /// ================= COMPUTED PROPERTIES =================

  // int get totalPrice {
  //   if (_package == null) return 0;
  //   return _package!.price * _seatCount;
  // }

  int get totalPrice {
    if (_package == null) return 0;
    return _package!.price * _seatCount;
  }

  /// ================= SUBMISSION =================

  Future<void> submitBooking(String userId) async {
    if (_package == null) return;

    _isSubmitting = true;
    notifyListeners();

    try {
      final passengers = _controllers.map((c) {
        return PassengerModel(
          name: c['name']!.text.trim(),
          gender: c['gender']!.text.trim(),
          idNumber: c['id']!.text.trim(),
          // Use tryParse to avoid crashes on empty/bad input
          age: int.tryParse(c['age']!.text.trim()) ?? 0,
        );
      }).toList();

      await _bookingService.submitBooking(
        packageId: _package!.id,
        userId: userId,
        passengers: passengers,
      );
    } catch (e) {
      debugPrint('Booking Error: $e');
      rethrow;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  // Future<void> submitBooking(String userId) async {
  //   if (_package == null) return;

  //   _isSubmitting = true;
  //   notifyListeners();

  //   try {
  //     final passengers = _controllers.map((c) {
  //       return PassengerModel(
  //         name: c['name']!.text.trim(),
  //         gender: c['gender']!.text.trim(),
  //         idNumber: c['id']!.text.trim(),
  //         age: int.parse(c['age']!.text.trim()),
  //       );
  //     }).toList();

  //     await _bookingService.submitBooking(
  //       packageId: _package!.id,
  //       userId: userId,
  //       passengers: passengers,
  //     );
  //   } finally {
  //     _isSubmitting = false;
  //     notifyListeners();
  //   }
  // }

  @override
  void dispose() {
    for (var passenger in _controllers) {
      for (var controller in passenger.values) {
        controller.dispose();
      }
    }
    super.dispose();
  }
}
