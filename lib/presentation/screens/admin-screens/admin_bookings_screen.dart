// // import 'package:famzy_tourz_v2/constants.dart';
// // import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/admin_bookings_provider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:provider/provider.dart';

// // class AdminBookingsScreen extends StatefulWidget {
// //   const AdminBookingsScreen({super.key});

// //   @override
// //   State<AdminBookingsScreen> createState() => _AdminBookingsScreenState();
// // }

// // class _AdminBookingsScreenState extends State<AdminBookingsScreen> {
// //   @override
// //   void initState() {
// //     super.initState();

// //     Future.microtask(() {
// //       if (mounted) {
// //         context.read<AdminBookingsProvider>().loadBookings();
// //       }
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final provider = context.watch<AdminBookingsProvider>();

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Admin Payment Approval'),
// //         backgroundColor: AppConstants.primaryColor,
// //       ),

// //       body: provider.isLoading
// //           ? const Center(child: CircularProgressIndicator())
// //           : ListView.builder(
// //               itemCount: provider.bookings.length,
// //               itemBuilder: (_, index) {
// //                 final booking = provider.bookings[index];

// //                 return Container(
// //                   margin: EdgeInsets.all(10.w),
// //                   padding: EdgeInsets.all(12.w),

// //                   decoration: BoxDecoration(
// //                     color: AppConstants.primaryTransGColor,
// //                     borderRadius: BorderRadius.circular(12.r),
// //                   ),

// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         booking.packageName,
// //                         style: TextStyle(
// //                           fontSize: 18.sp,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),

// //                       SizedBox(height: 5.h),

// //                       Text('User: ${booking.userName}'),

// //                       Text('Amount: Rs ${booking.totalAmount}'),

// //                       Text(
// //                         "Transaction: ${booking.transactionId.isEmpty ? "Not submitted" : booking.transactionId}",
// //                       ),

// //                       Text('Status: ${booking.paymentStatus}'),

// //                       SizedBox(height: 10.h),

// //                       if (booking.paymentStatus == 'submitted')
// //                         Row(
// //                           children: [
// //                             Expanded(
// //                               child: ElevatedButton(
// //                                 onPressed: () =>
// //                                     provider.approve(booking.bookingId),

// //                                 style: ElevatedButton.styleFrom(
// //                                   backgroundColor: Colors.green,
// //                                 ),

// //                                 child: const Text('Approve'),
// //                               ),
// //                             ),

// //                             SizedBox(width: 10.w),

// //                             Expanded(
// //                               child: ElevatedButton(
// //                                 onPressed: () =>
// //                                     provider.reject(booking.bookingId),

// //                                 style: ElevatedButton.styleFrom(
// //                                   backgroundColor: Colors.red,
// //                                 ),

// //                                 child: const Text('Reject'),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                     ],
// //                   ),
// //                 );
// //               },
// //             ),
// //     );
// //   }
// // }

// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:famzy_tourz_v2/data/models/booking_model.dart';
// import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/admin_bookings_provider.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/custom_background_wrapper.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/custom_glass_wrapper.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';

// class AdminBookingsScreen extends StatefulWidget {
//   const AdminBookingsScreen({super.key});

//   @override
//   State<AdminBookingsScreen> createState() => _AdminBookingsScreenState();
// }

// class _AdminBookingsScreenState extends State<AdminBookingsScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   // @override
//   // void initState() {
//   //   super.initState();

//   //   _tabController = TabController(length: 4, vsync: this);

//   //   Future.microtask(() {
//   //     if (mounted) {
//   //       context.read<AdminBookingsProvider>().loadBookings();
//   //     }
//   //   });
//   // }
//   @override
//   void initState() {
//     super.initState();

//     _tabController = TabController(length: 4, vsync: this);

//     Future.microtask(() {
//       if (mounted) {
//         context.read<AdminBookingsProvider>().startListening();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<AdminBookingsProvider>();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Payments', style: AppConstants.appBarTextStyle),

//         backgroundColor: AppConstants.primaryColor,
//         shadowColor: AppConstants.secondaryColor,

