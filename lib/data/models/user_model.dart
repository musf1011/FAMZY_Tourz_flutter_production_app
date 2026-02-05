class AppUser {
  final String uid;
  final String name;
  final String email;
  final int age;
  final String gender;
  final String photoUrl;
  final DateTime createdAt;

  const AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.photoUrl,
    required this.createdAt,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      age: map['age'],
      gender: map['gender'],
      photoUrl: map['photoUrl'] ?? '',
      createdAt: map['createdAt']?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'age': age,
      'gender': gender,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
      'updatedAt': DateTime.now(),
    };
  }
}
