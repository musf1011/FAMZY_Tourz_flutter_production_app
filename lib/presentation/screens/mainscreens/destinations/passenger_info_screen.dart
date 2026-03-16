import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/presentation/formatters/cnic_input_formatter.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/user_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/booking_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/desstinations_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_drop_down_field.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_glass_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_text_form_field.dart';
import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/dest_bg_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/seat_count_container.dart';
import 'package:famzy_tourz_v2/presentation/widgets/dialogs/custom_alert_dialogs.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PassengerInfoScreen extends StatefulWidget {
  const PassengerInfoScreen({super.key});

  @override
  State<PassengerInfoScreen> createState() => _PassengerInfoScreenState();
}

class _PassengerInfoScreenState extends State<PassengerInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();
    final destProvider = context.watch<DestinationsProvider>();
    final destination = destProvider.selectedDestination;

    return DestinationBackgroundWrapper(
      imagePath: destination.image,
      titleText: destination.name,

      // child: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// SEAT SELECTOR
              SeatCountContainer(bookingProvider: bookingProvider),

              ...List.generate(bookingProvider.seatCount, (index) {
                final passenger = bookingProvider.controllers[index];

                return CustomGlassWrapper(
                  //  Add  ValueKey
                  key: ValueKey('passenger_$index'),
                  topMargin: 10.h,
                  bottomMargin: 10.h,
                  topPadding: .02.sh,
                  bottomPadding: .02.sh,
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
                        readOnly: index == 0 && bookingProvider.namePrefilled,
                        // passenger['name']!.text.isNotEmpty,
                        validator: (val) =>
                            val == null || val.isEmpty ? 'Required' : null,
                      ),
                      CustomGenderDropdownField(
                        value: passenger['gender']!.text.isEmpty
                            ? null
                            : passenger['gender']!.text.toLowerCase(),
                        onChanged:
                            (index == 0 &&
                                // passenger['gender']!.text.isNotEmpty
                                bookingProvider.genderPrefilled)
                            ? null
                            : (newValue) {
                                if (newValue != null) {
                                  passenger['gender']!.text = newValue;
                                  // You might need a notifyListeners() call in your provider
                                  // if the UI doesn't refresh automatically on select
                                  // bookingProvider.notifyUI();
                                }
                              },

                        validator: (val) => (val == null || val.isEmpty)
                            ? 'Gender required'
                            : null,
                      ),

                      CustTextFormField(
                        label: 'CNIC / Passport',
                        hint: 'Enter ID number',
                        controller: passenger['idPassport'],
                        keyboardType: TextInputType.visiblePassword,
                        readOnly:
                            index == 0 &&
                            // passenger['idPassport']!.text.isNotEmpty,
                            // passenger['idPassport']!.text.length > 13,
                            bookingProvider.idPassportPrefilled,
                        inputFormatters: [IdInputFormatter()],
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'ID required';
                          }

                          // If contains letter → passport (minimum 6 chars)
                          if (RegExp(r'[A-Za-z]').hasMatch(val)) {
                            if (val.length < 6) {
                              return 'Invalid Passport number';
                            }
                            return null;
                          }

                          // Otherwise validate CNIC format
                          if (!RegExp(r'^\d{5}-\d{7}-\d{1}$').hasMatch(val)) {
                            if (val.length < 13) {
                              return 'Invalid CNIC format';
                            }
                          }
                          debugPrint(
                            '**** idPassport textinput validator: ${passenger['idPassport']}',
                          );
                          return null;
                        },
                      ),

                      CustTextFormField(
                        label: 'Age',
                        hint: 'Enter age',
                        controller: passenger['age'],
                        keyboardType: TextInputType.number,
                        readOnly: index == 0 && bookingProvider.agePrefiled,
                        // passenger['age']!.text.isNotEmpty,
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

              Text(
                'Total: ${bookingProvider.totalPrice} PKR',
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

              CustomLoadingButton(
                isLoading: bookingProvider.isSubmitting,
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  final bookingProvider = context.read<BookingProvider>();
                  final userProvider = context.read<UserProvider>();
                  debugPrint(
                    '****submit started validated? ${_formKey.currentState!.validate()}',
                  );
                  //we await the boolean result from your static show method
                  final bool confirmed = await AppConfirmDialog.show(
                    context,
                    title: 'Confirm Booking',
                    message:
                        'Are you sure you want to proceed with the booking for ${bookingProvider.seatCount} passenger(s) with correct information?',
                    confirmText: 'Confirm',
                    cancelText: 'Cancel',
                    confirmColor: AppConstants.famzyGold,
                    icon: Icons.airplane_ticket_outlined,
                  );
                  if (!confirmed) return;
                  debugPrint('****submit started ${userProvider.userId}*** ');
                  final bookingId = await bookingProvider.submitBooking(
                    user: userProvider.user!,
                  );
                  debugPrint('****submit started confirm: $confirmed*** ');
                  if (bookingId != null && context.mounted) {
                    //clear data before proceeding

                    debugPrint('****booking id: $bookingId');
                    debugPrint(
                      '****pass info scr ready to clear booking data ',
                    );
                    context.read<BookingProvider>().clearBookingData();
                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                    await NavigationService().navigateReplacement(
                      AppRoutes.payment,
                      arguments: {
                        'bookingId': bookingId,
                        'packageId': bookingProvider.package!.packageId,
                      },
                    );
                    // });
                  }
                },
                child: const Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
