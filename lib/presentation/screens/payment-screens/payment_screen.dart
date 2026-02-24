// created by: FAMZY CodeWorks

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/presentation/formatters/transaction_id_formatter.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/desstinations_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/payment_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/main_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_text_form_field.dart';
import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/dest_bg_wrapper.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  final String bookingId;
  final _formKey = GlobalKey<FormState>();
  PaymentScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    final paymentProvider = context.watch<PaymentProvider>();
    final destProvider = context.read<DestinationsProvider>();

    return DestinationBackgroundWrapper(
      imagePath: destProvider.selectedDestination.image,
      titleText: 'Complete Payment',
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            /// TITLE
            Text(
              'Pay with NayaPay',
              style: TextStyle(
                fontSize: 24.sp,
                color: AppConstants.famzyGold,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20.h),

            /// QR IMAGE (SVG)
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Image.asset(
                'assets/payment/nayapay_qr.jpeg',
                height: 250.h,
              ),
            ),

            SizedBox(height: 20.h),

            /// INSTRUCTIONS
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppConstants.primaryTransGColor,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppConstants.whiteColorP5,
                  width: .5.r,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instructions:',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppConstants.famzyGold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  instruction('Open NayaPay App'),
                  instruction('Tap Scan & Pay'),
                  instruction('Scan QR Code'),
                  instruction('Send Payment'),
                  instruction('Enter Transaction ID below'),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            /// TRANSACTION FIELD
            Form(
              key: _formKey,
              child: CustTextFormField(
                label: 'Transactin ID',
                hint: 'Enter Transaction ID',
                controller: paymentProvider.transactionController,
                keyboardType: TextInputType.visiblePassword,
                inputFormatters: [
                  // UpperCaseTextFormatter(),
                  TransactionIdFormatter(),
                  LengthLimitingTextInputFormatter(35),
                ],
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Transaction ID is required';
                  }
                  if (val.length < 6) {
                    return 'Please enter a valid ID';
                  }
                  if (!RegExp(r'^[A-Z0-9]+$').hasMatch(val)) {
                    return 'ID can only contain letters and numbers';
                  }
                  return null;
                },
              ),
            ),

            SizedBox(height: 30.h),

            /// SUBMIT BUTTON
            CustomLoadingButton(
              isLoading: paymentProvider.isSubmitting,
              text: 'Confirm Payment',
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await paymentProvider.submitTransaction(bookingId);

                  // Only navigate if the context is still valid
                  if (context.mounted) {
                    // Force the provider to index 1 (Destinations)
                    // context.read<MainProvider>().setTab(1);
                    context.read<MainProvider>().resetToHome(1);
                    await NavigationService().navigateAndClearStack(
                      AppRoutes.main,
                    );
                  }
                }
              },
            ),

            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget instruction(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(text, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
