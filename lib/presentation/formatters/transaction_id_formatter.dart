import 'package:flutter/services.dart';

/// A dedicated formatter for NayaPay/Banking Transaction IDs.
/// It forces uppercase and removes any special characters or spaces.
class TransactionIdFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 1. Remove any character that is NOT a letter or a number
    final String filteredText = newValue.text.replaceAll(
      RegExp(r'[^a-zA-Z0-9]'),
      '',
    );

    // 2. Force the text to Uppercase
    final String uppercaseText = filteredText.toUpperCase();

    // 3. Return the new value while maintaining the correct cursor position
    return newValue.copyWith(
      text: uppercaseText,
      // We calculate the selection based on the new text length to prevent
      // the cursor from jumping if invalid characters were stripped out.
      selection: TextSelection.collapsed(offset: uppercaseText.length),
    );
    // return newValue.copyWith(
    //   text: uppercaseText,
    //   selection: TextSelection.collapsed(offset: uppercaseText.length),
    // );
  }
}
