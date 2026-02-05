// created by: FAMZY CodeWorks

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/models/package_model.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/desstinations_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
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
    final isAdmin = provider.canManagePackages;
    debugPrint('***datecard: ${widget.package.departureDate}');
    return Card(
      color: AppConstants.primaryTransGColor,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: const BorderSide(color: Colors.white, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🏷 Package Name
            Text(
              widget.package.packageName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            _infoRow('⛳ Duration', widget.package.duration),
            _infoRow('📅 Date', widget.package.departureDate),
            _infoRow('⏰ Time', widget.package.departureTime),
            _infoRow('📍 Spots', widget.package.keySpots),
            _infoRow('🚗 Vehicle', widget.package.vehicle),

            const SizedBox(height: 8),

            /// 📖 Description
            Text(
              widget.package.description,
              maxLines: expanded ? null : 3,
              overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white70),
            ),
            if (widget.package.description.length > 120)
              TextButton(
                onPressed: () => setState(() => expanded = !expanded),
                child: Text(
                  expanded ? 'Show less' : 'See more',
                  style: const TextStyle(color: Colors.yellow),
                ),
              ),

            const SizedBox(height: 10),

            // /// 💰 Price Button
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: AppConstants.tertiaryColor,
            //     minimumSize: const Size(double.infinity, 45),
            //   ),
            //   onPressed: () => provider.bookPackage(widget.package),
            //   child: Text(
            //     '${widget.package.price} PKR per Person',
            //     style: const TextStyle(color: Colors.black),
            //   ),
            // ),
            /// 💰 Price Button
            CustomLoadingButton(
              text: '${widget.package.price} PKR per Person',
              backgroundColor: AppConstants.primaryColor,
              // width: double.infinity, // Matches your previous design
              // height: 45.h, // Adjusted to your preference
              onPressed: () => provider.bookPackage(widget.package),
              isLoading:
                  false, // You can link this to a 'isBooking' variable later
            ),

            // /// 🛠 ADMIN CONTROLS
            // if (isAdmin)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       IconButton(
            //         icon: const Icon(Icons.edit, color: Colors.blue),
            //         onPressed: () => provider.editPackage(widget.package),
            //       ),
            // IconButton(
            //   icon: const Icon(Icons.delete, color: Colors.red),
            //   onPressed: () => provider.deletePackage(widget.package),
            // ),
            //     ],
            //   ),
            if (isAdmin)
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      NavigationService().navigateTo(
                        AppRoutes.companyAddPackage,
                        arguments: widget.package,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: AppConstants.lightRed,
                    ),
                    onPressed: () async {
                      // 1. Show the custom FAMZY confirmation dialog
                      final confirmed = await AppConfirmDialog.show(
                        context,
                        title: 'Delete Package',
                        message:
                            'Are you sure you want to delete "${widget.package.packageName}"? This action cannot be undone.',
                        confirmText: 'Delete',
                        cancelText: 'Keep it',
                        isDanger:
                            true, // This turns the icon/text red in your custom dialog
                        // confirmColor: Colors.red,
                        icon: Icons.delete_forever_rounded,
                      );

                      // 2. Only delete if the user clicked "Confirm/Delete"
                      if (confirmed == true) {
                        // ignore: use_build_context_synchronously
                        await provider.deletePackage(widget.package);

                        // Optional: Show a small snackbar to confirm it's gone
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Package deleted successfully'),
                            ),
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

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(
        '$label: $value',
        style: TextStyle(color: Colors.white, letterSpacing: .5.sp),
      ),
    );
  }
}
