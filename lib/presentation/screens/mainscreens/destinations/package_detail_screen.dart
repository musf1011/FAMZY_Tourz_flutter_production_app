import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/booking_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/desstinations_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/info_chip.dart';
import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/seat_count_container.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PackageDetailScreen extends StatelessWidget {
  const PackageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final pkg =  package;
    // final provider = context.watch<DestinationsProvider>();
    // final destination = provider.selectedDestination;
    final destProvider = context.watch<DestinationsProvider>();
    final bookingProvider = context.watch<BookingProvider>();
    final pkg = bookingProvider.package;
    final destination = destProvider.selectedDestination;
    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 HEADER IMAGE
          SizedBox(
            height: 250.h,
            width: double.infinity,
            child: Image.network(pkg!.companyPhotoURL, fit: BoxFit.cover),
          ),

          /// 🔹 CONTENT
          DraggableScrollableSheet(
            initialChildSize: 0.75,
            minChildSize: 0.75,
            maxChildSize: 0.95,
            builder: (_, controller) {
              return Container(
                // padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(destination.image),
                    fit: BoxFit.cover,
                  ),
                  // color: AppConstants.primaryColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50.r),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50.r),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        AppConstants.primaryTransGColor,
                        AppConstants.blackColorP5,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: .center,
                        children: [
                          SizedBox(height: 20.h),

                          /// 🔹 DESTINATION
                          Text(
                            pkg.destination,
                            style: AppConstants.destNameTextStyle,
                            // style: GoogleFonts.playfairDisplay(
                            //   fontSize: 28.sp,
                            //   fontWeight: FontWeight.bold,
                            // ),
                          ),

                          SizedBox(height: 10.h),

                          /// 🔹 PACKAGE NAME
                          Text(
                            pkg.packageName,
                            // style: GoogleFonts.poppins(
                            //   fontSize: 18.sp,
                            //   color: Colors.grey[700],
                            // ),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppConstants.famzyGold,
                            ),
                          ),

                          SizedBox(height: 20.h),

                          Wrap(
                            alignment: .spaceBetween,
                            runAlignment: .spaceBetween,
                            spacing: 20.w,
                            runSpacing: 10.h,
                            children: [
                              infoChip(Icons.calendar_month, pkg.departureDate),
                              infoChip(Icons.timelapse, pkg.departureTime),
                              infoChip(Icons.timeline, pkg.duration),
                              infoChip(Icons.directions_car, pkg.vehicle),
                            ],
                          ),

                          // _infoTile('📅 Date', pkg.departureDate),
                          // _infoTile('⏰ Time', pkg.departureTime),
                          // _infoTile('⛳ Duration', pkg.duration),
                          // _infoTile('📍 Key Spots', pkg.keySpots),
                          // _infoTile('🚗 Vehicle', pkg.vehicle),
                          SizedBox(height: 20.h),

                          /// KEY SPOTS
                          Row(
                            crossAxisAlignment: .center,
                            children: [
                              const Icon(
                                Icons.place,
                                color: AppConstants.famzyGold,
                                size: 18,
                              ),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  pkg.keySpots,
                                  style: TextStyle(
                                    color: AppConstants.whiteColorP9,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Text(
                            '📝 Description',
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: AppConstants.famzyGold,
                            ),
                          ),

                          SizedBox(height: 10.h),

                          Text(
                            pkg.description,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: AppConstants.whiteColorP7,
                            ),
                            textAlign: TextAlign.justify,
                          ),

                          SizedBox(height: 10.h),

                          /// 🔹 SEAT SELECTOR
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       'Seats',
                          //       style: GoogleFonts.poppins(
                          //         fontSize: 18.sp,
                          //         fontWeight: FontWeight.w600,
                          //         color: AppConstants.underline,
                          //       ),
                          //     ),
                          // Row(
                          //   children: [
                          //     IconButton(
                          //       onPressed: () {
                          //         if (seatCount > 1) {
                          //           setState(() => seatCount--);
                          //         }
                          //       },
                          //       icon: const Icon(Icons.remove_circle,color: A,),
                          //     ),
                          //     Text(
                          //       '$seatCount',
                          //       style: GoogleFonts.poppins(fontSize: 18.sp),
                          //     ),
                          //     IconButton(
                          //       onPressed: () {
                          //         if (seatCount < 5) {
                          //           setState(() => seatCount++);
                          //         }
                          //       },
                          //       icon: const Icon(Icons.add_circle),
                          //     ),
                          //   ],
                          // ),
                          SeatCountContainer(provider: bookingProvider),

                          //   ],
                          // ),
                          SizedBox(height: 10.h),

                          /// 🔹 TOTAL PRICE
                          Text(
                            'Total: ${bookingProvider.totalPrice} PKR',
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),

                          SizedBox(height: 10.h),

                          /// 🔹 BOOK BUTTON
                          // SizedBox(
                          //   width: double.infinity,
                          //   height: 50.h,
                          //   child: ElevatedButton(
                          //     onPressed: () {
                          //       // Navigator.pushNamed(
                          //       //   context,
                          //       //   AppRoutes.passengerInfo,
                          //       //   arguments: {
                          //       //     "package": pkg,
                          //       //     "seats": seatCount,
                          //       //   },
                          //       // );
                          //     },
                          //     style: ElevatedButton.styleFrom(
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(12.r),
                          //       ),
                          //     ),
                          //     child: Text(
                          //       'Get Tickets ',
                          //       style: GoogleFonts.poppins(fontSize: 16.sp),
                          //     ),
                          //   ),
                          // ),
                          CustomLoadingButton(
                            onPressed: () {
                              // context.read<BookingProvider>().initialize(
                              //   pkg,
                              //   bookingProvider.seatCount,
                              // );
                              NavigationService().navigateTo(
                                AppRoutes.passengerInfo,
                              );
                            },
                            text: 'Get Tickets   🎫',
                          ),

                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // /// 🔹 BACK BUTTON
          // SafeArea(
          //   child: Padding(
          //     padding: EdgeInsets.all(16.w),
          //     child: CircleAvatar(
          //       backgroundColor: Colors.white,
          //       child: IconButton(
          //         icon: const Icon(Icons.arrow_back),
          //         onPressed: () => Navigator.pop(context),
          //       ),
          //     ),
          //   ),
          // ),
          /// 🔹 CUSTOM BACK BUTTON
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_circle_left_outlined,
                    size: 40.r,
                    color: AppConstants.whiteColorP7,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _infoTile(String title, String value) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 6.h),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           flex: 2,
  //           child: Text(
  //             title,
  //             style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
  //           ),
  //         ),
  //         Expanded(flex: 3, child: Text(value, style: GoogleFonts.poppins())),
  //       ],
  //     ),
  //   );
  // }
}
