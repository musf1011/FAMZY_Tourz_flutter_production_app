import 'package:famzy_tourz_v2/data/services/packages-services/booking_services.dart';
import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
  final BookingService _service = BookingService();

  final TextEditingController transactionController = TextEditingController();

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  Future<void> submitTransaction(String bookingId) async {
    final transactionId = transactionController.text.trim();

    if (transactionId.isEmpty) return;

    _isSubmitting = true;
    notifyListeners();

    try {
      await _service.submitTransaction(
        bookingId: bookingId,
        transactionId: transactionId,
      );

      transactionController.clear();
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    transactionController.dispose();
    super.dispose();
  }
}
