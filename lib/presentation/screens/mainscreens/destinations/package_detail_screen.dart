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
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PackageDetailScreen extends StatelessWidget {
  const PackageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

                          SeatCountContainer(bookingProvider: bookingProvider),

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

                          bookingProvider.checkingBooking
                              ? const SpinKitSpinningLines(color: Colors.white)
                              : CustomLoadingButton(
                                  onPressed: bookingProvider.alreadyBooked
                                      ? () {}
                                      : () {
                                          NavigationService().navigateTo(
                                            AppRoutes.passengerInfo,
                                          );
                                        },
                                  text: bookingProvider.alreadyBooked
                                      ? 'Already Booked 🎫'
                                      : 'Get Tickets 🎫',
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
                  onPressed: () => NavigationService().pop(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
