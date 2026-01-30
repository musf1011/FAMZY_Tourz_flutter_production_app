import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famzy_tourz_v2/data/models/package_model.dart';

class PackagesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchPackages(String destination) async {
    final snapshot = await _firestore
        .collection('tourPackages')
        .where('destination', isEqualTo: destination)
        .get();

    return snapshot.docs.map((doc) {
      return {...doc.data(), 'id': doc.id};
    }).toList();
  }

  Future<void> deletePackage(String id) async {
    await _firestore.collection('tourPackages').doc(id).delete();
  }

  Future<void> addPackage(PackageModel package) async {
    await _firestore
        .collection('tourPackages')
        .doc(package.id)
        .set(package.toMap(), SetOptions(merge: true));
  }
}
