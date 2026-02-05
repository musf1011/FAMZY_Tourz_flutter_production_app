// // created by: FAMZY CodeWorks

// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:famzy_tourz_v2/presentation/providers/desstinations_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:provider/provider.dart';

// class OSMMapWidget extends StatelessWidget {
//   const aOSMMapWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<DestinationsProvider>();
//     final dest = provider.selectedDestination;

//     final LatLng location = LatLng(dest.latitude, dest.longitude);

//     return Container(
//       height: 250,
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: Colors.white),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: FlutterMap(
//           options: MapOptions(
//             initialCenter: location,
//             initialZoom: 10,
//             interactionOptions: const InteractionOptions(
//               flags: InteractiveFlag.all,
//             ),
//           ),
//           children: [
//             /// 🌍 Map Tiles (OpenStreetMap)
//             TileLayer(
//               urlTemplate:
//                   'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//               userAgentPackageName: 'com.famzy.tourz',
//             ),

//             /// 📍 Destination Marker
//             MarkerLayer(
//               markers: [
//                 Marker(
//                   point: location,
//                   width: 50,
//                   height: 50,
//                   child: const Icon(
//                     Icons.location_pin,
//                     color: AppConstants.tertiaryColor,
//                     size: 40,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// created by: FAMZY CodeWorks

import 'dart:async';
import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/desstinations_provider.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OSMMapWidget extends StatefulWidget {
  const OSMMapWidget({super.key});

  @override
  State<OSMMapWidget> createState() => _OSMMapWidgetState();
}

class _OSMMapWidgetState extends State<OSMMapWidget> {
  LatLng? userLocation;
  int mapStyleIndex = 0;

  final List<String> tileStyles = [
    'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // Normal
    'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png', // Dark
    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', // Satellite
  ];

  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to call provider after build is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DestinationsProvider>().checkAndRequestLocation().then((_) {
        // Only call your _getLocation if the provider says it's okay now
        // ignore: use_build_context_synchronously
        if (context.read<DestinationsProvider>().isLocationGranted) {
          _getLocation();
        }
      });
    });
  }

  // Future<void> _getLocation() async {
  //   final pos = await Geolocator.getCurrentPosition();
  //   setState(() {
  //     userLocation = LatLng(pos.latitude, pos.longitude);
  //   });
  // }
  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Check if GPS is even turned on
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    // 2. Check/Request Permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    // 3. Now it is safe to get the position
    final pos = await Geolocator.getCurrentPosition();
    if (mounted) {
      setState(() {
        userLocation = LatLng(pos.latitude, pos.longitude);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DestinationsProvider>();
    final dest = provider.selectedDestination;
    final LatLng destLocation = LatLng(dest.latitude, dest.longitude);

    return Column(
      children: [
        /// 🎨 Map Style Switch
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: const Icon(Icons.layers, color: Colors.white),
            onPressed: () {
              setState(() {
                mapStyleIndex = (mapStyleIndex + 1) % tileStyles.length;
              });
            },
          ),
        ),

        Container(
          height: 260,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: FlutterMap(
            options: MapOptions(initialCenter: destLocation, initialZoom: 10),
            children: [
              TileLayer(
                urlTemplate: tileStyles[mapStyleIndex],
                userAgentPackageName: 'famzy.tourz',
              ),
              // ADD THIS LAYER
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () async {
                      final Uri url = Uri.parse(
                        'https://openstreetmap.org/copyright',
                      );
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                  ),
                ],
              ),

              /// 📍 MARKERS
              MarkerLayer(
                markers: [
                  /// Destination marker (A)
                  Marker(
                    point: destLocation,
                    width: 50,
                    height: 50,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.packages,
                        ); // Open packages
                      },
                      child: const Icon(
                        Icons.location_pin,
                        size: 45,
                        color: AppConstants.tertiaryColor,
                      ),
                    ),
                  ),

                  /// User location marker
                  if (userLocation != null)
                    Marker(
                      point: userLocation!,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),

                  /// D — Package spots markers
                  ...provider.packages
                      .where((p) => p.spotsLatLng != null)
                      .map(
                        (p) => Marker(
                          point: p.spotsLatLng!,
                          width: 35,
                          height: 35,
                          child: const Icon(
                            Icons.place,
                            color: Colors.orange,
                            size: 28,
                          ),
                        ),
                      ),
                ],
              ),

              /// B — ROUTE LINE
              if (userLocation != null)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: [userLocation!, destLocation],
                      strokeWidth: 4,
                      color: Colors.redAccent,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
