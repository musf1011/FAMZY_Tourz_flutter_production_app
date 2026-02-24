// import 'package:flutter/services.dart';

// class CNICInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     // Remove all non-digits
//     String digits = newValue.text.replaceAll(RegExp(r'\D'), '');

//     // Limit to 13 digits
//     if (digits.length > 13) {
//       digits = digits.substring(0, 13);
//     }

//     String formatted = '';

//     for (int i = 0; i < digits.length; i++) {
//       if (i == 5 || i == 12) {
//         formatted += '-';
//       }
//       formatted += digits[i];
//     }

//     return TextEditingValue(
//       text: formatted,
//       selection: TextSelection.collapsed(offset: formatted.length),
//     );
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

    // If user types any letter → treat as passport (no formatting)
    if (RegExp(r'[A-Za-z]').hasMatch(text)) {
      return newValue;
    }

    // Otherwise treat as CNIC (digits only)
    String digits = text.replaceAll(RegExp(r'\D'), '');

    if (digits.length > 13) {
      digits = digits.substring(0, 13);
    }

    String formatted = '';

    for (int i = 0; i < digits.length; i++) {
      if (i == 5 || i == 12) {
        formatted += '-';
      }
      formatted += digits[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