//         bottom: TabBar(
//           // dividerColor: AppConstants.whiteColorP9,
//           overlayColor: WidgetStateProperty.all(AppConstants.famzyGold),
//           // dividerHeight: 100,
//           // isScrollable: true,
//           tabAlignment: .center,
//           indicatorColor: AppConstants.famzyGold,
//           labelColor: AppConstants.whiteColorP9,
//           unselectedLabelColor: AppConstants.whiteColorP5,
//           controller: _tabController,
//           // dividerColor: Colors.red,
//           dividerHeight: 1,
//           tabs: const [
//             Tab(text: 'Submitted'),

//             Tab(text: 'Pending'),

//             Tab(text: 'Paid'),

//             Tab(text: 'Rejected'),
//           ],
//         ),
//       ),

//       body: CustomBackgroundWrapper(
//         imagePath: 'assets/images/bg-conversation.jpg',
//         child: provider.isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : TabBarView(
//                 controller: _tabController,

//                 children: [
//                   _buildList(provider.submitted, 'submitted'),

//                   _buildList(provider.pending, 'pending'),

//                   _buildList(provider.paid, 'paid'),

//                   _buildList(provider.rejected, 'rejected'),
//                 ],
//               ),
//       ),
//     );
//   }

//   Widget _buildList(List<BookingModel> list, String statusKey) {
//     if (list.isEmpty) {
//       return Center(
//         key: ValueKey('empty_$statusKey'),
//         child: const Text('No bookings'),
//       );
//     }

//     // final provider = context.read<AdminBookingsProvider>();

//     return ListView.builder(
//       key: ValueKey('list_$statusKey'),
//       itemCount: list.length,

//       itemBuilder: (_, index) {
//         final booking = list[index];

//         // return Container(
//         //   margin: EdgeInsets.all(10.w),

//         //   padding: EdgeInsets.all(12.w),

//         //   decoration: BoxDecoration(
//         //     border: Border.all(color: AppConstants.whiteColorP5, width: .5.r),
//         //     color: AppConstants.secondaryTransGColor,
//         //     borderRadius: BorderRadius.circular(12.r),
//         //   ),
//         return CustomGlassWrapper(
//           key: ValueKey(booking.bookingId),
//           // height: .25.sh,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '${booking.packageName} (${booking.companyName}) (${booking.destinationName})',
//                 style: AppConstants.snackbarTitle,
//                 textAlign: .center,
//               ),

//               SizedBox(height: 5.h),

//               CustomText(
//                 text: 'User: ${booking.userName}',
//                 color: AppConstants.whiteColorP5,
//               ),
//               SizedBox(height: 4.h),
//               CustomText(
//                 text: 'Amount: Rs ${booking.totalAmount}',
//                 color: AppConstants.whiteColorP5,
//               ),
//               SizedBox(height: 4.h),
//               CustomText(
//                 text:
//                     "Transaction: ${booking.transactionId.isEmpty ? "Not submitted" : booking.transactionId}",
//                 color: AppConstants.whiteColorP5,
//               ),
//               SizedBox(height: 4.h),
//               CustomText(
//                 text: 'Status: ${booking.paymentStatus}',
//                 color: AppConstants.whiteColorP5,
//               ),

//               SizedBox(height: 10.h),

