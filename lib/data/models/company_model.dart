class CompanyModel {
  final String companyId;
  final String companyName;
  final String companyDescription;
  final String? companyLogoUrl;
  final String phone;
  final String email;
  final String website;
  final bool isActive;

  CompanyModel({
    required this.companyId,
    required this.companyName,
    required this.companyDescription,
    this.companyLogoUrl,
    required this.phone,
    required this.email,
    required this.website,
    required this.isActive,
  });

  factory CompanyModel.fromFirestore(Map<String, dynamic> data) {
    return CompanyModel(
      companyId: data['companyId'] ?? '',
      companyName: data['companyName'] ?? '',
      companyDescription: data['companyDescription'] ?? '',
      companyLogoUrl: data['companyLogoUrl'] ?? '',
      phone: data['phone'] ?? '',
      email: data['email'] ?? '',
      website: data['website'] ?? '',
      isActive: data['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'companyId': companyId,
      'companyName': companyName,
      'companyDescription': companyDescription,
      'companyLogoUrl': companyLogoUrl,
      'phone': phone,
      'email': email,
      'website': website,
      'isActive': isActive,
    };
  }
}
