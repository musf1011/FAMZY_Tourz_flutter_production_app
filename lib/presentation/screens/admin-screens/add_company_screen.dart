import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/models/company_model.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/presentation/providers/company_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/back_logo_row.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_background_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_glass_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_image_picker.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_text_form_field.dart';
import 'package:famzy_tourz_v2/presentation/widgets/famzy_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({super.key});

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  File? _selectedImage;
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();
  bool _isActive = true;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final companyProvider = context.read<CompanyProvider>();

      final newCompany = CompanyModel(
        companyId: FirebaseFirestore.instance.collection('companies').doc().id,
        companyName: _nameController.text.trim(),
        companyDescription: _descController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        website: _websiteController.text.trim(),
        isActive: _isActive,
      );

      try {
        await companyProvider.addCompany(newCompany, _selectedImage);
        debugPrint('*******submit doneeee ***************');
        if (mounted) {
          FamzySnackBar.show(
            context,
            title: 'Success',
            message: 'Company added successfully!',
            status: SnackBarStatus.success,
          );
          NavigationService().pop();
        }
      } catch (e) {
        if (mounted) {
          // ScaffoldMessenger.of(
          //   context,
          // ).showSnackBar(SnackBar(content: Text('Failed to add company: $e')));
          FamzySnackBar.show(
            context,
            title: 'Error',
            message: 'Failed to add company: $e',
            status: SnackBarStatus.error,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<CompanyProvider>().isLoading;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Add Company'),
      //   backgroundColor: AppConstants.primaryColor,
      // ),
      body: CustomBackgroundWrapper(
        imagePath: AppConstants.appBgImage,

        child: SingleChildScrollView(
          // padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const BackAndLogoRow(navigateToWelcomeScreen: false),
                Text('Add Company', style: AppConstants.screenTitleTextStyle),
                CustomGlassWrapper(
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      CustomImagePicker(
                        label: 'Company Logo',
                        onImageSelected: (file) {
                          _selectedImage = file;
                        },
                      ),
                      CustTextFormField(
                        hint: 'Company Name',
                        label: 'Company Name',
                        controller: _nameController,
                        validator: (val) => val != null && val.isEmpty
                            ? 'Can\'t be empty'
                            : null,
                      ),
                      SizedBox(height: 10.h),
                      CustTextFormField(
                        hint: 'Description',
                        label: 'Description',
                        controller: _descController,
                        maxLines: 3,
                        validator: (val) => val != null && val.isEmpty
                            ? 'Can\'t be empty'
                            : null,
                      ),
                      SizedBox(height: 10.h),

                      SizedBox(height: 10.h),
                      CustTextFormField(
                        controller: _phoneController,
                        label: 'Phone Number',
                        hint: '+2348000000000',
                        keyboardType: TextInputType.phone,
                        validator: (val) => val != null && val.isEmpty
                            ? 'Can\'t be empty'
                            : null,
                      ),
                      SizedBox(height: 10.h),
                      CustTextFormField(
                        controller: _emailController,
                        label: 'Email',
                        hint: 'email@example.com',
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) => val != null && val.isEmpty
                            ? 'Can\'t be empty'
                            : null,
                      ),
                      SizedBox(height: 10.h),

                      CustTextFormField(
                        label: 'Website Url',
                        hint: 'www.company.com',
                        controller: _websiteController,
                      ),
                      SizedBox(height: 10.h),
                      SwitchListTile(
                        title: const Text(
                          'Company Is Active',
                          style: TextStyle(color: Colors.white),
                        ),
                        value: _isActive,
                        activeThumbColor: AppConstants.tertiaryColor,
                        activeTrackColor: AppConstants.secondaryColor,
                        inactiveThumbColor: AppConstants.transGrey,
                        inactiveTrackColor: AppConstants.transGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          side: BorderSide(
                            color: AppConstants.tertiaryColor,
                            width: 1.w,
                          ),
                        ),
                        onChanged: (val) => setState(() => _isActive = val),
                      ),
                      SizedBox(height: 20.h),

                      // isLoading
                      //     ? const CircularProgressIndicator()
                      //     : ElevatedButton(
                      //         onPressed: _submit,
                      //         style: ElevatedButton.styleFrom(
                      //           backgroundColor: AppConstants.primaryColor,
                      //           minimumSize: Size(double.infinity, 50.h),
                      //         ),
                      //         child: const Text('Add Company'),
                      //       ),
                    ],
                  ),
                ),
                CustomLoadingButton(
                  onPressed: () {
                    if (_selectedImage == null) {
                      FamzySnackBar.show(
                        context,
                        title: 'Select Image',
                        message: 'Select image to proceed',
                        status: SnackBarStatus.error,
                      );
                      return;
                    }

                    _submit();
                  },
                  isLoading: isLoading,
                  text: 'Add Company',
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
