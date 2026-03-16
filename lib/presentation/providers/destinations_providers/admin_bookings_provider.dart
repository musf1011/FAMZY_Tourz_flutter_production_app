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
import 'dart:async';

import 'package:famzy_tourz_v2/data/models/booking_model.dart';
import 'package:famzy_tourz_v2/data/services/packages-services/booking_services.dart';
import 'package:famzy_tourz_v2/presentation/widgets/famzy_snackbar.dart';
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

  List<BookingModel> get resubmit =>
      _allBookings.where((b) => b.paymentStatus == 'resubmit').toList();

  StreamSubscription? _subscription;

  /// START REALTIME LISTENER
  void startListening() {
    _subscription = _service.streamAllBookings().listen((bookings) {
      _allBookings = bookings;

      _isLoading = false;
      debugPrint(
        '*********bookings list in startlistening funct in admin booking provider: ${_allBookings.first}',
      );
      notifyListeners();
    });
  }

  // /// APPROVE
  // Future<void> approve(String bookingId) async {
  //   await _service.approvePayment(bookingId);
  // }
  /// APPROVE PAYMENT
  Future<void> approve(
    BuildContext context,
    String bookingId,
    String packageId,
  ) async {
    try {
      // 1. You might have a loading state to show a spinner on the admin side
      // _setLoading(true);

      await _service.approvePayment(bookingId, packageId);

      // 2. Success Feedback
      if (context.mounted) {
        FamzySnackBar.show(
          context,
          title: 'Payment Approved',
          message: 'The booking is now confirmed and seats are reserved.',
          status: SnackBarStatus.success,
        );
      }
    } catch (e) {
      // 3. Error Handling using your custom logic
      if (context.mounted) {
        final String errorMsg = e.toString().replaceAll('Exception: ', '');

        // Customizing the look for Overbooking specifically
        final bool isOverbooked = errorMsg.contains(
          'Not enough seats available',
        );

        FamzySnackBar.show(
          context,
          title: isOverbooked ? 'Booking Full' : 'Approval Error',
          message: errorMsg,
          status: isOverbooked ? SnackBarStatus.warning : SnackBarStatus.error,
        );
      }
    } finally {
      // _setLoading(false);
      notifyListeners();
    }
  }

  /// REJECT
  Future<void> reject(
    String bookingId,
    String packageId,
    bool permanentRejected,
  ) async {
    if (permanentRejected) {
      await _service.rejectPaymentPermanently(bookingId, packageId);
    } else {
      await _service.rejectPaymentResubmission(bookingId, packageId);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
