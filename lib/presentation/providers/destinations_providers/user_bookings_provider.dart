import 'package:famzy_tourz_v2/data/models/booking_model.dart';
import 'package:famzy_tourz_v2/data/services/packages-services/booking_services.dart';
import 'package:flutter/material.dart';

class UserBookingsProvider extends ChangeNotifier {
  final BookingService _service = BookingService();

  List<BookingModel> _bookings = [];
  List<BookingModel> get bookings => _bookings;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadBookings(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // _bookings = await _service.getUserBookings(userId);
      final fetched = await _service.getUserBookings(userId);

      // Client-side sorting: nearest upcoming first (ascending)
      fetched.sort(
        (a, b) => a.departureDateTime.compareTo(b.departureDateTime),
      );

      _bookings = fetched;
    } catch (e) {
      debugPrint('Error loading bookings: $e');
      _bookings = [];
    } finally {
      debugPrint('*****$_bookings');
      _isLoading = false;
      debugPrint('*********finally booking provider: $_isLoading');
      notifyListeners();
    }
  }
}
