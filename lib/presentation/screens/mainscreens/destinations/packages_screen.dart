// // created by: FAMZY CodeWorks

// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:famzy_tourz_v2/presentation/providers/desstinations_provider.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/hotel_section.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/package_card.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/weather_card.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class PackagesScreen extends StatefulWidget {
//   const PackagesScreen({super.key});

//   @override
//   State<PackagesScreen> createState() => _PackagesScreenState();
// }

// class _PackagesScreenState extends State<PackagesScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(
//       // ignore: use_build_context_synchronously
//       () => context.read<DestinationsProvider>().initPackagesScreen(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<DestinationsProvider>();
//     final destination = provider.selectedDestination;

//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(destination.name),
//           backgroundColor: AppConstants.primaryColor,
//         ),
//         body: Column(
//           children: [
//             /// 🔵 Insights Button (manual)
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Later: show static travel insights
//                 },
//                 child: const Text('Travel Insights'),
//               ),
//             ),

//             const TabBar(
//               tabs: [
//                 Tab(text: 'Packages'),
//                 Tab(text: 'Explore'),
//               ],
//             ),

//             Expanded(
//               child: TabBarView(
//                 children: [
//                   /// 📦 PACKAGES TAB
//                   provider.isLoadingPackages
//                       ? const Center(child: CircularProgressIndicator())
//                       : ListView.builder(
//                           itemCount: provider.packages.length,
//                           itemBuilder: (context, index) =>
//                               PackageCard(provider.packages[index]),
//                         ),

//                   /// 🌍 EXPLORE TAB
//                  const SingleChildScrollView(
//                     child: Column(
//                       children: const [
//                         WeatherCard(),
//                         SizedBox(height: 20),
//                         // OSMMapWidget(),
//                         SizedBox(height: 20),
//                         HotelSection(),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // // created by: FAMZY CodeWorks

// // import 'package:famzy_tourz_v2/presentation/providers/desstinations_provider.dart';
// // import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/hotel_section.dart';
// // import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/package_card.dart';
// // import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/weather_card.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';

// // class PackagesScreen extends StatefulWidget {
// //   const PackagesScreen({super.key});

// //   @override
// //   State<PackagesScreen> createState() => _PackagesScreenState();
// // }

// // class _PackagesScreenState extends State<PackagesScreen> {
// //   @override
// //   void initState() {
// //     super.initState();

// //     /// Load everything once screen opens
// //     Future.microtask(() {
// //       // ignore: use_build_context_synchronously
// //       context.read<DestinationsProvider>().initPackagesScreen();
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final provider = context.watch<DestinationsProvider>();
// //     final destination = provider.selectedDestination;

// //     return Scaffold(
// //       appBar: AppBar(title: Text(destination.name)),
// //       body: RefreshIndicator(
// //         onRefresh: provider.initPackagesScreen,
// //         child: ListView(
// //           physics: const AlwaysScrollableScrollPhysics(),
// //           children: [
// //             /// 🌤 WEATHER
// //             const WeatherCard(),

// //             /// 🏨 HOTEL SECTION
// //             const HotelSection(),

// //             const SizedBox(height: 10),

// //             /// 📦 PACKAGES HEADER
// //             const Padding(
// //               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
// //               child: Text(
// //                 'Available Tour Packages',
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //               ),
// //             ),

// //             /// ⏳ LOADING
// //             if (provider.isLoadingPackages)
// //               const Padding(
// //                 padding: EdgeInsets.all(30),
// //                 child: Center(child: CircularProgressIndicator()),
// //               ),

// //             /// ❌ EMPTY
// //             if (!provider.isLoadingPackages && provider.packages.isEmpty)
// //               const Padding(
// //                 padding: EdgeInsets.all(30),
// //                 child: Center(
// //                   child: Text(
// //                     'No packages available yet',
// //                     style: TextStyle(fontSize: 16),
// //                   ),
// //                 ),
// //               ),

