// import 'package:famzy_tourz_v2/data/models/booking_model.dart';
// import 'package:famzy_tourz_v2/data/services/packages-services/booking_services.dart';
// import 'package:flutter/material.dart';

// class AdminBookingsProvider extends ChangeNotifier {
//   final BookingService _service = BookingService();

//   List<BookingModel> _bookings = [];
//   List<BookingModel> get bookings => _bookings;

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   /// LOAD ALL BOOKINGS
//   Future<void> loadBookings() async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       _bookings = await _service.getAllBookings();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   /// APPROVE
//   Future<void> approve(String bookingId) async {
//     await _service.approvePayment(bookingId);
//     await loadBookings();
//   }

//   /// REJECT
//   Future<void> reject(String bookingId) async {
//     await _service.rejectPayment(bookingId);
//     await loadBookings();
//   }
// }
import 'package:famzy_tourz_v2/data/models/booking_model.dart';
import 'package:famzy_tourz_v2/data/services/packages-services/booking_services.dart';
import 'package:flutter/material.dart';

class AdminBookingsProvider extends ChangeNotifier {
  final BookingService _service = BookingService();

  List<BookingModel> _allBookings = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// FILTERED LISTS

  List<BookingModel> get submitted =>
      _allBookings.where((b) => b.paymentStatus == 'submitted').toList();

  List<BookingModel> get pending =>
      _allBookings.where((b) => b.paymentStatus == 'pending').toList();

  List<BookingModel> get paid =>
      _allBookings.where((b) => b.paymentStatus == 'paid').toList();

  List<BookingModel> get rejected =>
      _allBookings.where((b) => b.paymentStatus == 'rejected').toList();

  /// LOAD
  Future<void> loadBookings() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allBookings = await _service.getAllBookings();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// APPROVE
  Future<void> approve(String bookingId) async {
    await _service.approvePayment(bookingId);

    await loadBookings();
  }

  /// REJECT
  Future<void> reject(String bookingId) async {
    await _service.rejectPayment(bookingId);

    await loadBookings();
  }
}
