import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadCompanyLogo(File file, String companyId) async {
    final ref = _storage.ref().child('company_logos').child('$companyId.jpg');

    await ref.putFile(file);

    return await ref.getDownloadURL();
  }
}
