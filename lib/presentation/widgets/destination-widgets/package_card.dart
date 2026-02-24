// // created by: FAMZY CodeWorks

// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:famzy_tourz_v2/data/models/package_model.dart';
// import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
// import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/desstinations_provider.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/dialogs/custom_alert_dialogs.dart';
// import 'package:famzy_tourz_v2/routes/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';

// class PackageCard extends StatefulWidget {
//   final PackageModel package;

//   const PackageCard(this.package, {super.key});

//   @override
//   State<PackageCard> createState() => _PackageCardState();
// }

// class _PackageCardState extends State<PackageCard> {
//   bool expanded = false;

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.read<DestinationsProvider>();
//     final isAdmin = provider.canManagePackages;
//     final nav = NavigationService();
//     // debugPrint('***datecard: ${widget.package.departureDate}');
//     return Card(
//       color: AppConstants.primaryTransGColor,
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(25),
//         side: const BorderSide(color: Colors.white, width: 1),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// 🏷 Package Name
//             Text(
//               widget.package.packageName,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),

//             const SizedBox(height: 8),

//             _infoRow('⛳ Duration', widget.package.duration),
//             _infoRow('📅 Date', widget.package.departureDate),
//             _infoRow('⏰ Time', widget.package.departureTime),
//             _infoRow('📍 Spots', widget.package.keySpots),
//             _infoRow('🚗 Vehicle', widget.package.vehicle),

//             const SizedBox(height: 8),

//             /// 📖 Description
//             Text(
//               widget.package.description,
//               maxLines: expanded ? null : 3,
//               overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
//               style: const TextStyle(color: Colors.white70),
//             ),
//             if (widget.package.description.length > 120)
//               TextButton(
//                 onPressed: () => setState(() => expanded = !expanded),
//                 child: Text(
//                   expanded ? 'Show less' : 'See more',
//                   style: const TextStyle(color: Colors.yellow),
//                 ),
//               ),

//             const SizedBox(height: 10),

//             /// 💰 Price Button
//             CustomLoadingButton(
//               text: '${widget.package.price} PKR per Person',
//               backgroundColor: AppConstants.primaryColor,
//               // width: double.infinity, // Matches your previous design
//               // height: 45.h, // Adjusted to your preference
//               onPressed: () => provider.bookPackage(widget.package),
//               isLoading:
//                   false, // You can link this to a 'isBooking' variable later
//             ),

//             // /// 🛠 ADMIN CONTROLS
//             if (isAdmin)
//               Row(
//                 mainAxisAlignment: .spaceBetween,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.edit, color: Colors.blue),
//                     onPressed: () {
//                       nav.navigateTo(
//                         AppRoutes.companyAddPackage,
//                         arguments: widget.package,
//                       );
//                     },
//                   ),
//                   IconButton(
//                     icon: const Icon(
//                       Icons.delete,
//                       color: AppConstants.lightRed,
//                     ),
//                     onPressed: () async {
//                       //show the custom FAMZY confirmation dialog
//                       final confirmed = await AppConfirmDialog.show(
//                         context,
//                         title: 'Delete Package',
//                         message:
//                             'Are you sure you want to delete "${widget.package.packageName}"? This action cannot be undone.',
//                         confirmText: 'Delete',
//                         cancelText: 'Keep it',
//                         isDanger:
//                             true, // This turns the icon/text red in your custom dialog
//                         // confirmColor: Colors.red,
//                         icon: Icons.delete_forever_rounded,
//                       );

//                       //only delete if "Confirm/Delete"
//                       if (confirmed == true) {
//                         await provider.deletePackage(widget.package);

