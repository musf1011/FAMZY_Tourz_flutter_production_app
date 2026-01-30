import 'package:famzy_tourz_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderDropdownField extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;

  const GenderDropdownField({
    super.key,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      validator: validator,
      onChanged: onChanged,
      borderRadius: BorderRadius.circular(15.r),
      dropdownColor: AppConstants.primaryTransGColor,
      iconEnabledColor: AppConstants.tertiaryColor,
      decoration: InputDecoration(
        label: const Text('Gender', style: TextStyle(color: Colors.white)),
        hint: Text(
          'Not Selected',
          style: TextStyle(color: AppConstants.whiteColorP5),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppConstants.tertiaryColor),
        ),
      ),
      items: const [
        DropdownMenuItem(
          value: 'male',
          child: Text(
            'Male',
            style: TextStyle(color: AppConstants.accentColor),
          ),
        ),
        DropdownMenuItem(
          value: 'female',
          child: Text('Female', style: TextStyle(color: Colors.pinkAccent)),
        ),
        DropdownMenuItem(
          value: 'other',
          child: Text('Other', style: TextStyle(color: Colors.yellowAccent)),
        ),
      ],
    );
  }
}
