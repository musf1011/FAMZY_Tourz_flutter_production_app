import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famzy_tourz_v2/data/models/package_model.dart';

class PackagesService {
  final tourPackagesCollection = 'tourPackages';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchPackages(String destination) async {
    final snapshot = await _firestore
        .collection(tourPackagesCollection)
        .where('destination', isEqualTo: destination)
        .get();

    return snapshot.docs.map((doc) {
      return {...doc.data(), 'packageId': doc.id}; ///////**** */
    }).toList();
  }

  Future<void> deletePackage(String id) async {
    await _firestore.collection(tourPackagesCollection).doc(id).delete();
  }

  Future<void> addPackage(PackageModel package) async {
    await _firestore
        .collection(tourPackagesCollection)
        .doc(package.packageId)
        .set(package.toMap(), SetOptions(merge: true));
  }

  Future<void> updatePackage(PackageModel package) async {
    await _firestore
        .collection(tourPackagesCollection)
        .doc(package.packageId)
        .update(
          package.toMap()
            ..['packageEditedAt'] = DateTime.now().toIso8601String(),
        );
  }

  Future<PackageModel?> getPackageById(String packageId) async {
    final doc = await FirebaseFirestore.instance
        .collection(tourPackagesCollection)
        .doc(packageId)
        .get();

    if (!doc.exists) return null;

    return PackageModel.fromMap(doc.data()!);
  }
}
