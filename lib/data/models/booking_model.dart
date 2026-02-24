import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BookingModel {
  final String bookingId;
  final String packageId;
  final String packageName;
  final String destinationName;
  final String companyName;

  final String userId;
  final String userName;

  final int seatCount;
  final int totalAmount;

  final String paymentMethod;
  final String transactionId;
  final String paymentStatus;

  final String departureDate;
  final String departureTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BookingModel({
    required this.bookingId,
    required this.packageId,
    required this.packageName,
    required this.destinationName,
    required this.companyName,
    required this.userId,
    required this.userName,
    required this.seatCount,
    required this.totalAmount,
    required this.paymentMethod,
    required this.transactionId,
    required this.paymentStatus,
    required this.departureDate,
    required this.departureTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      bookingId: map['bookingId'],
      packageId: map['packageId'],
      packageName: map['packageName'],
      destinationName: map['destinationName'],
      companyName: map['companyName'],
      userId: map['userId'],
      userName: map['userName'],
      seatCount: map['seatCount'],
      totalAmount: map['totalAmount'],
      paymentMethod: map['paymentMethod'],
      transactionId: map['transactionId'] ?? '',
      paymentStatus: map['paymentStatus'],
      departureDate: map['departureDate'] ?? '',
      departureTime: map['departureTime'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'packageId': packageId,
      'packageName': packageName,
      'destinationName': destinationName,
      'companyName': companyName,
      'userId': userId,
      'userName': userName,
      'seatCount': seatCount,
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'transactionId': transactionId,
      'paymentStatus': paymentStatus,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  /// Try to produce a DateTime object for departure; fallback to distant future if parsing fails.
  // DateTime get departureDateTime {
  //   try {
  //     final String dt = '$departureDate $departureTime';
  //     return DateFormat('yyyy-MM-dd h:mm a').parse(dt);
  //   } catch (_) {
  //     // If parsing fails, return a very far date so it sorts last
  //     return DateTime.now().add(const Duration(days: 365 * 10));
  //   }
  // }

  // /// Friendly formatted label
  // String get formattedDeparture {
  //   try {
  //     final dt = departureDateTime;
  //     return DateFormat('dd MMM yyyy, h:mm a').format(dt);
  //   } catch (_) {
  //     return '$departureDate $departureTime';
  //   }
  // }

  /// Combined DateTime object for sorting and logical checks
  DateTime get departureDateTime {
    try {
      // Combines "2026-02-28" and "12:00 PM"
      final String dt = '$departureDate $departureTime';
      return DateFormat('yyyy-MM-dd h:mm a').parse(dt);
    } catch (_) {
      return DateTime.now().add(const Duration(days: 3650));
    }
  }

  /// String for the RichText value
  String get formattedDeparture {
    try {
      final dt = departureDateTime;
      // Returns "28 Feb 2026 at 12:00 PM"
      return '${DateFormat('dd MMM yyyy').format(dt)} at $departureTime';
    } catch (_) {
      return '$departureDate $departureTime';
    }
  }
}
