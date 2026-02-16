import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/user_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/booking_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/desstinations_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_glass_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_text_form_field.dart';
import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/dest_bg_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/seat_count_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PassengerInfoScreen extends StatelessWidget {
  const PassengerInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();
    final provider = context.watch<DestinationsProvider>();
    // final pkg = provider.selectedPackage;
    final destination = provider.selectedDestination;
    // final pkg = bookingProvider.package!;

    return DestinationBackgroundWrapper(
      imagePath: destination.image,
      titleText: destination.name,

      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              /// SEAT SELECTOR
              SeatCountContainer(provider: bookingProvider),

              // // / PASSENGER FORMS
              // ...List.generate(bookingProvider.seatCount, (index) {
              //   final passenger = bookingProvider.controllers[index];
              //   return Container(
              //     decoration: BoxDecoration(color: AppConstants.primaryColor),
              //     child: Column(
              //       children: [
              //         TextField(
              //           controller: passenger['name'],
              //           decoration: const InputDecoration(
              //             labelText: 'Full Name',
              //           ),
              //         ),

              //         TextField(
              //           controller: passenger['gender'],
              //           decoration: const InputDecoration(labelText: 'Gender'),
              //         ),

              //         TextField(
              //           controller: passenger['id'],
              //           decoration: const InputDecoration(
              //             labelText: 'ID Number',
              //           ),
              //         ),

              //         TextField(
              //           controller: passenger['age'],
              //           decoration: const InputDecoration(labelText: 'Age'),
              //           keyboardType: TextInputType.number,
              //         ),

              //         SizedBox(height: 20.h),
              //       ],
              //     ),
              //   );
              // }),
              ...List.generate(bookingProvider.seatCount, (index) {
                final passenger = bookingProvider.controllers[index];

                // return Container(
                //   margin: EdgeInsets.only(bottom: 20.h),
                //   padding: EdgeInsets.all(16.w),
                //   decoration: BoxDecoration(
                //     color: AppConstants.primaryTransGColor,
                //     borderRadius: BorderRadius.circular(12.r),
                //     border: Border.all(color: AppConstants.whiteColorP5),
                //   ),
                return CustomGlassWrapper(
                  margin: 10.h,
                  verticalPadding: .02.sh,
                  child: Column(
                    children: [
                      Text(
                        'Passenger ${index + 1}',
                        style: TextStyle(color: AppConstants.whiteColorP5),
                      ),
                      CustTextFormField(
                        label: 'Full Name',
                        hint: 'Enter full name',
                        controller: passenger['name'],
                        validator: (val) =>
                            val == null || val.isEmpty ? 'Required' : null,
                      ),

                      CustTextFormField(
                        label: 'Gender',
                        hint: 'Male / Female',
                        controller: passenger['gender'],
                        validator: (val) =>
                            val == null || val.isEmpty ? 'Required' : null,
                      ),

                      CustTextFormField(
                        label: 'CNIC / Passport',
                        hint: 'Enter ID number',
                        controller: passenger['id'],
                        keyboardType: TextInputType.number,
                        validator: (val) =>
                            val == null || val.isEmpty ? 'Required' : null,
                      ),

                      CustTextFormField(
                        label: 'Age',
                        hint: 'Enter age',
                        controller: passenger['age'],
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Required';
                          }
                          final age = int.tryParse(val);
                          if (age == null || age < 1 || age > 120) {
                            return 'Invalid age';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                );
              }),

              // /// TOTAL
              // Text('Total: ${bookingProvider.totalPrice} PKR'),
              // SizedBox(height: 20.h),
              /// 🔹 TOTAL PRICE
              Text(
                'Total: ${bookingProvider.totalPrice} PKR',
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

              /// BOOK BUTTON
              CustomLoadingButton(
                isLoading: bookingProvider.isSubmitting,
                onPressed: () async {
                  final userId = context.read<UserProvider>().user!.userId;

                  await bookingProvider.submitBooking(userId);

                  // // Navigation here (UI responsibility)
                  // Navigator.pushReplacementNamed(
                  //   context,
                  //   AppRoutes.main,
                  // );
                  // await NavigationService().navigateReplacement(AppRoutes.main);
                  debugPrint('***pressssedd button book nowww');
                },
                text: 'Book Now 🎟️',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
