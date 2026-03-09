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
    await _firestore
        .collection('tourPackages')
        .doc(package.packageId)
        .collection('bookings')
        .doc(bookingId)
        .set({
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

          'passengers': passengers
              .map((p) => p.toMap(user.idPassport))
              .toList(),

          'departureDate': package.departureDate,
          'departureTime': package.departureTime,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
  }

  /// GET USER BOOKINGS
  Future<List<BookingModel>> getUserBookings(String userId) async {
    final snapshot = await _firestore
        // .collection('bookings')
        .collectionGroup('bookings') //for searching everwhere in the firestore
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

  // //get all bookings for admin
  // Future<List<BookingModel>> getAllBookings() async {
  //   final snapshot = await _firestore
  //       .collection('bookings')
  //       .orderBy('createdAt', descending: true)
  //       .get();

  //   return snapshot.docs
  //       .map((doc) => BookingModel.fromMap(doc.data()))
  //       .toList();
  // }
  /// REALTIME ADMIN BOOKINGS STREAM
  Stream<List<BookingModel>> streamAllBookings() {
    return _firestore
        .collection('bookings')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BookingModel.fromMap(doc.data()))
              .toList(),
        );
  }

  // //admin approve payment
  // Future<void> approvePayment(String bookingId) async {
  //   await _firestore.collection('bookings').doc(bookingId).update({
  //     'paymentStatus': 'paid',
  //     'updatedAt': FieldValue.serverTimestamp(),
  //   });
  // }

  Future<void> approvePayment(String bookingId) async {
    final bookingRef = _firestore.collection('bookings').doc(bookingId);

    await _firestore.runTransaction((transaction) async {
      final bookingSnapshot = await transaction.get(bookingRef);

      if (!bookingSnapshot.exists) {
        throw Exception('Booking record not found');
      }

      final bookingData = bookingSnapshot.data()!;
      final String packageId = bookingData['packageId'];
      final int seatCount = bookingData['seatCount'] ?? 1;
      final String currentStatus = bookingData['paymentStatus'];

      //to prevent double approval
      if (currentStatus == 'paid') {
        return;
      }

      final packageRef = _firestore.collection('tourPackages').doc(packageId);

      final packageSnapshot = await transaction.get(packageRef);

      if (!packageSnapshot.exists) {
        throw Exception('Package record not found');
      }
      final packageData = packageSnapshot.data()!;
      // final int currentBooked = (packageSnapshot.data()?['seatBooked'] ?? 0);
      final int currentBooked = packageData['seatBooked'] ?? 0;
      final int totalSeats = packageData['totalSeats'] ?? 0;

      /// 🚨 OVERBOOKING PROTECTION
      if (currentBooked + seatCount > totalSeats) {
        final int available = totalSeats - currentBooked;
        // This message will be caught by your Provider and shown in the SnackBar
        throw 'Overbooked! Only $available seats left, but this booking needs $seatCount.';
      }

      /// 1️⃣ Increase seatBooked
      transaction.update(packageRef, {'seatBooked': currentBooked + seatCount});

      /// 2️⃣ Update payment status
      transaction.update(bookingRef, {
        'paymentStatus': 'paid',
        'updatedAt': FieldValue.serverTimestamp(),
      });
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
