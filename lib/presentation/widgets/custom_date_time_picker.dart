import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';

class DatePickerUtil {
  static Future<DateTime?> showFamzyDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppConstants.famzyGold,
              onPrimary: Colors.white,
              surface: AppConstants.secondaryColor,
              onSurface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppConstants.famzyGold,
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.r),
                side: BorderSide(color: Colors.white, width: 2.r),
              ),
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: AppConstants.primaryTransGColor,
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
