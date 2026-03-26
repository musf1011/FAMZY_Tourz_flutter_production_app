// created by: FAMZY CodeWorks

import 'dart:io';
import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatefulWidget {
  final Function(File?) onImageSelected;
  final String label;
  final double size;

  const CustomImagePicker({
    super.key,
    required this.onImageSelected,
    this.label = 'Upload Image',
    this.size = 120,
  });

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _showImageSourceDialog() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppConstants.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Image Source',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.white),
                title: const Text(
                  'Camera',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo, color: Colors.white),
                title: const Text(
                  'Gallery',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source, imageQuality: 75);

    if (picked != null) {
      final file = File(picked.path);

      final confirmed = await _showPreviewDialog(file);

      if (confirmed == true) {
        setState(() {
          _selectedImage = file;
        });

        widget.onImageSelected(file);
      }
    }
  }

  Future<bool?> _showPreviewDialog(File imageFile) {
    return showDialog<bool>(
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppConstants.primaryColor,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Confirm Image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.file(
                    imageFile,
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    // Expanded(
                    //   child: TextButton(
                    //     onPressed: () => Navigator.pop(context, false),

                    //     child: const Text(
                    //       'Cancel',
                    //       style: TextStyle(color: Colors.white70),
                    //     ),
                    //   ),
                    // ),
                    FamzyButton(
                      label: 'Cancel',
                      color: AppConstants.lightRed,
                      onPressed: () => Navigator.pop(context, false),
                      isExpanded: true,
                    ),
                    SizedBox(width: 10.w),
                    // Expanded(
                    //   child: ElevatedButton(
                    //     onPressed: () => Navigator.pop(context, true),
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: AppConstants.secondaryColor,
                    //     ),
                    //     child: const Text('Use Image'),
                    //   ),
                    // ),
                    FamzyButton(
                      label: 'Use Image',
                      color: AppConstants.tertiaryColor,
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _showImageSourceDialog,
          child: Container(
            height: widget.size.h,
            width: widget.size.w,
            decoration: BoxDecoration(
              color: AppConstants.secondaryColor,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: Colors.white24),
            ),
            child: _selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image.file(_selectedImage!, fit: BoxFit.cover),
                  )
                : Icon(Icons.add_a_photo, color: Colors.white70, size: 40.sp),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          widget.label,
          style: TextStyle(color: Colors.white70, fontSize: 12.sp),
        ),
      ],
    );
  }
}
