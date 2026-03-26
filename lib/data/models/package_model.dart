// class PackageModel {
//   final String id;
//   final String packageName;
//   final String duration;
//   final String date;
//   final String time;
//   final String keySpots;
//   final String vehicle;
//   final String description;
//   final String price;
//   final String destination;

//   PackageModel({
//     required this.id,
//     required this.packageName,
//     required this.duration,
//     required this.date,
//     required this.time,
//     required this.keySpots,
//     required this.vehicle,
//     required this.description,
//     required this.price,
//     required this.destination,
//   });

//   factory PackageModel.fromMap(Map<String, dynamic> map) {
//     return PackageModel(
//       id: map['id'],
//       packageName: map['packageName'],
//       duration: map['duration'],
//       date: map['date'],
//       time: map['time'],
//       keySpots: map['keySpots'],
//       vehicle: map['vehicle'],
//       description: map['description'],
//       price: map['price'],
//       destination: map['destination'],
//     );
//   }
// }

import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class PackageModel {
  final String companyId;
  final String companyName;
  final String companyPhotoURL;
  final String packageId;
  final String packageName;
  final String duration;
  final String departureDate;
  final String departureTime;
  final String keySpots;
  final String vehicle;
  final String description;
  final int price;
  final String destination;
  final String packageCreatedAt;
  final String? packageEditedAt;
  final int totalSeats;
  final int seatBooked;
  // Coordinates for the map markers
  final double? latitude;
  final double? longitude;

  PackageModel({
    required this.companyId,
    required this.companyName,
    required this.companyPhotoURL,
    required this.packageId,
    required this.packageName,
    required this.duration,
    required this.departureDate,
    required this.departureTime,
    required this.keySpots,
    required this.vehicle,
    required this.description,
    required this.price,
    required this.destination,
    required this.packageCreatedAt,
    required this.totalSeats,
    required this.seatBooked,
    this.packageEditedAt,
    this.latitude,
    this.longitude,
  });

  LatLng? get spotsLatLng {
    if (latitude != null && longitude != null) {
      return LatLng(latitude!, longitude!);
    }
    return null;
  }

  DateTime get departureDateTime {
    try {
      // debugPrint('***datedddddModel: $departureDate');
      final String dateTimeString = '$departureDate $departureTime';
      return DateFormat('yyyy-MM-dd h:mm a').parse(dateTimeString);
    } catch (e) {
      return DateTime.now().add(const Duration(days: 365));
    }
  }

  bool get isExpired {
    return departureDateTime.isBefore(DateTime.now());
  }

  List<String> get keySpotsList =>
      keySpots.split(',').map((e) => e.trim()).toList();

  String get formattedPrice {
    final formatter = NumberFormat('#,###');
    return 'Rs. ${formatter.format(price)}';
  }

  /// =======================
  /// 🎫 SEAT LOGIC
  /// =======================

  int get availableSeats => totalSeats - seatBooked;

  bool get isFull => availableSeats <= 0;

  factory PackageModel.fromMap(Map<String, dynamic> map) {
    return PackageModel(
      packageId: map['packageId'] ?? '',
      companyId: map['companyId'] ?? '',
      companyPhotoURL: map['companyPhotoURL'] ?? '',
      companyName: map['companyName'] ?? '',
      packageName: map['packageName'] ?? '',
      duration: map['duration'] ?? '',
      departureDate: map['departureDate'] ?? '',
      departureTime: map['departureTime'] ?? '',
      keySpots: map['keySpots'] ?? '',
      vehicle: map['vehicle'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] as num?)?.toInt() ?? 0,
      destination: map['destination'] ?? '',
      totalSeats: map['totalSeats'] ?? 0,
      seatBooked: map['seatBooked'] ?? 0,
      packageCreatedAt: map['packageCreatedAt'] ?? '',
      packageEditedAt: map['packageEditedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'companyId': companyId,
      'companyName': companyName,
      'companyPhotoURL': companyPhotoURL,
      'packageId': packageId,
      'packageName': packageName,
      'duration': duration,
      'departureDate': departureDate,
      'departureTime': departureTime,
      'keySpots': keySpots,
      'vehicle': vehicle,
      'description': description,
      'price': price,
      'seatBooked': seatBooked,
      'totalSeats': totalSeats,
      'destination': destination,
      'packageCreatedAt': packageCreatedAt,
    };
  }
}
