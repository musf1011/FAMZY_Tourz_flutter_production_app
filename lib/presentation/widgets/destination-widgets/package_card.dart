// created by: FAMZY CodeWorks

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/models/package_model.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers.dart/desstinations_provider.dart';
import 'package:flutter/material.dart';
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

    return Card(
      color: AppConstants.primaryTransGColor,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
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
            _infoRow('📅 Date', widget.package.date),
            _infoRow('⏰ Time', widget.package.time),
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

            /// 💰 Price Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.tertiaryColor,
                minimumSize: const Size(double.infinity, 45),
              ),
              onPressed: () => provider.bookPackage(widget.package),
              child: Text(
                '${widget.package.price} PKR per Person',
                style: const TextStyle(color: Colors.black),
              ),
            ),

            /// 🛠 ADMIN CONTROLS
            if (isAdmin)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => provider.editPackage(widget.package),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => provider.deletePackage(widget.package),
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
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
