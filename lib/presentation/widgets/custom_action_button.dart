// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// Widget _adminActionButton({
//   required String label,
//   required Color color,
//   required VoidCallback onPressed,
// }) {
//   return Expanded(
//     child: ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         padding: EdgeInsets.symmetric(vertical: 10.h),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           fontSize: 11.sp,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//         textAlign: TextAlign.center,
//       ),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FamzyButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;
  final bool isExpanded; // Added for true universal usage

  const FamzyButton({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
    this.isExpanded = true, // Default to true for your Admin Rows
  });

  @override
  Widget build(BuildContext context) {
    // We wrap in Expanded ONLY if requested
    final Widget button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        elevation: 2,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );

    return isExpanded ? Expanded(child: button) : button;
  }
}
