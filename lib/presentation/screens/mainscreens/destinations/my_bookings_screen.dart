// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
// import 'package:famzy_tourz_v2/presentation/providers/auth_providers/user_provider.dart';
// import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/user_bookings_provider.dart';
// import 'package:famzy_tourz_v2/routes/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class MyBookingsScreen extends StatelessWidget {
//   const MyBookingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<UserBookingsProvider>();
//     final userId = context.read<UserProvider>().user!.userId;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Bookings', style: AppConstants.appBarTextStyle),
//         backgroundColor: AppConstants.primaryColor,
//       ),
//       backgroundColor: Colors.grey,
//       body: FutureBuilder(
//         future: provider.loadBookings(userId),
//         builder: (_, _) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           return ListView.builder(
//             itemCount: provider.bookings.length,
//             itemBuilder: (_, index) {
//               final booking = provider.bookings[index];
//               // 1. Parse the Date String (e.g., "2026-02-28")
//               // final DateTime departureDate = booking.departureDate;
//               // final DateTime departureTime = booking.departureTime;

//               return Container(
//                 margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: AppConstants.primaryTransGColor,
//                   borderRadius: BorderRadius.circular(15.r),
//                   border: Border.all(
//                     color: AppConstants.whiteColorP5,
//                     width: 0.5.w,
//                   ),
//                 ),
//                 //   child: ListTile(
//                 //     contentPadding: EdgeInsets.symmetric(
//                 //       horizontal: 16.w,
//                 //       vertical: 8.h,
//                 //     ),
//                 //     // Set tileColor to transparent so the Container's color shows through
//                 //     tileColor: Colors.transparent,
//                 //     shape: RoundedRectangleBorder(
//                 //       borderRadius: BorderRadius.circular(15.r),
//                 //     ),

