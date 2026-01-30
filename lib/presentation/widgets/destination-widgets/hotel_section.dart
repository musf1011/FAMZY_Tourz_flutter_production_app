// created by: FAMZY CodeWorks

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers.dart/desstinations_provider.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HotelSection extends StatelessWidget {
  const HotelSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DestinationsProvider>();
    final destination = provider.selectedDestination.name;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.hotelPlaceholder,
          arguments: destination,
        );
      },
      child: Card(
        color: AppConstants.primaryTransGColor,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Colors.white),
        ),
        child: const Padding(
          padding: EdgeInsets.all(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find Hotels',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Tap to view hotel options',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              Icon(Icons.hotel, color: Colors.white, size: 40),
            ],
          ),
        ),
      ),
    );
  }
}
