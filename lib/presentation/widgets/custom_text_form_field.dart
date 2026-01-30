// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class CustTextFormField extends StatelessWidget {
//   final String label;
//   final String hint;
//   final String? initialValue;
//   final bool obscureText;
//   final String? Function(String?)? validator;
//   final bool isVisible;
//   final VoidCallback? toggleVisibility;
//   final void Function(String?)? onSaved;
//   final void Function(String)? onChanged;
//   final TextInputType keyboardType;
//   final int maxLines;
//   final TextEditingController? controller;
//   final bool readOnly;
//   final VoidCallback? onTap;
//   final List<TextInputFormatter>? inputFormatters;

//   const CustTextFormField({
//     super.key,
//     required this.label,
//     required this.hint,
//     this.initialValue,
//     this.keyboardType = TextInputType.text,
//     this.obscureText = false,
//     this.validator,
//     this.isVisible = false,
//     this.toggleVisibility,
//     this.onChanged,
//     this.maxLines = 1,
//     this.controller,
//     this.readOnly = false,
//     this.onTap,
//     this.onSaved,
//     this.inputFormatters,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       initialValue: controller == null ? initialValue : null,
//       controller: controller,
//       onSaved: onSaved,
//       onChanged: onChanged,
//       obscureText: obscureText && isVisible,
//       validator: validator,
//       keyboardType: keyboardType,
//       maxLines: maxLines,
//       readOnly: readOnly,
//       onTap: onTap,
//       inputFormatters: inputFormatters,
//       style: const TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: const TextStyle(color: Colors.white),
//         hintText: hint,
//         hintStyle: TextStyle(color: AppConstants.whiteColorP5),
//         suffixIcon: toggleVisibility != null
//             ? IconButton(
//                 onPressed: toggleVisibility,
//                 icon: Icon(
//                   isVisible ? Icons.visibility_off : Icons.visibility,
//                   color: isVisible
//                       ? AppConstants.whiteColorP5
//                       : AppConstants.secondaryColor,
//                 ),
//               )
//             : null,
//         focusedBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(color: AppConstants.underline),
//         ),
//       ),
//     );
//   }
// }

// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class CustTextFormField extends StatelessWidget {
//   final String label;
//   final String hint;
//   final String? initialValue;
//   final bool obscureText;
//   final String? Function(String?)? validator;
//   final bool isVisible;
//   final VoidCallback? toggleVisibility;
//   final void Function(String?)? onSaved;
//   final void Function(String)? onChanged;
//   final TextInputType keyboardType;
//   final int maxLines;
//   final TextEditingController? controller;
//   final bool readOnly;
//   final VoidCallback? onTap;
//   final List<TextInputFormatter>? inputFormatters;

//   const CustTextFormField({
//     super.key,
//     required this.label,
//     required this.hint,
//     this.initialValue,
//     this.keyboardType = TextInputType.text,
//     this.obscureText = false,
//     this.validator,
//     this.isVisible = false,
//     this.toggleVisibility,
//     this.onChanged,
//     this.maxLines = 1,
//     this.controller,
//     this.readOnly = false,
//     this.onTap,
//     this.onSaved,
//     this.inputFormatters,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: Theme.of(context).copyWith(
//         colorScheme: Theme.of(
//           context,
//         ).colorScheme.copyWith(primary: Colors.green, secondary: Colors.green),
//       ),
//       child: TextFormField(
//         initialValue: controller == null ? initialValue : null,
//         controller: controller,
//         onSaved: onSaved,
//         onChanged: onChanged,
//         obscureText: obscureText && isVisible,
//         validator: validator,
//         keyboardType: keyboardType,
//         maxLines: maxLines,
//         readOnly: readOnly,
//         onTap: onTap,
//         inputFormatters: inputFormatters,
//         cursorColor: Colors.green,
//         style: const TextStyle(color: Colors.white),
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: const TextStyle(color: Colors.white),
//           hintText: hint,
//           hintStyle: TextStyle(color: AppConstants.whiteColorP5),
//           suffixIcon: toggleVisibility != null
//               ? IconButton(
//                   onPressed: toggleVisibility,
//                   icon: Icon(
//                     isVisible ? Icons.visibility_off : Icons.visibility,
//                     color: isVisible
//                         ? AppConstants.whiteColorP5
//                         : AppConstants.secondaryColor,
//                   ),
//                 )
//               : null,
//           focusedBorder: const UnderlineInputBorder(
//             borderSide: BorderSide(color: AppConstants.underline),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:famzy_tourz_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final String? initialValue;
  final bool obscureText;
  final bool isPasswordHidden;
  final VoidCallback? toggleVisibility;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final TextInputType keyboardType;
  final int maxLines;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;

  const CustTextFormField({
    super.key,
    required this.label,
    required this.hint,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isPasswordHidden = true,
    this.toggleVisibility,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.onSaved,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: controller == null ? initialValue : null,
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      obscureText: obscureText && isPasswordHidden,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      inputFormatters: inputFormatters,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        hintText: hint,
        hintStyle: TextStyle(color: AppConstants.whiteColorP5),

        suffixIcon: toggleVisibility != null
            ? IconButton(
                onPressed: toggleVisibility,
                icon: Icon(
                  isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                  color: isPasswordHidden
                      ? Colors.grey
                      : AppConstants.tertiaryColor,
                ),
              )
            : null,

        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppConstants.tertiaryColor),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}
