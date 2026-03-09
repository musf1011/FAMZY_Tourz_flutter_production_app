// // // import 'package:flutter/services.dart';

// // // class CNICInputFormatter extends TextInputFormatter {
// // //   @override
// // //   TextEditingValue formatEditUpdate(
// // //     TextEditingValue oldValue,
// // //     TextEditingValue newValue,
// // //   ) {
// // //     // Remove all non-digits
// // //     String digits = newValue.text.replaceAll(RegExp(r'\D'), '');

// // //     // Limit to 13 digits
// // //     if (digits.length > 13) {
// // //       digits = digits.substring(0, 13);
// // //     }

// // //     String formatted = '';

// // //     for (int i = 0; i < digits.length; i++) {
// // //       if (i == 5 || i == 12) {
// // //         formatted += '-';
// // //       }
// // //       formatted += digits[i];
// // //     }

// // //     return TextEditingValue(
// // //       text: formatted,
// // //       selection: TextSelection.collapsed(offset: formatted.length),
// // //     );
// // //   }
// // // }
// // // import 'package:flutter/services.dart';

// // // class IdInputFormatter extends TextInputFormatter {
// // //   @override
// // //   TextEditingValue formatEditUpdate(
// // //     TextEditingValue oldValue,
// // //     TextEditingValue newValue,
// // //   ) {
// // //     final String text = newValue.text;

// // //     // If user types any letter → treat as passport (no formatting)
// // //     if (RegExp(r'[A-Za-z]').hasMatch(text)) {
// // //       return newValue;
// // //     }

// // //     // Otherwise treat as CNIC (digits only)
// // //     String digits = text.replaceAll(RegExp(r'\D'), '');

// // //     if (digits.length > 13) {
// // //       digits = digits.substring(0, 13);
// // //     }

// // //     String formatted = '';

// // //     for (int i = 0; i < digits.length; i++) {
// // //       if (i == 5 || i == 12) {
// // //         formatted += '-';
// // //       }
// // //       formatted += digits[i];
// // //     }

// // //     return TextEditingValue(
// // //       text: formatted,
// // //       selection: TextSelection.collapsed(offset: formatted.length),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/services.dart';

// // class IdInputFormatter extends TextInputFormatter {
// //   @override
// //   TextEditingValue formatEditUpdate(
// //     TextEditingValue oldValue,
// //     TextEditingValue newValue,
// //   ) {
// //     String text = newValue.text;
// //     if (text.isEmpty) return newValue;

// //     // Determine Mode by the FIRST character
// //     bool isPassportMode = RegExp(r'[A-Za-z]').hasMatch(text[0]);

// //     if (isPassportMode) {
// //       return _formatPassport(text);
// //     } else {
// //       return _formatCNIC(text);
// //     }
// //   }

// //   TextEditingValue _formatPassport(String text) {
// //     // 1. Keep only Alphanumeric
// //     String clean = text.replaceAll(RegExp(r'[^A-Za-z0-9]'), '');

// //     String formatted = '';
// //     for (int i = 0; i < clean.length; i++) {
// //       // Rule: First two characters MUST be letters, rest MUST be digits
// //       if (i < 2) {
// //         if (RegExp(r'[A-Za-z]').hasMatch(clean[i])) {
// //           formatted += clean[i].toUpperCase();
// //         }
// //       } else if (i < 9) {
// //         // Total 9 chars (2 letters + 7 digits)
// //         if (RegExp(r'[0-9]').hasMatch(clean[i])) {
// //           formatted += clean[i];
// //         }
// //       }
// //     }

// //     return TextEditingValue(
// //       text: formatted,
// //       selection: TextSelection.collapsed(offset: formatted.length),
// //     );
// //   }

// //   TextEditingValue _formatCNIC(String text) {
// //     // 1. Keep only digits
// //     String digits = text.replaceAll(RegExp(r'\D'), '');

// //     // 2. Cap at 13 digits
// //     if (digits.length > 13) {
// //       digits = digits.substring(0, 13);
// //     }

// //     // 3. Apply CNIC Mask: XXXXX-XXXXXXX-X
// //     String formatted = '';
// //     for (int i = 0; i < digits.length; i++) {
// //       if (i == 5) formatted += '-';
// //       if (i == 12) formatted += '-';
// //       formatted += digits[i];
// //     }

// //     return TextEditingValue(
// //       text: formatted,
// //       selection: TextSelection.collapsed(offset: formatted.length),
// //     );
// //   }
// // }

// import 'package:flutter/services.dart';

// class IdInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     final String text = newValue.text;
//     if (text.isEmpty) return newValue;

//     // 1. Detect Mode: If it contains ANY letter, it's a Passport
//     final bool isPassportMode = RegExp(r'[A-Za-z]').hasMatch(text);

//     if (isPassportMode) {
//       // --- PASSPORT MODE ---
//       // Clean: Keep only Letters and Numbers
//       String alphanumeric = text
//           .replaceAll(RegExp(r'[^A-Za-z0-9]'), '')
//           .toUpperCase();

//       // 🔹 Strict 9 Character Limit for Passports
//       if (alphanumeric.length > 9) {
//         alphanumeric = alphanumeric.substring(0, 9);
//       }

//       return TextEditingValue(
//         text: alphanumeric,
//         selection: TextSelection.collapsed(offset: alphanumeric.length),
//       );
//     } else {
//       // --- CNIC MODE ---
//       // Clean: Keep only Digits
//       String digits = text.replaceAll(RegExp(r'\D'), '');

//       // 🔹 Strict 13 Digit Limit (Resulting in 15 chars with dashes)
//       if (digits.length > 13) {
//         digits = digits.substring(0, 13);
//       }

//       // Apply Format: XXXXX-XXXXXXX-X
//       String formatted = '';
//       for (int i = 0; i < digits.length; i++) {
//         if (i == 5 || i == 12) {
//           formatted += '-';
//         }
//         formatted += digits[i];
//       }

//       return TextEditingValue(
//         text: formatted,
//         selection: TextSelection.collapsed(offset: formatted.length),
//       );
//     }
//   }
// }

import 'package:flutter/services.dart';

class IdInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String text = newValue.text;
    if (text.isEmpty) return newValue;

    // 1. Strip everything except Letters and Numbers for processing
    String clean = text.replaceAll(RegExp(r'[^A-Za-z0-9]'), '').toUpperCase();

    // 2. Determine Mode:
    // If it has letters, it's definitely a Passport.
    // If it's pure numbers but length <= 9, treat as "Potential Passport".
    // If it's pure numbers and length > 9, treat as CNIC.
    final bool hasLetters = RegExp(r'[A-Za-z]').hasMatch(clean);

    if (hasLetters || clean.length <= 9) {
      // --- PASSPORT / SHORT NUMERIC MODE ---
      if (clean.length > 9 && hasLetters) {
        clean = clean.substring(0, 9); // Strict 9 for Passports with letters
      } else if (clean.length > 13) {
        clean = clean.substring(0, 13); // Max 13 for pure numeric
      }

      return TextEditingValue(
        text: clean,
        selection: TextSelection.collapsed(offset: clean.length),
      );
    } else {
      // --- CNIC MODE (Only for 10-13 digits) ---
      String digits = clean.replaceAll(RegExp(r'\D'), '');
      if (digits.length > 13) digits = digits.substring(0, 13);

      String formatted = '';
      for (int i = 0; i < digits.length; i++) {
        if (i == 5 || i == 12) formatted += '-';
        formatted += digits[i];
      }

      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }
}
