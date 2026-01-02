// created by: FAMZY CodeWorks

import 'package:famzy_tourz_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final Color confirmColor;
  final IconData? icon;
  final bool isDanger;

  const AppConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.confirmColor = AppConstants.lightRed,
    this.icon,
    this.isDanger = false,
  });

  ///  Helper method (recommended way to use)
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color confirmColor = AppConstants.lightRed,
    IconData? icon,
    bool isDanger = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true, //user cancel buy clicking outside
      builder: (_) => AppConfirmDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        confirmColor: confirmColor,
        icon: icon,
        isDanger: isDanger,
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppConstants.secondaryTransGColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.r),
        side: BorderSide(color: Colors.white, width: 1.r), //white p3 needed
      ),
      titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 30.h),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      actionsPadding: EdgeInsets.fromLTRB(15.w, 20.h, 15.w, 15.h),

      //title
      title: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: isDanger ? Colors.red : Colors.white,
              size: 28.sp,
            ),
            SizedBox(width: 10.w),
          ],
          Expanded(
            child: Text(
              title,
              // style: TextStyle(
              //   fontSize: 18.sp,
              //   fontWeight: FontWeight.w600,
              //   color: Colors.white,
              // ),
              style: GoogleFonts.montserrat(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing:
                    0.5, // Montserrat looks best with a tiny bit of extra space
              ),
              // style: GoogleFonts.lexend(
              //   fontSize: 18.sp,
              //   fontWeight: FontWeight.w600,
              //   color: Colors.white,
              // ),
            ),
          ),
        ],
      ),

      /// MESSAGE
      // content: Text(
      //   message,
      //   style: TextStyle(fontSize: 14.sp, color: AppConstants.whiteColorP9),
      // ),
      content: Text(
        message,
        style: GoogleFonts.poppins(
          fontSize: 14.sp,
          color: AppConstants.whiteColorP9,
          fontWeight: .w500,
          letterSpacing: 0.2, // Slightly more space makes it easier to read
        ),
      ),

      /// ACTIONS
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.lightGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.r),
            ),
          ),
          onPressed: () => Navigator.pop(context, false),
          child: Text(
            cancelText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: confirmColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.r),
            ),
          ),
          onPressed: () => Navigator.pop(context, true),
          child: Text(
            confirmText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tg_walk/model/location.dart';
// enum WalkRequestStatus {
//   pending, // Walker created request, waiting for guide
//   // guideAccepted, // Guide accepted, waiting for walker confirmation
//   accepted, // Walker confirmed guide acceptance
//   inProgress,
//   completed,
//   cancelled,
// }
// class WalkRequest {
//   String? id;
//   String? walkerId;
//   String? guideId;
//   String? serviceType;
//   // Walk details
//   DateTime? scheduledDate;
//   String? scheduledTime;
//   String? duration;
//   Location? location;
//   double? distance;
//   // Request details
//   WalkRequestStatus? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   DateTime? walkStartedAt; // Timestamp when walk status changed to inProgress
//   List<String>?
//       declinedGuides; // List of guide IDs who have declined this request
//   WalkRequest({
//     this.serviceType,
//     this.id,
//     this.walkerId,
//     this.guideId,
//     this.scheduledDate,
//     this.scheduledTime,
//     this.duration,
//     this.location,
//     this.distance,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.walkStartedAt,
//     this.declinedGuides,
//   });
//   factory WalkRequest.fromJson(Map<String, dynamic> json, String id) {
//     return WalkRequest(
//       id: id,
//       serviceType: json['service_type'],
//       walkerId: json['walker_id'] ?? '',
//       guideId: json['guide_id'],
//       scheduledDate: (json['scheduled_date'] as Timestamp).toDate(),
//       scheduledTime: json['scheduled_time'] ?? '',
//       duration: json['duration'] ?? '',
//       location: Location.fromJson(json['location'] ?? {}),
//       distance: (json['distance_km'] as num?)?.toDouble(),
//       status: WalkRequestStatus.values.firstWhere(
//         (e) => e.name == json['status'],
//         orElse: () => WalkRequestStatus.pending,
//       ),
//       createdAt: (json['created_at'] as Timestamp).toDate(),
//       updatedAt: json['updated_at'] != null
//           ? (json['updated_at'] as Timestamp).toDate()
//           : null,
//       walkStartedAt: json['walk_started_at'] != null
//           ? (json['walk_started_at'] as Timestamp).toDate()
//           : null,
//       declinedGuides:
//           (json['declined_guides'] as List?)?.map((e) => e.toString()).toList(),
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'walker_id': walkerId,
//       'guide_id': guideId,
//       'scheduled_date': Timestamp.fromDate(scheduledDate!),
//       'scheduled_time': scheduledTime,
//       'duration': duration,
//       'service_type': serviceType,
//       'location': location?.toJson(),
//       'distance_km': distance,
//       'status': status?.name ?? '',
//       'created_at': Timestamp.fromDate(createdAt!),
//       'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
//       'walk_started_at':
//           walkStartedAt != null ? Timestamp.fromDate(walkStartedAt!) : null,
//       'declined_guides': declinedGuides,
//     };
//   }
//   WalkRequest copyWith({
//     String? id,
//     String? walkerId,
//     String? guideId,
//     DateTime? scheduledDate,
//     String? scheduledTime,
//     String? duration,
//     Location? location,
//     double? distance,
//     WalkRequestStatus? status,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     DateTime? walkStartedAt,
//     List<String>? declinedGuides,
//   }) {
//     return WalkRequest(
//       id: id ?? this.id,
//       walkerId: walkerId ?? this.walkerId,
//       guideId: guideId ?? this.guideId,
//       scheduledDate: scheduledDate ?? this.scheduledDate,
//       scheduledTime: scheduledTime ?? this.scheduledTime,
//       duration: duration ?? this.duration,
//       location: location ?? this.location,
//       distance: distance ?? this.distance,
//       status: status ?? this.status,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       walkStartedAt: walkStartedAt ?? this.walkStartedAt,
//       declinedGuides: declinedGuides ?? this.declinedGuides,
//     );
//   }
// }
