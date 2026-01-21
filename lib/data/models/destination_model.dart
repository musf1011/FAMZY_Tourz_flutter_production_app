// created by: FAMZY CodeWorks

class DestinationModel {
  final String id;
  final String name;
  final String image;
  final String shortHighlight; // catchy front text
  final String description; // expandable full text
  final double latitude;
  final double longitude;

  const DestinationModel({
    required this.id,
    required this.name,
    required this.image,
    required this.shortHighlight,
    required this.description,
    required this.latitude,
    required this.longitude,
  });
}
