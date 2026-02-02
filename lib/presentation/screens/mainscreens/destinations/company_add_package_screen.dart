import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/models/package_model.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers.dart/desstinations_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_elevated_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_text_form_field.dart';
import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/dest_bg_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/dialogs/custom_alert_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CompanyAddPackageScreen extends StatefulWidget {
  final String destinationName;
  final String destinationImage;

  const CompanyAddPackageScreen({
    super.key,
    required this.destinationName,
    required this.destinationImage,
  });

  @override
  State<CompanyAddPackageScreen> createState() =>
      _CompanyAddPackageScreenState();
}

class _CompanyAddPackageScreenState extends State<CompanyAddPackageScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? packageName,
      duration,
      date,
      time,
      keySpots,
      vehicle,
      description,
      price;

  bool isLoading = false;
  bool showSuccess = false;
  bool showError = false;

  String generateId(String name, String dest) {
    return '${name.toLowerCase().replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => isLoading = true);

    try {
      final id = generateId(packageName!, widget.destinationName);

      final package = PackageModel(
        id: id,
        packageName: packageName!,
        duration: duration!,
        date: date!,
        time: time!,
        keySpots: keySpots!,
        vehicle: vehicle!,
        description: description!,
        price: price!,
        destination: widget.destinationName,
      );

      await context.read<DestinationsProvider>().addNewPackage(package);

      setState(() => showSuccess = true);
    } catch (e) {
      setState(() => showError = true);
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevents the app from popping immediately
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return; // If the system already handled the pop, do nothing

        // Trigger your custom dialog
        final shouldPop = await AppConfirmDialog.show(
          context,
          title: 'Discard Changes?',
          message:
              'Are you sure you want to leave? Your package details will not be saved.',
          confirmText: 'Discard',
          cancelText: 'Stay',
          isDanger: true,
          icon: Icons.warning_amber_rounded,
        );

        // If user confirms, use the Navigator to leave manually
        if (shouldPop && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Stack(
        children: [
          DestinationBackgroundWrapper(
            imagePath: widget.destinationImage,
            destinationName: 'Add Package\n for ${widget.destinationName}',
            onBackTap: () => Navigator.maybePop(context),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustTextFormField(
                      label: 'Package Name',
                      hint: 'e.g. Summer Special',
                      onChanged: (v) => setState(() {
                        packageName = v;
                      }),
                      onSaved: (v) => packageName = v,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    if (packageName != null && packageName!.isNotEmpty)
                      Text(
                        // 'Tour ID: ${widget.tourID ?? generateTourId(packageName!, widget.destination)}',
                        'Tour ID: ${generateId(packageName!, widget.destinationName)}',

                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                          backgroundColor: const Color.fromARGB(150, 0, 30, 0),
                        ),
                      ),
                    CustTextFormField(
                      label: 'Duration',
                      hint: 'e.g. 3 Days / 2 Nights',
                      onSaved: (v) => duration = v,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    // CustTextFormField(
                    //   label: 'Date',
                    //   hint: 'e.g. 15th Aug 2024',
                    //   onSaved: (v) => date = v,
                    //   validator: (v) => v!.isEmpty ? 'Required' : null,
                    // ),
                    CustTextFormField(
                      label: 'Date',
                      hint: 'YYYY-MM-DD',
                      controller:
                          _dateController, // Use the persistent controller
                      readOnly: true,
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          // barrierColor: Colors.red, //bg app colour
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now(), // Usually tours don't start in the past
                          lastDate: DateTime(2050),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.dark(
                                  primary: AppConstants.underline, // FAMZY Gold
                                  onPrimary: Colors.white,
                                  surface: AppConstants
                                      .secondaryColor, // Dark Surface
                                  onSurface: Colors.white,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppConstants.underline,
                                  ),
                                ),
                                datePickerTheme: DatePickerThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.r),
                                    side: BorderSide(
                                      color: Colors.white,
                                      width: 2.r,
                                    ),
                                  ),
                                ),
                                dialogTheme: const DialogThemeData(
                                  backgroundColor:
                                      AppConstants.primaryTransGColor,
                                ),
                              ),

                              child: child!,
                            );
                          },
                        );

                        if (pickedDate != null) {
                          setState(() {
                            date = DateFormat('yyyy-MM-dd').format(pickedDate);
                            _dateController.text =
                                date!; // Update the UI via controller
                          });
                        }
                      },
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Select a date' : null,
                    ),
                    // CustTextFormField(
                    //   label: 'Time',
                    //   hint: 'e.g. 08:00 AM',
                    //   onSaved: (v) => time = v,
                    //   validator: (v) => v!.isEmpty ? 'Required' : null,
                    // ),
                    CustTextFormField(
                      label: 'Time',
                      hint: '10:00 AM',
                      controller:
                          _timeController, // Use the persistent controller
                      readOnly: true,
                      onTap: () async {
                        final pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.dark(
                                  primary: AppConstants.textColor, // FAMZY Gold
                                  onPrimary: AppConstants.whiteColorP5,
                                  surface: Colors.white,
                                  onSurface: Colors.white,
                                ),
                                // --- ADDED BORDER AND RADIUS HERE ---
                                timePickerTheme: TimePickerThemeData(
                                  backgroundColor: AppConstants.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22.r),
                                    side: const BorderSide(
                                      color: Colors.white,
                                      width: 0.5,
                                    ),
                                  ),
                                  // Styling the dial
                                  dialHandColor: AppConstants.underline,
                                  dialBackgroundColor:
                                      AppConstants.whiteColorP5,
                                  dialTextColor: Colors.white,
                                  hourMinuteTextColor: Colors.white,
                                  hourMinuteShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.r),
                                    side: BorderSide(
                                      color: AppConstants.whiteColorP5,
                                    ),
                                  ),
                                  dayPeriodTextColor: Colors.white,
                                  cancelButtonStyle: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                  confirmButtonStyle: TextButton.styleFrom(
                                    foregroundColor: Colors.green,
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (pickedTime != null) {
                          // ignore: use_build_context_synchronously
                          final formattedTime = pickedTime.format(context);
                          setState(() {
                            time = formattedTime;
                            _timeController.text = time!; // Sync controller
                          });
                        }
                      },
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Enter time' : null,
                    ),
                    CustTextFormField(
                      label: 'Key Spots',
                      hint: 'e.g. Maho dand, Fizza gat',
                      onSaved: (v) => keySpots = v,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    CustTextFormField(
                      label: 'Vehicle',
                      hint: 'e.g. Luxury Bus / SUV',
                      onSaved: (v) => vehicle = v,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    CustTextFormField(
                      label: 'Price',
                      hint: 'e.g. 500',
                      keyboardType: TextInputType.number,
                      onSaved: (v) => price = v,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    CustTextFormField(
                      label: 'Description',
                      hint: 'Tell users about the trip...',
                      maxLines: 4,
                      onSaved: (v) => description = v,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    SizedBox(height: 20.h),
                    CustomElevatedButton(
                      onPressed: submit,
                      child: isLoading
                          ? const SpinKitFadingCircle(
                              color: Colors.white,
                              size: 40,
                            )
                          : Text(
                              'Add Package',
                              style: TextStyle(fontSize: 18.sp),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// SUCCESS ANIMATION
          if (showSuccess)
            _buildLottieOverlay('assets/animations/success.json', () {
              Navigator.pop(context);
            }),

          /// ERROR ANIMATION
          if (showError)
            _buildLottieOverlay('assets/animations/error.json', () {
              setState(() => showError = false);
            }),
        ],
      ),
    );
  }

  Widget _buildLottieOverlay(String path, VoidCallback onEnd) {
    return Container(
      color: Colors.black87,
      child: Center(
        child: Lottie.asset(
          path,
          repeat: false,
          onLoaded: (c) {
            Future.delayed(c.duration, onEnd);
          },
        ),
      ),
    );
  }
}
