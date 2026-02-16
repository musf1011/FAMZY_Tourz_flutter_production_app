import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famzy_tourz_v2/data/models/passenger_model.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> submitBooking({
    required String packageId,
    required String userId,
    required List<PassengerModel> passengers,
  }) async {
    final batch = _firestore.batch();

    for (final passenger in passengers) {
      final docRef = _firestore
          .collection('packages')
          .doc(packageId)
          .collection('passengersDetails')
          .doc(passenger.idNumber);

      batch.set(docRef, passenger.toMap(userId));
    }

    await batch.commit();
  }
}