//               if (booking.paymentStatus == 'submitted')
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () => provider.approve(
//                           context,
//                           booking.bookingId,
//                           booking.packageId,
//                         ),

//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppConstants.lightGreen,
//                         ),

//                         child: const Text('Approve'),
//                       ),
//                     ),

//                     SizedBox(width: 10.w),

//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () => provider.reject(
//                           booking.bookingId,
//                           booking.packageId,
//                         ),

//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppConstants.lightRed,
//                         ),
//                         child: const Text('Reject'),
//                       ),
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/models/booking_model.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/admin_bookings_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_action_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_background_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_glass_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_text.dart';
import 'package:famzy_tourz_v2/presentation/widgets/dialogs/custom_app_confirm_dialog.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    // Start listening to the realtime stream
    Future.microtask(() {
      if (mounted) {
        context.read<AdminBookingsProvider>().startListening();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Using watch here ensures the build method triggers whenever notifyListeners() is called
    final provider = context.watch<AdminBookingsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Payments', style: AppConstants.appBarTextStyle),
        backgroundColor: AppConstants.primaryColor,
        shadowColor: AppConstants.secondaryColor,
        bottom: TabBar(
          overlayColor: WidgetStateProperty.all(AppConstants.famzyGold),
          // tabAlignment: TabAlignment.center,
          indicatorColor: AppConstants.famzyGold,
          labelColor: AppConstants.whiteColorP9,
          unselectedLabelColor: AppConstants.whiteColorP5,
          controller: _tabController,
          isScrollable: true,
          // dividerHeight: 1.h,
          tabs: const [
            Tab(text: 'Submitted'),
            Tab(text: 'Resubmit'),
            Tab(text: 'Pending'),
            Tab(text: 'Paid'),
            Tab(text: 'Rejected'),
          ],
        ),
      ),
      body: CustomBackgroundWrapper(
        imagePath: AppConstants.bookingsScreenBgImage,
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                controller: _tabController,
                children: [
                  _buildList(provider.submitted, 'submitted', provider),
                  _buildList(provider.resubmit, 'resubmit', provider),
                  _buildList(provider.pending, 'pending', provider),
                  _buildList(provider.paid, 'paid', provider),
                  _buildList(provider.rejected, 'rejected', provider),
                ],
              ),
      ),
    );
  }

  Widget _buildList(
    List<BookingModel> list,
    String statusKey,
    AdminBookingsProvider provider,
  ) {
    if (list.isEmpty) {
      return Center(
        key: ValueKey('empty_$statusKey'),
        child: const Text('No bookings', style: TextStyle(color: Colors.white)),
      );
    }

    return ListView.builder(
      key: ValueKey(
        'list_$statusKey',
      ), // Forces list refresh when status changes
      itemCount: list.length,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      itemBuilder: (_, index) {
        final booking = list[index];

        return CustomGlassWrapper(
          topPadding: 5.h,
          bottomPadding: 5.h,
          key: ValueKey(booking.bookingId), // Ensures stable widget identity
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${booking.packageName} (${booking.companyName})',
                style: AppConstants.snackbarTitle,
              ),
              Text(
                'Destination: ${booking.destinationName}',
                style: TextStyle(
                  color: AppConstants.famzyGold,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 8.h),
              CustomText(
                text: 'User: ${booking.userName}',
                color: AppConstants.whiteColorP5,
              ),
              CustomText(
                text: 'Amount: Rs ${booking.totalAmount}',
                color: AppConstants.whiteColorP5,
              ),
              CustomText(
                text:
                    "Transaction: ${booking.transactionId.isEmpty ? "Not submitted" : booking.transactionId}",
                color: AppConstants.whiteColorP5,
              ),
              CustomText(
                text: 'Status: ${booking.paymentStatus.toUpperCase()}',
                color: AppConstants.whiteColorP9,
              ),
              // SizedBox(height: 10.h),
              // Only show action buttons for 'submitted' status
              if (booking.paymentStatus == 'submitted')
                // Row(
                //   children: [
                //     Expanded(
                //       child: ElevatedButton(
                //         onPressed: () async {
                //           final confirmed = await AppConfirmDialog.show(
                //             context,
                //             iconColor: AppConstants.lightGreen,
                //             title: 'Confirm Approval',
                //             message:
                //                 'Are you sure you want to approve this booking for ${booking.userName}? This will reserve ${booking.seatCount} seats.',
                //             confirmText: 'Approve',
                //             confirmColor: AppConstants.famzyGold,
                //             icon: Icons.check_circle,
                //           );
                //           if (!mounted) return;
                //           if (confirmed) {
                //             await provider.approve(
                //               context,
                //               booking.bookingId,
                //               booking.packageId,
                //             );
                //           }
                //         },
                //         style: ElevatedButton.styleFrom(
                //           backgroundColor: AppConstants.lightGreen,
                //         ),
                //         child: const Text('Approve'),
                //       ),
                //     ),
                //     SizedBox(width: 10.w),
                //     Expanded(
                //       child: ElevatedButton(
                //         onPressed: () async {
                //           final retryValidId = await AppConfirmDialog.show(
                //             context,
                //             icon: Icons.change_circle,
                //             title: 'Request Resubmit',
                //             message:
                //                 'Do you want to ask the user to submit a valid ID again?',
                //             // isDanger: true,
                //             cancelText: 'Cancel',
                //             // cancelColor: AppConstants.famzyGold,
                //             confirmText: 'Request Resubmit',
                //           );
                //           if (!mounted) return;
                //           if (retryValidId) {
                //             await provider.reject(
                //               booking.bookingId,
                //               booking.packageId,
                //               false,
                //             );
                //           }
                //         },
                //         style: ElevatedButton.styleFrom(
                //           backgroundColor: AppConstants.famzyGold,
                //         ),
                //         child: const Text('Retry valid ID'),
                //       ),
                //     ),
                //     SizedBox(width: 10.w),
                //     Expanded(
                //       child: ElevatedButton(
                //         onPressed: () async {
                //           final permanentRejected = await AppConfirmDialog.show(
                //             context,
                //             icon: Icons.cancel,
                //             title: 'Reject Payment',
                //             message:
                //                 'Do you want to permanently reject this Transaction?',
                //             iconColor: AppConstants.lightRed,
                //             cancelText: 'Cancel',
                //             // cancelColor: AppConstants.famzyGold,
                //             confirmText: 'Permanent Reject',
                //           );
                //           if (!mounted) return;
                //           if (permanentRejected) {
                //             await provider.reject(
                //               booking.bookingId,
                //               booking.packageId,
                //               true,
                //             );
                //           }
                //         },
                //         style: ElevatedButton.styleFrom(
                //           backgroundColor: AppConstants.lightRed,
                //         ),
                //         child: const Text('Reject'),
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    FamzyButton(
                      label: 'Approve',
                      color: AppConstants.lightGreen,
                      onPressed: () => _handleAction(
                        context,
                        provider,
                        title: 'Confirm Approval',
                        message:
                            'Are you sure you want to approve this booking for ${booking.userName}? This will reserve ${booking.seatCount} seats.',
                        confirmText: 'Approve',
                        icon: Icons.check_circle,
                        action: () => provider.approve(
                          context,
                          booking.bookingId,
                          booking.packageId,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    FamzyButton(
                      label: 'Retry ID',
                      color: AppConstants.famzyGold,
                      onPressed: () => _handleAction(
                        context,
                        provider,
                        title: 'Request Resubmit',
                        message:
                            'Do you want to ask the user to submit a valid ID again?',
                        confirmText: 'Request Resubmit',
                        icon: Icons.change_circle,
                        action: () => provider.reject(
                          booking.bookingId,
                          booking.packageId,
                          false,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    FamzyButton(
                      label: 'Reject',
                      color: AppConstants.lightRed,
                      onPressed: () => _handleAction(
                        context,
                        provider,
                        title: 'Reject Payment',
                        message:
                            'Do you want to permanently reject this Transaction?',
                        confirmText: 'Permanent Reject',
                        icon: Icons.cancel,
                        iconColor: AppConstants.lightRed,
                        action: () => provider.reject(
                          booking.bookingId,
                          booking.packageId,
                          true,
                        ),
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

  Future<void> _handleAction(
    BuildContext context,
    AdminBookingsProvider provider, {
    required String title,
    required String message,
    required String confirmText,
    required IconData icon,
    required Future<void> Function() action,
    Color? iconColor,
  }) async {
    final confirmed = await AppConfirmDialog.show(
      context,
      title: title,
      message: message,
      confirmText: confirmText,
      icon: icon,
      confirmColor: AppConstants.famzyGold,
      // iconColor: iconColor, // Use if your dialog supports it
    );

    if (confirmed && mounted) {
      await action();
    }
  }
}
