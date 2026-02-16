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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class PackageModel {
  final String companyName;
  final String companyPhotoURL;
  final String id;
  final String packageName;
  final String duration; // e.g., "3 Days, 2 Nights"
  final String departureDate;
  final String departureTime;
  final String keySpots; // Stored as a comma-separated string
  final String vehicle; // e.g., "Toyota Hiace" or "4x4 Prado"
  final String description;
  final int price;
  final String destination; // The ID of the destination it belongs to
  final String packageCreatedAt;
  final String? packageEditedAt;
  // Coordinates for the map markers
  final double? latitude;
  final double? longitude;

  PackageModel({
    required this.companyName,
    required this.companyPhotoURL,
    required this.id,
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
    this.packageEditedAt,
    this.latitude,
    this.longitude,
  });

  // --- HELPER METHODS ---
  // --- MAP HELPER ---

  /// Returns a LatLng object if coordinates exist, otherwise returns null.
  /// Used directly in your FlutterMap MarkerLayer.
  LatLng? get spotsLatLng {
    if (latitude != null && longitude != null) {
      return LatLng(latitude!, longitude!);
    }
    return null;
  }

  DateTime get departureDateTime {
    try {
      // Assuming departureDate is "2024-05-20" and departureTime is "10:00 AM"
      debugPrint('***datedddddModel: $departureDate');
      final String dateTimeString = '$departureDate $departureTime';
      return DateFormat('yyyy-MM-dd h:mm a').parse(dateTimeString);
    } catch (e) {
      // Fallback in case of parsing error
      return DateTime.now().add(const Duration(days: 365));
    }
  }

  bool get isExpired {
    // Checks if the departure time has already passed
    return departureDateTime.isBefore(DateTime.now());
  }

  /// Converts the keySpots string into a List for UI bullet points
  List<String> get keySpotsList =>
      keySpots.split(',').map((e) => e.trim()).toList();

  /// Formatted price for display
  // String get formattedPrice => 'Rs. $price';
  String get formattedPrice {
    final formatter = NumberFormat('#,###');
    return 'Rs. ${formatter.format(price)}';
  }

  // --- DATA CONVERSION ---

  factory PackageModel.fromMap(Map<String, dynamic> map) {
    return PackageModel(
      id: map['id'] ?? '',
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
      packageCreatedAt: map['packageCreatedAt'] ?? '',
      packageEditedAt: map['packageEditedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'companyPhotoURL': companyPhotoURL,
      'id': id,
      'packageName': packageName,
      'duration': duration,
      'departureDate': departureDate,
      'departureTime': departureTime,
      'keySpots': keySpots,
      'vehicle': vehicle,
      'description': description,
      'price': price,
      'destination': destination,
      'packageCreatedAt': packageCreatedAt,
    };
  }
}
