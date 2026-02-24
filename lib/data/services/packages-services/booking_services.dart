// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:famzy_tourz_v2/data/models/passenger_model.dart';

// class BookingService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> submitBooking({
//     required String packageId,
//     required String userId,
//     required List<PassengerModel> passengers,
//   }) async {
//     final batch = _firestore.batch();

//     for (final passenger in passengers) {
//       final docRef = _firestore
//           .collection('packages')
//           .doc(packageId)
//           .collection('passengersDetails')
//           .doc(passenger.idNumber);

//       batch.set(docRef, passenger.toMap(userId));
//     }

//     await batch.commit();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famzy_tourz_v2/data/models/package_model.dart';
import 'package:famzy_tourz_v2/data/models/passenger_model.dart';
import 'package:famzy_tourz_v2/data/models/user_model.dart';
import 'package:flutter/foundation.dart';
import '../../models/booking_model.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // /// CREATE BOOKING (pending payment)
  // Future<String> createBooking(BookingModel booking) async {
  //   await _firestore
  //       .collection('bookings')
  //       .doc(booking.bookingId)
  //       .set(booking.toMap());

  //   return booking.bookingId;
  // }

  Future<void> createBooking({
    required String bookingId,
    required PackageModel package,
    required AppUser user,
    required int seatCount,
    required List<PassengerModel> passengers,
    required int totalAmount,
  }) async {
    await _firestore.collection('bookings').doc(bookingId).set({
      'bookingId': bookingId,
      'packageId': package.packageId,
      'packageName': package.packageName,
      'destinationName': package.destination,
      'companyName': package.companyName,

      'userId': user.userId,
      'userName': user.name,

      'seatCount': seatCount,
      'totalAmount': totalAmount,

      'paymentMethod': 'nayapay',
      'transactionId': '',
      'paymentStatus': 'pending',

      'passengers': passengers.map((p) => p.toMap(user.idPassport)).toList(),

      'departureDate': package.departureDate,
      'departureTime': package.departureTime,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// GET USER BOOKINGS
  Future<List<BookingModel>> getUserBookings(String userId) async {
    final snapshot = await _firestore
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .orderBy('departureDate', descending: true)
        .get();
    debugPrint(
      '*****${snapshot.docs.map((doc) => BookingModel.fromMap(doc.data())).first}',
    );
    return snapshot.docs
        .map((doc) => BookingModel.fromMap(doc.data()))
        .toList();
  }

  /// SUBMIT TRANSACTION ID
  Future<void> submitTransaction({
    required String bookingId,
    required String transactionId,
  }) async {
    await _firestore.collection('bookings').doc(bookingId).update({
      'transactionId': transactionId,
      'paymentStatus': 'submitted',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// CHECK if user already booked this package
  Future<bool> hasUserBookedPackage({
    required String userId,
    required String packageId,
  }) async {
    final snapshot = await _firestore
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .where('packageId', isEqualTo: packageId)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  //get all bookings for admin
  Future<List<BookingModel>> getAllBookings() async {
    final snapshot = await _firestore
        .collection('bookings')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => BookingModel.fromMap(doc.data()))
        .toList();
  }

  //admin approve payment
  Future<void> approvePayment(String bookingId) async {
    await _firestore.collection('bookings').doc(bookingId).update({
      'paymentStatus': 'paid',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  //admin reject payment
  Future<void> rejectPayment(String bookingId) async {
    await _firestore.collection('bookings').doc(bookingId).update({
      'paymentStatus': 'rejected',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