//                 //     title: Text(
//                 //       booking.packageName,
//                 //       style: TextStyle(
//                 //         fontWeight: FontWeight.bold,
//                 //         fontSize: 16.sp,
//                 //       ),
//                 //     ),
//                 //     subtitle: Text(
//                 //       'Status: ${booking.paymentStatus}',
//                 //       style: TextStyle(color: AppConstants.whiteColorP5),
//                 //     ),
//                 //     trailing: booking.paymentStatus == 'pending'
//                 //         ? ElevatedButton(
//                 //             style: ElevatedButton.styleFrom(
//                 //               backgroundColor: AppConstants.primaryColor,
//                 //               shape: RoundedRectangleBorder(
//                 //                 borderRadius: BorderRadius.circular(10.r),
//                 //               ),
//                 //             ),
//                 //             onPressed: () {
//                 //               NavigationService().navigateTo(
//                 //                 AppRoutes.payment,
//                 //                 arguments: booking,
//                 //               );
//                 //             },
//                 //             child: const Text('Pay'),
//                 //           )
//                 //         : Icon(
//                 //             Icons.check_circle,
//                 //             color: Colors.green,
//                 //             size: 24.r,
//                 //           ),
//                 //   ),
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(
//                     horizontal: 16.w,
//                     vertical: 12.h,
//                   ),
//                   tileColor: Colors.transparent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15.r),
//                   ),

//                   title: Text(
//                     booking.packageName,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16.sp,
//                     ),
//                   ),

//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 6.h),

//                       Text(
//                         booking.destinationName,
//                         style: TextStyle(color: AppConstants.whiteColorP5),
//                       ),

//                       SizedBox(height: 4.h),

//                       Text(
//                         'Seats: ${booking.seatCount}',
//                         style: TextStyle(color: AppConstants.whiteColorP5),
//                       ),

//                       SizedBox(height: 4.h),

//                       // Text(
//                       //   'Departure Date/Time: $departureDate- $departureTime',
//                       // ),
//                       Text(
//                         'Amount: Rs ${booking.totalAmount}',
//                         style: TextStyle(color: AppConstants.whiteColorP5),
//                       ),

//                       SizedBox(height: 8.h),

//                       _buildStatusBadge(booking.paymentStatus),
//                     ],
//                   ),

//                   onTap: () {
//                     if (booking.paymentStatus == 'pending') {
//                       NavigationService().navigateTo(
//                         AppRoutes.payment,
//                         arguments: booking.bookingId,
//                       );
//                     } else {
//                       NavigationService().navigateTo(
//                         AppRoutes.packageDetail,
//                         arguments: booking.packageId,
//                       );
//                     }
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildStatusBadge(String status) {
//     Color color;

//     switch (status) {
//       case 'pending':
//         color = Colors.orange;
//         break;
//       case 'submitted':
//         color = Colors.blue;
//         break;
//       case 'paid':
//         color = Colors.green;
//         break;
//       case 'rejected':
//         color = Colors.red;
//         break;
//       default:
//         color = Colors.grey;
//     }

//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//       decoration: BoxDecoration(
//         color: color.withOpacity(
//           .2,
//         ), // 'withOpacity is deprecated and shouldn't be used'
//         borderRadius: BorderRadius.circular(20.r),
//         border: Border.all(color: color),
//       ),
//       child: Text(
//         status.toUpperCase(),
//         style: TextStyle(
//           color: color,
//           fontWeight: FontWeight.bold,
//           fontSize: 12.sp,
//         ),
//       ),
//     );
//   }
// }

// created by: FAMZY CodeWorks
import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/user_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/booking_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/user_bookings_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_background_wrapper.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  bool _initiated = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initiated) {
      _initiated = true;
      final userProvider = context.read<UserProvider>();
      final user = userProvider.user;
      if (user != null) {
        // schedule load after first frame to avoid calling during build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<UserBookingsProvider>().loadBookings(user.userId);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserBookingsProvider>();
    final user = context.watch<UserProvider>().user;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('My Bookings', style: AppConstants.appBarTextStyle),
          backgroundColor: AppConstants.primaryColor,
        ),
        body: const Center(child: Text('Please log in to see your bookings')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings', style: AppConstants.appBarTextStyle),
        backgroundColor: AppConstants.primaryColor,
      ),
      backgroundColor: Colors.grey,
      body: CustomBackgroundWrapper(
        imagePath: 'assets/images/bg-conversation.jpg',
        // // decoration: const BoxDecoration(
        // //   image: DecorationImage(
        // //     image: AssetImage(),
        // //     fit: BoxFit.cover,
        // //   ),
        // // ),
        // child: Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [
        //         AppConstants.primaryTransGColor,
        //         AppConstants.blackColorP5,
        //       ],
        //     ),
        //   ),
        child: provider.isLoading
            ? const Center(child: SpinKitSpinningLines(color: Colors.white))
            : provider.bookings.isEmpty
            ? Center(
                child: Text(
                  'No bookings yet',
                  style: TextStyle(color: Colors.white70, fontSize: 16.sp),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                itemCount: provider.bookings.length,
                itemBuilder: (_, index) {
                  final booking = provider.bookings[index];

                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    // width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppConstants.secondaryTransGColor,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        color: AppConstants.whiteColorP9,
                        width: 0.5.r,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 4.h,
                      ),
                      tileColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),

                      title: Text(
                        booking.packageName,
                        // style: TextStyle(
                        //   fontWeight: FontWeight.bold,
                        //   fontSize: 16.sp,
                        // ),
                        textAlign: .center,
                        style: AppConstants.snackbarTitle,
                      ),

                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6.h),
                          Text(
                            'To: ${booking.destinationName}',
                            style: TextStyle(color: AppConstants.whiteColorP5),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Departure: ${booking.formattedDeparture}',
                            style: TextStyle(color: AppConstants.whiteColorP5),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Seats: ${booking.seatCount}',
                            style: TextStyle(color: AppConstants.whiteColorP5),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Amount: Rs ${booking.totalAmount}',
                            style: TextStyle(color: AppConstants.whiteColorP5),
                          ),
                          SizedBox(height: 8.h),
                          _buildStatusBadge(booking.paymentStatus),
                        ],
                      ),

                      onTap: () async {
                        if (booking.paymentStatus == 'pending' ||
                            booking.paymentStatus == 'resubmit') {
                          debugPrint(
                            '*****pendign and now ready to navigate bookingid: ${booking.bookingId} , ***packageid = ${booking.packageId}',
                          );
                          await NavigationService().navigateTo(
                            AppRoutes.payment,
                            arguments: {
                              'bookingId': booking.bookingId,
                              'packageId': booking.packageId,
                            },
                          );
                        } else {
                          final bookingProvider = context
                              .read<BookingProvider>();

                          await bookingProvider.selectPackageById(
                            booking.packageId,
                            user.userId,
                          );
                          debugPrint(
                            '****_____already booked statue_____****::::${bookingProvider.alreadyBooked}',
                          );
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            NavigationService().navigateTo(
                              AppRoutes.packageDetail,
                            );
                          });
                        }
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;

    switch (status) {
      case 'pending':
        color = AppConstants.famzyGold;
        break;
      case 'submitted':
        color = AppConstants.accentColor;
        break;
      case 'paid':
        color = AppConstants.tertiaryColor;
        break;
      case 'rejected':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .2),
        // color: ,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
