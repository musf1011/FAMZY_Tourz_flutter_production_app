// created by: FAMZY CodeWorks

import 'package:famzy_tourz_v2/data/models/package_model.dart';
import 'package:famzy_tourz_v2/data/models/passenger_model.dart';
import 'package:famzy_tourz_v2/data/models/user_model.dart';
import 'package:famzy_tourz_v2/data/services/auth-services/firestor_user_service.dart';
import 'package:famzy_tourz_v2/data/services/packages-services/booking_services.dart';
import 'package:famzy_tourz_v2/data/services/packages-services/packages_service.dart';
import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  final BookingService _bookingService = BookingService();

  PackageModel? _package;
  PackageModel? get package => _package;

  int _seatCount = 1;
  int get seatCount => _seatCount;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  bool _alreadyBooked = false;
  bool get alreadyBooked => _alreadyBooked;

  bool _checkingBooking = false;
  bool get checkingBooking => _checkingBooking;

  final List<Map<String, TextEditingController>> _controllers = [];
  List<Map<String, TextEditingController>> get controllers => _controllers;
  // final FirestoreUserService _userService = FirestoreUserService();

  /// ================= SELECTION & INIT =================

  void selectPackage(PackageModel pkg, String userId) {
    debugPrint('*****select package func');
    _package = pkg;
    if (_package == null) return;
    if (_package!.isFull || _package!.isExpired) {
      _seatCount = 0;
    } else {
      _seatCount = 1;
    }
    _updateControllers();
    // check booking status
    checkIfAlreadyBooked(userId);
    notifyListeners();
  }

  void increaseSeat() {
    if (package == null) return;
    if (_seatCount < 5 &&
        !alreadyBooked &&
        _seatCount < _package!.availableSeats) {
      _seatCount++;
      _updateControllers();
      notifyListeners();
    }
  }

  void decreaseSeat() {
    if (_seatCount > 1 && !_alreadyBooked) {
      _seatCount--;
      _updateControllers();
      notifyListeners();
    }
  }

  void _updateControllers() {
    while (_controllers.length < _seatCount) {
      _controllers.add({
        'name': TextEditingController(),
        'gender': TextEditingController(),
        'idPassport': TextEditingController(),
        'age': TextEditingController(),
      });
    }
    while (_controllers.length > _seatCount) {
      final removed = _controllers.removeLast();
      for (var c in removed.values) {
        c.dispose();
      }
    }
  }

  bool _namePrefilled = false;
  bool _genderPrefilled = false;
  bool _agePrefiled = false;
  bool _idPassportPrefilled = false;

  bool get namePrefilled => _namePrefilled;
  bool get genderPrefilled => _genderPrefilled;
  bool get agePrefiled => _agePrefiled;
  bool get idPassportPrefilled => _idPassportPrefilled;
  void prefillFirstPassenger(AppUser? user) {
    if (user == null) return;
    if (_controllers.isEmpty) return;
    debugPrint(
      '****${user.age} and ${user.gender} and ${user.name} and ${user.userId} from prefill functon in booking provider',
    );

    final first = _controllers[0];

    if (first['name']!.text.isEmpty) {
      first['name']!.text = user.name;
      _namePrefilled = true;
    }

    if (first['gender']!.text.isEmpty) {
      first['gender']!.text = user.gender;
      _genderPrefilled = true;
    }

    if (first['age']!.text.isEmpty && user.age == 18) {
      first['age']!.text = user.age.toString();
      _agePrefiled = true;
    }

    if (first['idPassport']!.text.isEmpty && user.idPassport.isNotEmpty) {
      first['idPassport']!.text = user.idPassport;
    }
    notifyListeners();
  }

  /// ================= COMPUTED PROPERTIES =================
  int get totalPrice {
    if (_package == null) return 0;
    return _package!.price * _seatCount;
  }

  /// ================= SUBMISSION =================
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
  //         // Use tryParse to avoid crashes on empty/bad input
  //         age: int.tryParse(c['age']!.text.trim()) ?? 0,
  //       );
  //     }).toList();

  //     // await _bookingService.submitBooking(
  //     //   packageId: _package!.id,
  //     //   userId: userId,
  //     //   passengers: passengers,
  //     // );
  //   } catch (e) {
  //     debugPrint('Booking Error: $e');
  //     rethrow;
  //   } finally {
  //     _isSubmitting = false;
  //     notifyListeners();
  //   }
  // }
  Future<String?> submitBooking({required AppUser user}) async {
    debugPrint('****submit starteds');
    if (_package == null) return null;
    if (_alreadyBooked) {
      throw Exception('User already booked this package');
    }

    _isSubmitting = true;
    notifyListeners();

    debugPrint(
      '****submit started in submit booking function in booking provider ${_controllers[0]['idPassport']}',
    );
    try {
      final passengers = _controllers.map((c) {
        return PassengerModel(
          name: c['name']!.text.trim(),
          gender: c['gender']!.text.trim(),
          idNumber: c['idPassport']!.text.trim(),
          age: int.tryParse(c['age']!.text.trim()) ?? 0,
        );
      }).toList();
      // 2. Convert models to Maps INCLUDING the bookedBy ID
      // final passengerData = passengerModels.map((p) => p.toMap(user.userId)).toList();
      final bookingId =
          ('${user.name.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch.toString()}');
      debugPrint(
        '***** user id: ${user.userId} *** user name: ${user.name} *** and bookingId : $bookingId ***** user:::: $user',
      );
      await _bookingService.createBooking(
        bookingId: bookingId,
        package: _package!,
        user: user,
        seatCount: _seatCount,
        passengers: passengers,
        totalAmount: totalPrice,
      );

      // NEW: Save first passenger CNIC into user profile
      final firstPassengerId = _controllers[0]['idPassport']!.text.trim();
      debugPrint(
        '****submit done in submit booking function in booking provider ${_controllers[0]['idPassport']} now to save in user profile',
      );
      if (firstPassengerId.isNotEmpty && firstPassengerId != user.idPassport) {
        await FirestoreUserService.updateIdPassport(
          userId: user.userId,
          idPassport: firstPassengerId,
        );
        debugPrint(
          '****first passenger id is stored in user profile in submit booking function in booking provider ${_controllers[0]['idPassport']}',
        );
      }

      return bookingId;
    } catch (e) {
      debugPrint('*****Booking Error: $e');
      rethrow;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  Future<void> checkIfAlreadyBooked(String userId) async {
    if (_package == null) return;

    _checkingBooking = true;
    notifyListeners();

    try {
      _alreadyBooked = await _bookingService.hasUserBookedPackage(
        userId: userId,
        packageId: _package!.packageId,
      );
    } catch (e) {
      debugPrint('***Booking check error: $e');
      _alreadyBooked = false;
    } finally {
      _checkingBooking = false;
      notifyListeners();
    }
  }

  final PackagesService _packageService = PackagesService();

  Future<void> selectPackageById(String packageId, String userId) async {
    final pkg = await _packageService.getPackageById(packageId);

    debugPrint('*****package got$packageId');
    if (pkg == null) return;

    selectPackage(pkg, userId);
  }

  @override
  void dispose() {
    for (var passenger in _controllers) {
      for (var controller in passenger.values) {
        controller.dispose();
      }
    }
    _agePrefiled = false;
    _namePrefilled = false;
    _genderPrefilled = false;
    _idPassportPrefilled = false;
    super.dispose();
  }

  void clearBookingData() {
    // Dispose all existing controllers
    for (var passenger in _controllers) {
      for (var controller in passenger.values) {
        controller.dispose();
      }
    }
    _controllers.clear();

    // Reset state variables
    // _package = null;  // it caused error of null check as if user go back it not found any error
    _seatCount = 1;
    _alreadyBooked = false;

    // Reset prefilled flags
    _namePrefilled = false;
    _genderPrefilled = false;
    _agePrefiled = false;
    _idPassportPrefilled = false;

    // Initialize one fresh set of controllers for the next time
    _updateControllers();

    notifyListeners();
  }
}
