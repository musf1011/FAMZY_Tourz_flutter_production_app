//created by: FAMZY Tourz
class PassengerModel {
  final String name;
  final String gender;
  final String idNumber;
  final int age;

  PassengerModel({
    required this.name,
    required this.gender,
    required this.idNumber,
    required this.age,
  });

  Map<String, dynamic> toMap(String bookedBy) {
    return {
      'name': name,
      'gender': gender,
      'idNumber': idNumber,
      'age': age,
      'bookedBy': bookedBy,
      // 'timestamp': FieldValue.serverTimestamp(),
    };
  }
}