// //             /// 📦 PACKAGE LIST
// //             if (!provider.isLoadingPackages)
// //               ...provider.packages.map((pkg) => PackageCard(pkg)),

// //             const SizedBox(height: 40),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// created by: FAMZY CodeWorks

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers.dart/desstinations_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/dest_bg_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/hotel_section.dart';
import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/osm_map_card.dart';
import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/package_card.dart';
import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/weather_block.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      // ignore: use_build_context_synchronously
      () => context.read<DestinationsProvider>().initPackagesScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DestinationsProvider>();
    final destination = provider.selectedDestination;

    return DefaultTabController(
      length: 2,
      child: DestinationBackgroundWrapper(
        imagePath: destination.image,
        destinationName: destination.name,
        onRefresh: provider.initPackagesScreen,
        actions: [
          Consumer<DestinationsProvider>(
            builder: (context, provider, _) {
              if (!provider.canManagePackages) return const SizedBox.shrink();

              return Row(
                children: [
                  Text('Add Package', style: AppConstants.sendButtonTextStyle),
                  IconButton(
                    icon: Icon(
                      Icons.add_box_rounded,
                      color: AppConstants.whiteColorP5,
                      size: 32.h,
                    ),
                    onPressed: () {
                      NavigationService().navigateTo(
                        AppRoutes.companyAddPackage,
                        arguments: {
                          'name': destination.name,
                          'image': destination.image,
                        },
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
        child:
            // child: Scaffold(
            //   body: RefreshIndicator(
            //     color: AppConstants.tertiaryColor,
            //     onRefresh: provider.initPackagesScreen,
            //     child: Container(
            //       height: 1.sh,
            //       width: 1.sw,
            //       decoration: BoxDecoration(
            //         image: DecorationImage(
            //           image: AssetImage(destination.image),
            //           fit: BoxFit.cover,
            //         ),
            //       ),
            //       child: Container(
            //         decoration: BoxDecoration(
            //           gradient: LinearGradient(
            //             colors: [
            //               AppConstants.secondaryTransGColor,
            //               AppConstants.blackColorP7,
            //             ],
            //             begin: Alignment.bottomCenter,
            //             end: Alignment.topCenter,
            //           ),
            //         ),
            //         child: Column(
            //           children: [
            //             SizedBox(height: 50.h),
            //             Text(destination.name, style: AppConstants.destNameTextStyle),
            //             IconButton(
            //               icon: const Icon(Icons.add_box_rounded),
            //               onPressed: () {
            //                 // TODO: Navigate to AddPackageScreen
            //               },
            //             ),
            //             SizedBox(height: 10.h),
            Column(
              children: [
                /// 🔵 TRAVEL INSIGHTS BUTTON
                CustomLoadingButton(
                  onPressed: () async {
                    // simulate loading insight fetch
                    await showDialog(
                      context: context,
                      builder: (_) => const Center(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    );

                    await Future.delayed(const Duration(seconds: 1));
                    NavigationService().pop();

                    // TODO: Show manual travel insights screen
                  },
                  text: 'Travel Insight',
                ),
                const TabBar(
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(text: 'Packages'),
                    Tab(text: 'Explore'),
                  ],
                ),

                Expanded(
                  child: TabBarView(
                    children: [
                      /// ================= PACKAGES TAB =================
                      provider.isLoadingPackages
                          ? const Center(
                              child: SpinKitFadingCircle(
                                color: Colors.white,
                                size: 50,
                              ),
                            )
                          : provider.packages.isEmpty
                          ? const Center(
                              child: Text(
                                'No packages available yet',
                                style: TextStyle(color: Colors.white70),
                              ),
                            )
                          : ListView.builder(
                              itemCount: provider.packages.length,
                              itemBuilder: (context, index) =>
                                  PackageCard(provider.packages[index]),
                            ),

                      /// ================= EXPLORE TAB =================
                      const SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            WeatherBlock(),
                            SizedBox(height: 20),
                            OSMMapWidget(),
                            SizedBox(height: 20),
                            HotelSection(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
