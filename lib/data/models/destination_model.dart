// created by: FAMZY CodeWorks

class DestinationModel {
  // final String id;
  final String name;
  final String image;
  final String shortDescription; // catchy front text
  final String fullDescription; // expandable full text
  final double latitude;
  final double longitude;
  final String insights;

  const DestinationModel({
    // required this.id,
    required this.name,
    required this.image,
    required this.shortDescription,
    required this.fullDescription,
    required this.latitude,
    required this.longitude,
    required this.insights,
  });
}
