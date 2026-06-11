import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';

class DatePickerUtil {
  static Future<DateTime?> showFamzyDatePicker({
    required BuildContext context,
    // String? fieldLabelText,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    return await showDatePicker(
      context: context,
      // fieldLabelText: fieldLabelText ?? 'Datee',
      // barrierLabel: fieldLabelText ?? 'Dateen',
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
            textTheme: TextTheme(
              titleMedium: TextStyle(color: AppConstants.whiteColorP9),
            ),
            // textButtonTheme: TextButtonThemeData(
            //   style: TextButton.styleFrom(
            //     foregroundColor: AppConstants.famzyGold,
            //   ),
            // ),
            datePickerTheme: DatePickerThemeData(
              cancelButtonStyle: ButtonStyle(
                //
                // padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                //
                textStyle: WidgetStateProperty.all(
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
                foregroundColor: WidgetStateProperty.all(
                  AppConstants.whiteColorP9,
                ),
                backgroundColor: WidgetStateProperty.all(AppConstants.lightRed),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              confirmButtonStyle: ButtonStyle(
                textStyle: WidgetStateProperty.all(
                  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                ),
                backgroundColor: WidgetStateProperty.all(
                  AppConstants.lightGreen,
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                foregroundColor: WidgetStateProperty.all(
                  AppConstants.whiteColorP9,
                ),
              ),
              // years showing style
              yearStyle: TextStyle(
                color: AppConstants.whiteColorP7,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              //calender days style
              dayStyle: TextStyle(
                // color: AppConstants.lightRed,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              // headerHelpStyle: TextStyle(
              //   color: AppConstants.lightRed,
              //   fontSize: 14.sp,
              //   fontWeight: FontWeight.w400,
              // ),
              // dividerColor: AppConstants.lightRed,
              inputDecorationTheme: InputDecorationTheme(
                // hintStyle: TextStyle(
                //   color: AppConstants.whiteColorP7,
                //   fontSize: 14.sp,
                //   fontWeight: FontWeight.w400,
                // ),
                // labelStyle: TextStyle(
                //   color: AppConstants.whiteColorP7,
                //   fontSize: 14.sp,
                //   fontWeight: FontWeight.w400,
                // ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: BorderSide(
                    color: AppConstants.whiteColorP7,
                    width: 1.r,
                  ),
                ),
                // enabledBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(15.r),
                //   borderSide: BorderSide(
                //     color: AppConstants.whiteColorP9,
                //     width: 1.r,
                //   ),
                // ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: BorderSide(
                    color: AppConstants.whiteColorP9,
                    width: 1.r,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
                side: BorderSide(color: AppConstants.whiteColorP7, width: 1.w),
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
