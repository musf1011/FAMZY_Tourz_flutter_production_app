import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// A class to hold all global constants for the project.
// The private constructor `_()` prevents instantiation of this utility class.
class AppConstants {
  AppConstants._(); // Private constructor

  // --- Colors ---
  static const Color primaryColor = Color.fromARGB(255, 0, 57, 2);
  static const Color secondaryColor = Color.fromARGB(150, 0, 100, 0);
  static const Color tertiaryColor = Color.fromARGB(150, 0, 200, 0);
  static const Color primaryTransGColor = Color.fromARGB(150, 0, 30, 0);
  static const Color secondaryTransGColor = Color.fromARGB(225, 0, 30, 0);
  static const Color lightGreen = Color.fromARGB(150, 100, 200, 100);
  static const Color lightRed = Color.fromARGB(150, 255, 40, 30);
  static const Color transRColor = Color.fromARGB(155, 255, 155, 155);
  static const Color underline = Color.fromARGB(255, 180, 150, 30);
  // Using getters instead of static variables for dynamic colors (as it first need to fully initialize before assigning it)
  static Color get blackColorP7 => Colors.black.withAlpha((255 * 0.7).round());
  static Color get blackColorP5 => Colors.black.withAlpha((255 * 0.5).round());
  static Color get blackColorP3 => Colors.black.withAlpha((255 * 0.3).round());
  static Color get whiteColorP9 => Colors.white.withAlpha((255 * 0.9).round());
  static Color get whiteColorP5 => Colors.white.withAlpha((255 * 0.5).round());

  // --- Auth UI Colors ---
  static const Color authBgColor = Color(0xFFF5F5F5);
  static const Color authCardColor = Colors.white;
  static const Color googleBlue = Color(0xFF4285F4);

  static const Color accentColor = Colors.lightBlueAccent;
  static const Color textColor = Colors.black87;
  static const Color errorColor = Colors.red;

  // --- Specific Text Styles (from your example) ---
  static TextStyle appBarTextStyle = GoogleFonts.playfairDisplay(
    fontWeight: FontWeight.bold,
    fontSize: 25.sp,
    wordSpacing: 5,
    color: Colors.white,
  );
  static TextStyle screenTitleTextStyle = GoogleFonts.playfairDisplay(
    fontSize: 40.sp,
    fontWeight: FontWeight.bold,
    color: AppConstants.primaryColor,
  );

  static final ThemeData customSelectionTheme = ThemeData.light().copyWith(
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: tertiaryColor,
      selectionHandleColor: secondaryColor,
      cursorColor: secondaryColor,
    ),
  );
  //common button style
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    minimumSize: Size(double.infinity, 50.h),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
  );
  //google button style
  static ButtonStyle googleButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    minimumSize: Size(double.infinity, 50.h),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    side: const BorderSide(color: Colors.black12),
  );

  static const TextStyle sendButtonTextStyle = TextStyle(
    color: AppConstants.accentColor,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  //auth cards style
  static BoxDecoration glassCardDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(15.r),
    color: AppConstants.primaryTransGColor,
    border: Border.all(color: Colors.white, width: .5.w),
  );

  static final elevatedButtonTextStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 22.sp,
    fontWeight: FontWeight.lerp(FontWeight.w500, FontWeight.w600, 0.5),
  );
  //snackbar title
  static final TextStyle snackbarTitle = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  //snackbar message
  static final TextStyle snackbarMessage = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppConstants.whiteColorP9,
  );
}
