import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/company_model.dart';
import '../models/package_model.dart';

class CompanyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<CompanyModel>> getCompanies() {
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
