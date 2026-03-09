// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/admin_bookings_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';

// class AdminBookingsScreen extends StatefulWidget {
//   const AdminBookingsScreen({super.key});

//   @override
//   State<AdminBookingsScreen> createState() => _AdminBookingsScreenState();
// }

// class _AdminBookingsScreenState extends State<AdminBookingsScreen> {
//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       if (mounted) {
//         context.read<AdminBookingsProvider>().loadBookings();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<AdminBookingsProvider>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Admin Payment Approval'),
//         backgroundColor: AppConstants.primaryColor,
//       ),

//       body: provider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: provider.bookings.length,
//               itemBuilder: (_, index) {
//                 final booking = provider.bookings[index];

//                 return Container(
//                   margin: EdgeInsets.all(10.w),
//                   padding: EdgeInsets.all(12.w),

//                   decoration: BoxDecoration(
//                     color: AppConstants.primaryTransGColor,
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),

//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         booking.packageName,
//                         style: TextStyle(
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       SizedBox(height: 5.h),

//                       Text('User: ${booking.userName}'),

//                       Text('Amount: Rs ${booking.totalAmount}'),

//                       Text(
//                         "Transaction: ${booking.transactionId.isEmpty ? "Not submitted" : booking.transactionId}",
//                       ),

//                       Text('Status: ${booking.paymentStatus}'),

//                       SizedBox(height: 10.h),

//                       if (booking.paymentStatus == 'submitted')
//                         Row(
//                           children: [
//                             Expanded(
//                               child: ElevatedButton(
//                                 onPressed: () =>
//                                     provider.approve(booking.bookingId),

//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.green,
//                                 ),

//                                 child: const Text('Approve'),
//                               ),
//                             ),

//                             SizedBox(width: 10.w),

//                             Expanded(
//                               child: ElevatedButton(
//                                 onPressed: () =>
//                                     provider.reject(booking.bookingId),

//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.red,
//                                 ),

//                                 child: const Text('Reject'),
//                               ),
//                             ),
//                           ],
//                         ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/models/booking_model.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/admin_bookings_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_background_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_glass_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AdminBookingsScreen extends StatefulWidget {
  const AdminBookingsScreen({super.key});

  @override
  State<AdminBookingsScreen> createState() => _AdminBookingsScreenState();
}

class _AdminBookingsScreenState extends State<AdminBookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // @override
  // void initState() {
  //   super.initState();

  //   _tabController = TabController(length: 4, vsync: this);

  //   Future.microtask(() {
  //     if (mounted) {
  //       context.read<AdminBookingsProvider>().loadBookings();
  //     }
  //   });
  // }
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);

    Future.microtask(() {
      if (mounted) {
        context.read<AdminBookingsProvider>().startListening();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminBookingsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Payments', style: AppConstants.appBarTextStyle),

        backgroundColor: AppConstants.primaryColor,
        shadowColor: AppConstants.secondaryColor,

        bottom: TabBar(
          // dividerColor: AppConstants.whiteColorP9,
          overlayColor: WidgetStateProperty.all(AppConstants.famzyGold),
          // dividerHeight: 100,
          // isScrollable: true,
          tabAlignment: .center,
          indicatorColor: AppConstants.famzyGold,
          labelColor: AppConstants.whiteColorP9,
          unselectedLabelColor: AppConstants.whiteColorP5,
          controller: _tabController,
          // dividerColor: Colors.red,
          dividerHeight: 1,
          tabs: const [
            Tab(text: 'Submitted'),

            Tab(text: 'Pending'),

            Tab(text: 'Paid'),

            Tab(text: 'Rejected'),
          ],
        ),
      ),

      body: CustomBackgroundWrapper(
        imagePath: 'assets/images/bg-conversation.jpg',
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                controller: _tabController,

                children: [
                  _buildList(provider.submitted),

                  _buildList(provider.pending),

                  _buildList(provider.paid),

                  _buildList(provider.rejected),
                ],
              ),
      ),
    );
  }

  Widget _buildList(List<BookingModel> list) {
    if (list.isEmpty) {
      return const Center(child: Text('No bookings'));
    }

    final provider = context.read<AdminBookingsProvider>();

    return ListView.builder(
      itemCount: list.length,

      itemBuilder: (_, index) {
        final booking = list[index];

        // return Container(
        //   margin: EdgeInsets.all(10.w),

        //   padding: EdgeInsets.all(12.w),

        //   decoration: BoxDecoration(
        //     border: Border.all(color: AppConstants.whiteColorP5, width: .5.r),
        //     color: AppConstants.secondaryTransGColor,
        //     borderRadius: BorderRadius.circular(12.r),
        //   ),
        return CustomGlassWrapper(
          // height: .25.sh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${booking.packageName} (${booking.companyName}) (${booking.destinationName})',
                style: AppConstants.snackbarTitle,
                textAlign: .center,
              ),

              SizedBox(height: 5.h),

              CustomText(
                text: 'User: ${booking.userName}',
                color: AppConstants.whiteColorP5,
              ),
              SizedBox(height: 4.h),
              CustomText(
                text: 'Amount: Rs ${booking.totalAmount}',
                color: AppConstants.whiteColorP5,
              ),
              SizedBox(height: 4.h),
              CustomText(
                text:
                    "Transaction: ${booking.transactionId.isEmpty ? "Not submitted" : booking.transactionId}",
                color: AppConstants.whiteColorP5,
              ),
              SizedBox(height: 4.h),
              CustomText(
                text: 'Status: ${booking.paymentStatus}',
                color: AppConstants.whiteColorP5,
              ),

              SizedBox(height: 10.h),

              if (booking.paymentStatus == 'submitted')
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            provider.approve(context, booking.bookingId),

                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.lightGreen,
                        ),

                        child: const Text('Approve'),
                      ),
                    ),

                    SizedBox(width: 10.w),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => provider.reject(booking.bookingId),

                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.lightRed,
                        ),
                        child: const Text('Reject'),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