//                         // Optional: Show a small snackbar to confirm it's gone
//                         if (context.mounted) {
//                           nav.showSnackBar(
//                             title: 'Paxkage Deleted',
//                             message: 'Package deleted succesfully',
//                             duration: 2,
//                           );
//                         }
//                       }
//                     },
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _infoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 3),
//       child: Text(
//         '$label: $value',
//         style: TextStyle(color: Colors.white, letterSpacing: .5.sp),
//       ),
//     );
//   }
// }

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/models/package_model.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/user_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/booking_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/desstinations_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_profile_avatar.dart';
import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/info_chip.dart';
import 'package:famzy_tourz_v2/presentation/widgets/dialogs/custom_alert_dialogs.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PackageCard extends StatefulWidget {
  final PackageModel package;

  const PackageCard(this.package, {super.key});

  @override
  State<PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DestinationsProvider>();
    final isAdmin = provider.isAdmin;
    final nav = NavigationService();

    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide(color: AppConstants.whiteColorP5, width: .5.r),
      ),

      color: AppConstants.primaryTransGColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomProfileAvatar(
                  imageUrl: widget.package.companyPhotoURL,
                  radius: 30.r,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.package.companyName,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  'Seat Booked: ${widget.package.seatBooked}',
                  style: const TextStyle(color: AppConstants.famzyGold),
                ),
              ],
            ),

            const SizedBox(height: 12),

            //PACKAGE NAME
            Text(
              widget.package.packageName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              // textAlign: .center,
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              runSpacing: 8,
              alignment: .center,
              children: [
                infoChip(Icons.calendar_month, widget.package.departureDate),
                infoChip(Icons.timelapse, widget.package.departureTime),
                infoChip(Icons.timeline, widget.package.duration),
                infoChip(Icons.directions_car, widget.package.vehicle),
              ],
            ),

            const SizedBox(height: 8),

            /// KEY SPOTS
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.place,
                  color: AppConstants.famzyGold,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    widget.package.keySpots,
                    style: TextStyle(color: AppConstants.whiteColorP9),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// DESCRIPTION
            Text(
              widget.package.description,
              maxLines: expanded ? null : 3,
              overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: TextStyle(color: AppConstants.whiteColorP5),
            ),
            if (widget.package.description.length > 120)
              TextButton(
                onPressed: () => setState(() => expanded = !expanded),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: Text(
                  expanded ? 'Show less' : 'See more',
                  style: expanded
                      ? const TextStyle(color: AppConstants.famzyGold)
                      : const TextStyle(color: AppConstants.googleBlue),
                ),
              ),

            const SizedBox(height: 14),
            CustomLoadingButton(
              text: '${widget.package.price.toString()} PKR / Person',
              backgroundColor: AppConstants.primaryColor,
              // onPressed: () => NavigationService().navigateTo(
              //   AppRoutes.packageDetail,
              //   arguments: widget.package,
              // ),
              onPressed: () {
                final bookingProvider = context.read<BookingProvider>();
                final user = context.read<UserProvider>().user;
                bookingProvider.selectPackage(widget.package, user!.userId);

                bookingProvider.prefillFirstPassenger(user);
                nav.navigateTo(AppRoutes.packageDetail);
              },
              isLoading: false,
            ),

            /// 💰 PRICE + ACTION
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                // if (isAdmin) const SizedBox(width: 8),
                if (isAdmin)
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: AppConstants.accentColor,
                    ),
                    onPressed: () {
                      nav.navigateTo(
                        AppRoutes.companyAddPackage,
                        arguments: widget.package,
                      );
                    },
                  ),
                if (isAdmin)
                  IconButton(
                    icon: const Icon(
                      Icons.delete_forever_rounded,
                      color: AppConstants.lightRed,
                    ),
                    onPressed: () async {
                      final confirmed = await AppConfirmDialog.show(
                        context,
                        title: 'Delete Package',
                        message:
                            'Delete "${widget.package.packageName}" permanently?',
                        confirmText: 'Delete',
                        cancelText: 'Cancel',
                        isDanger: true,
                        icon: Icons.delete_forever_rounded,
                      );

                      if (confirmed == true) {
                        await provider.deletePackage(widget.package);
                        if (context.mounted) {
                          nav.showSnackBar(
                            title: 'Package Deleted',
                            message: 'Package deleted successfully',
                            duration: 2,
                          );
                        }
                      }
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
