import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/company_model.dart';
import '../models/package_model.dart';

class CompanyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<CompanyModel>> getActiveCompanies() {
    return _firestore
        .collection('companies')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CompanyModel.fromFirestore(doc.data()))
              .toList(),
        );
  }

  Stream<List<CompanyModel>> getInActiveCompanies() {
    return _firestore
        .collection('companies')
        .where('isActive', isEqualTo: false)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CompanyModel.fromFirestore(doc.data()))
              .toList(),
        );
  }

  Future<CompanyModel?> getCompanyById(String companyId) async {
    final doc = await _firestore.collection('companies').doc(companyId).get();

    if (!doc.exists) return null;

    return CompanyModel.fromFirestore(doc.data()!);
  }

  Future<void> addCompany(CompanyModel company) async {
    await _firestore
        .collection('companies')
        .doc(company.companyId)
        .set(company.toMap());
  }

  Future<void> updateCompanyStatus(String companyId, bool isActive) async {
    try {
      await _firestore.collection('companies').doc(companyId).update({
        'isActive': isActive,
      });
    } catch (e) {
      throw Exception('Error updating company status: $e');
    }
  }

  Stream<List<PackageModel>> getPackagesByCompany(String companyId) {
    return _firestore
        .collection('tourPackages')
        .where('companyId', isEqualTo: companyId)
        // You might want to filter by date/availability too
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => PackageModel.fromMap(doc.data()))
              .toList(),
        );
  }
}
