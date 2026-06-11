import 'dart:io';

import 'package:famzy_tourz_v2/data/services/navigation_service.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:famzy_tourz_v2/data/services/storage_service.dart';
import 'package:flutter/material.dart';
import '../../data/models/company_model.dart';
import '../../data/models/package_model.dart';
import '../../data/services/company_service.dart';

class CompanyProvider with ChangeNotifier {
  final CompanyService _companyService = CompanyService();

  final StorageService _storageService = StorageService();

  List<CompanyModel> _companies = [];
  List<PackageModel> _companyPackages = [];
  bool _isLoading = false;
  bool _isLoadingPackages = false;

  List<CompanyModel> get companies => _companies;
  List<PackageModel> get companyPackages => _companyPackages;
  bool get isLoading => _isLoading;
  bool get isLoadingPackages => _isLoadingPackages;

  void listenToActiveCompanies() {
    _companyService.getActiveCompanies().listen((companyList) {
      _companies = _companies + companyList;
      removeDuplicateCompanies();
      notifyListeners();
    });
  }

  void listenToInActiveCompanies() {
    _companyService.getInActiveCompanies().listen((companyList) {
      _companies = _companies + companyList;
      removeDuplicateCompanies();
      notifyListeners();
    });
  }

  // Future<void> addCompany(CompanyModel company) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     await _companyService.addCompany(company);
  //   } catch (e) {
  //     debugPrint('Error adding company: $e');
  //     rethrow;
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
  Future<void> addCompany(CompanyModel company, File? imageFile) async {
    _isLoading = true;
    notifyListeners();

    try {
      String imageUrl = '';

      if (imageFile != null) {
        imageUrl = await _storageService.uploadCompanyLogo(
          imageFile,
          company.companyId,
        );
      }

      final updatedCompany = CompanyModel(
        companyId: company.companyId,
        companyName: company.companyName,
        companyDescription: company.companyDescription,
        companyLogoUrl: imageUrl,
        phone: company.phone,
        email: company.email,
        website: company.website,
        isActive: company.isActive,
      );
      debugPrint(
        '****r*e*a*d*y to enter submit functrion image URL : $imageUrl',
      );
      await _companyService.addCompany(updatedCompany);
    } catch (e) {
      debugPrint('Error adding company: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateCompanyStatus(String companyId, bool isActive) async {
    try {
      await _companyService.updateCompanyStatus(companyId, isActive);
    } catch (e) {
      NavigationService().showSnackBar(
        message: 'Error updating company status: $e',
        title: 'Failed to update status',
        type: ContentType.failure,
      );
    }
  }

  void listenToCompanyPackages(String companyId) {
    _isLoadingPackages = true;
    // Don't notify here if it causes build issues during navigation, but usually fine

    _companyService.getPackagesByCompany(companyId).listen((packagesList) {
      _companyPackages = packagesList;
      _isLoadingPackages = false;
      notifyListeners();
    });
  }

  void removeDuplicateCompanies() {
    final Map<String, CompanyModel> uniqueCompaniesMap = {};

    for (var company in _companies) {
      uniqueCompaniesMap[company.companyId] = company;
    }

    _companies = uniqueCompaniesMap.values.toList();
  }
}
