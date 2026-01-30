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

import 'package:latlong2/latlong.dart';

class PackageModel {
  final String id;
  final String packageName;
  final String duration; // e.g., "3 Days, 2 Nights"
  final String date;
  final String time;
  final String keySpots; // Stored as a comma-separated string
  final String vehicle; // e.g., "Toyota Hiace" or "4x4 Prado"
  final String description;
  final String price;
  final String destination; // The ID of the destination it belongs to
  // Coordinates for the map markers
  final double? latitude;
  final double? longitude;

  PackageModel({
    required this.id,
    required this.packageName,
    required this.duration,
    required this.date,
    required this.time,
    required this.keySpots,
    required this.vehicle,
    required this.description,
    required this.price,
    required this.destination,
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

  /// Converts the keySpots string into a List for UI bullet points
  List<String> get keySpotsList =>
      keySpots.split(',').map((e) => e.trim()).toList();

  /// Formatted price for display
  String get formattedPrice => 'Rs. $price';

  // --- DATA CONVERSION ---

  factory PackageModel.fromMap(Map<String, dynamic> map) {
    return PackageModel(
      id: map['id'] ?? '',
      packageName: map['packageName'] ?? '',
      duration: map['duration'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      keySpots: map['keySpots'] ?? '',
      vehicle: map['vehicle'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? '0',
      destination: map['destination'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'packageName': packageName,
      'duration': duration,
      'date': date,
      'time': time,
      'keySpots': keySpots,
      'vehicle': vehicle,
      'description': description,
      'price': price,
      'destination': destination,
    };
  }
}
