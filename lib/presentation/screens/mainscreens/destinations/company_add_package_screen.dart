// //created by: FAMZY CodeWorks
// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:famzy_tourz_v2/data/models/package_model.dart';
// import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
// import 'package:famzy_tourz_v2/presentation/providers/destinations_providers.dart/add_package_provider.dart';
// import 'package:famzy_tourz_v2/presentation/providers/destinations_providers.dart/desstinations_provider.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/custom_elevated_button.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/custom_text_form_field.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/dest_bg_wrapper.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/dialogs/custom_alert_dialogs.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/lottie_overlay.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';

// class CompanyAddPackageScreen extends StatefulWidget {
//   const CompanyAddPackageScreen({super.key});

//   @override
//   State<CompanyAddPackageScreen> createState() =>
//       _CompanyAddPackageScreenState();
// }

// class _CompanyAddPackageScreenState extends State<CompanyAddPackageScreen> {
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _timeController = TextEditingController();

//   @override
//   void dispose() {
//     _dateController.dispose();
//     _timeController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final destProvider = context.watch<DestinationsProvider>();
//     final packageProvider = context.watch<AddPackageProvider>();
//     final destination = destProvider.selectedDestination;
//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (bool didPop, dynamic result) async {
//         if (didPop) return;
//         //trigger custom dialog
//         final shouldPop = await AppConfirmDialog.show(
//           context,
//           title: 'Discard Changes?',
//           message:
//               'Are you sure you want to leave? Your package details will not be saved.',
//           confirmText: 'Discard',
//           cancelText: 'Stay',
//           isDanger: true,
//           icon: Icons.warning_amber_rounded,
//         );
//         // If user confirms, use the Navigator to leave
//         if (shouldPop && context.mounted) {
//           NavigationService().pop();
//         }
//       },
//       child: Stack(
//         children: [
//           // DestinationBackgroundWrapper(
//           //   imagePath: destination.image,
//           //   destinationName: 'Add Package\n for ${destination.name}',
//           //   onBackTap: () => NavigationService().maybePop(),
//           //   child: SingleChildScrollView(
//           //     padding: EdgeInsets.all(16.w),
//           //     child: Form(
//           //       key: packageProvider.formKey,
//           //       child: Column(
//           //         children: [
//           //           CustTextFormField(
//           //             label: 'Package Name',
//           //             hint: 'e.g. Summer Special',
//           //             onChanged: (v) => setState(() {
//           //               packageProvider.packageName = v;
//           //             }),
//           //             onSaved: (v) => packageProvider.packageName = v,
//           //             validator: (v) => v!.isEmpty ? 'Required' : null,
//           //           ),
//           //           if (packageProvider.packageName != null && packageProvider.packageName!.isNotEmpty)
//           //             Text(
//           //               'Tour ID: ${packageProvider.generateId(packageName!,destination.name)}',

//           //               style: TextStyle(
//           //                 fontSize: 12.sp,
//           //                 color: Colors.white,
//           //                 backgroundColor: const Color.fromARGB(150, 0, 30, 0),
//           //               ),
//           //             ),
//            DestinationBackgroundWrapper(
//             imagePath: destination.image,
//             destinationName:
//                 '${packageProvider.isEditMode ? 'Edit' : 'Add'} Package\nfor ${destination.name}',
//             onBackTap: () => NavigationService().maybePop(),
//             child: SingleChildScrollView(
//               padding: EdgeInsets.all(16.w),
//               child: Form(
//                 key: packageProvider.formKey,
//                 child: Column(
//                   children: [
//                     CustTextFormField(
//                       label: 'Package Name',
//                       hint: 'e.g. Summer Special',
//                       initialValue: packageProvider.packageName,
//                       onSaved: (v) =>
//                           packageProvider.packageName = v ?? '',
//                       validator: (v) =>
//                           v == null || v.isEmpty ? z'Required' : null,
//                     ),z
//                     // CustTextFormField(
//                     //   label: 'Duration',
//                     //
//                     //   onSaved: (v) => packageProvider.duration = v!,
//                     //   validator: (v) => v!.isEmpty ? 'Required' : null,
//                     // ),
//                     CustTextFormField(
//                       label: 'Duration',hint: 'e.g. 3 Days / 2 Nights',
//                       initialValue: packageProvider.duration,
//                       onSaved: (v) =>
//                           packageProvider.duration = v ?? '',
//                       validator: (v) => v!.isEmpty ? 'Required' : null,
//                     ),
//                     CustTextFormField(
//                       label: 'Date',
//                       hint: 'YYYY-MM-DD',
//                       controller:
//                           _dateController, // Use the persistent controller
//                       readOnly: true,
//                       onTap: () async {
//                         final pickedDate = await showDatePicker(
//                           // barrierColor: Colors.red, //bg app colour
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate:
//                               DateTime.now(), // Usually tours don't start in the past
//                           lastDate: DateTime(2050),
//                           builder: (context, child) {
//                             return Theme(
//                               data: Theme.of(context).copyWith(
//                                 colorScheme: const ColorScheme.dark(
//                                   primary: AppConstants.underline, // FAMZY Gold
//                                   onPrimary: Colors.white,
//                                   surface: AppConstants
//                                       .secondaryColor, // Dark Surface
//                                   onSurface: Colors.white,
//                                 ),
//                                 textButtonTheme: TextButtonThemeData(
//                                   style: TextButton.styleFrom(
//                                     foregroundColor: AppConstants.underline,
//                                   ),
//                                 ),
//                                 datePickerTheme: DatePickerThemeData(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(50.r),
//                                     side: BorderSide(
//                                       color: Colors.white,
//                                       width: 2.r,
//                                     ),
//                                   ),
//                                 ),
//                                 dialogTheme: const DialogThemeData(
//                                   backgroundColor:
//                                       AppConstants.primaryTransGColor,
//                                 ),
//                               ),

//                               child: child!,
//                             );
//                           },
//                         );

//                         if (pickedDate != null) {
//                           setState(() {
//                             date = DateFormat('yyyy-MM-dd').format(pickedDate);
//                             _dateController.text =
//                                 date!; // Update the UI via controller
//                           });
//                         }
//                       },
//                       validator: (val) =>
//                           val == null || val.isEmpty ? 'Select a date' : null,
//                     ),
//                     CustTextFormField(
//                       label: 'Time',
//                       hint: '10:00 AM',
//                       controller:
//                           _timeController, // Use the persistent controller
//                       readOnly: true,
//                       onTap: () async {
//                         final pickedTime = await showTimePicker(
//                           context: context,
//                           initialTime: TimeOfDay.now(),
//                           builder: (context, child) {
//                             return Theme(
//                               data: Theme.of(context).copyWith(
//                                 colorScheme: ColorScheme.dark(
//                                   primary: AppConstants.textColor, // FAMZY Gold
//                                   onPrimary: AppConstants.whiteColorP5,
//                                   surface: Colors.white,
//                                   onSurface: Colors.white,
//                                 ),
//                                 // --- ADDED BORDER AND RADIUS HERE ---
//                                 timePickerTheme: TimePickerThemeData(
//                                   backgroundColor: AppConstants.secondaryColor,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(22.r),
//                                     side: const BorderSide(
//                                       color: Colors.white,
//                                       width: 0.5,
//                                     ),
//                                   ),
//                                   // Styling the dial
//                                   dialHandColor: AppConstants.underline,
//                                   dialBackgroundColor:
//                                       AppConstants.whiteColorP5,
//                                   dialTextColor: Colors.white,
//                                   hourMinuteTextColor: Colors.white,
//                                   hourMinuteShape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(50.r),
//                                     side: BorderSide(
//                                       color: AppConstants.whiteColorP5,
//                                     ),
//                                   ),
//                                   dayPeriodTextColor: Colors.white,
//                                   cancelButtonStyle: TextButton.styleFrom(
//                                     foregroundColor: Colors.red,
//                                   ),
//                                   confirmButtonStyle: TextButton.styleFrom(
//                                     foregroundColor: Colors.green,
//                                   ),
//                                 ),
//                               ),
//                               child: child!,
//                             );
//                           },
//                         );

//                         if (pickedTime != null) {
//                           // ignore: use_build_context_synchronously
//                           final formattedTime = pickedTime.format(context);
//                           setState(() {
//                             time = formattedTime;
//                             _timeController.text = time!; // Sync controller
//                           });
//                         }
//                       },
//                       validator: (val) =>
//                           val == null || val.isEmpty ? 'Enter time' : null,
//                     ),
//                     CustTextFormField(
//                       label: 'Key Spots',
//                       hint: 'e.g. Maho dand, Fizza gat',
//                       onSaved: (v) => keySpots = v,
//                       validator: (v) => v!.isEmpty ? 'Required' : null,
//                     ),
//                     CustTextFormField(
//                       label: 'Vehicle',
//                       hint: 'e.g. Luxury Bus / SUV',
//                       onSaved: (v) => vehicle = v,
//                       validator: (v) => v!.isEmpty ? 'Required' : null,
//                     ),
//                     // CustTextFormField(
//                     //   label: 'Price',
//                     //
//                     //   keyboardType: TextInputType.number,
//                     //   onSaved: (v) => price = v,
//                     //   validator: (v) => v!.isEmpty ? 'Required' : null,
//                     // ),
//                     CustTextFormField(
//                       label: 'Price',hint: 'e.g. 500',
//                       initialValue: packageProvider.price,
//                       keyboardType: TextInputType.number,
//                       onSaved: (v) =>
//                           packageProvider.price = v ?? '',
//                       validator: (v) => v!.isEmpty ? 'Required' : null,
//                     ),
//                     CustTextFormField(
//                       label: 'Description',
//                       hint: 'Tell users about the trip...',
//                       maxLines: 4,
//                       onSaved: (v) => description = v,
//                       validator: (v) => v!.isEmpty ? 'Required' : null,
//                     ),
//                     SizedBox(height: 20.h),
//                     // CustomElevatedButton(
//                     //   onPressed: () async {
//                     //     final confirmed = await AppConfirmDialog.show(
//                     //       context,
//                     //       title: packageProvider.isEditMode
//                     //           ? 'Edit Package?'
//                     //           : "Add Package?",
//                     //       message: 'Are you sure you want to save',
//                     //     );

//                     //     if (confirmed) {
//                     //       await packageProvider.submit(destination.name);
//                     //     }
//                     //   },

//                     //   child: isLoading
//                     //       ? const SpinKitFadingCircle(
//                     //           color: Colors.white,
//                     //           size: 40,
//                     //         )
//                     //       : Text(
//                     //           'Add Package',
//                     //           style: TextStyle(fontSize: 18.sp),
//                     //         ),
//                     // ),
//                     CustomElevatedButton(
//                       onPressed: packageProvider.isLoading
//                           ? null
//                           : () async {
//                               final confirmed =
//                                   await AppConfirmDialog.show(
//                                 context,
//                                 title: packageProvider.isEditMode
//                                     ? 'Edit Package?'
//                                     : 'Add Package?',
//                                 message: 'Are you sure you want to save?',
//                               );

//                               if (confirmed) {
//                                 await packageProvider
//                                     .submit(destination.name);
//                               }
//                             },
//                       child: packageProvider.isLoading
//                           ? const SpinKitFadingCircle(
//                               color: Colors.white,
//                             )
//                           : Text(
//                               packageProvider.isEditMode
//                                   ? 'Edit Package'
//                                   : 'Add Package',
//                               style: TextStyle(fontSize: 18.sp),
//                             ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//     //       if (prov.showSuccess)
//     //   LottieOverlay(
//     //     assetPath: 'assets/animations/success.json',
//     //     onAnimationComplete: () {
//     //       prov.reset(); // Clear form
//     //       NavigationService().pop(); // Go back
//     //     },
//     //   ),

//           if (packageProvider.showSuccess)
//             LottieOverlay(
//               assetPath: 'assets/animations/success.json',
//               onAnimationComplete: () {
//                 packageProvider.reset();
//                 NavigationService().pop();
//               },
//             ),
//     // if (prov.showError)
//     //   LottieOverlay(
//     //     assetPath: 'assets/animations/error.json',
//     //     onAnimationComplete: () => prov.toggleError(false), // Hide overlay
//     //   ),

//     if (packageProvider.showError)
//             LottieOverlay(
//               assetPath: 'assets/animations/error.json',
//               onAnimationComplete: () =>
//                   packageProvider.toggleError(false),
//             ),
//         ],
//       ),
//     );
//   }

// }
//created by: FAMZY CodeWorks
import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/user_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/company_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/add_package_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/desstinations_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_date_time_picker.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_glass_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_text_form_field.dart';
import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/dest_bg_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/destination-widgets/profile_header.dart';
import 'package:famzy_tourz_v2/presentation/widgets/dialogs/custom_app_confirm_dialog.dart';
import 'package:famzy_tourz_v2/presentation/widgets/lottie_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CompanyAddPackageScreen extends StatefulWidget {
  const CompanyAddPackageScreen({super.key});

  @override
  State<CompanyAddPackageScreen> createState() =>
      _CompanyAddPackageScreenState();
}

class _CompanyAddPackageScreenState extends State<CompanyAddPackageScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  bool tourId = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CompanyProvider>().listenToActiveCompanies();
    });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   final userProvider = context.read<UserProvider>();
  //   final packageProvider = context.read<AddPackageProvider>();

  //   // Load user ONLY if not already loaded
  //   if (!userProvider.isLoggedIn) {
  //     final uid = userProvider.user?.uid;
  //     if (uid != null) {
  //       userProvider.loadUser(uid);
  //     }
  //   }

  //   // Inject company info once user is available
  //   final user = userProvider.user;
  //   if (user != null) {
  //     packageProvider.setCompanyInfo(user);
  //   }

  //   // Prefill controllers in EDIT mode
  //   if (packageProvider.isEditMode) {
  //     _dateController.text = packageProvider.departureDate;
  //     _timeController.text = packageProvider.departureTime;
  //   }
  // }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final user = context.read<UserProvider>().user;
    final packageProvider = context.read<AddPackageProvider>();

    // if (user != null) {
    //   packageProvider.setCompanyInfo(user);
    // }

    if (packageProvider.isEditMode) {
      _dateController.text = packageProvider.departureDate;
      _timeController.text = packageProvider.departureTime;
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
    final destProvider = context.watch<DestinationsProvider>();
    final packageProvider = context.watch<AddPackageProvider>();
    final destination = destProvider.selectedDestination;
    final nav = NavigationService();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return;
        //trigger custom dialog
        final shouldPop = await AppConfirmDialog.show(
          context,
          title: 'Discard Changes?',
          message:
              'Are you sure you want to leave? Your package details will not be saved.',
          confirmText: 'Discard',
          cancelText: 'Stay',
          iconColor: AppConstants.lightRed,
          icon: Icons.warning_amber_rounded,
        );
        // If user confirms, use the Navigator to leave
        if (shouldPop && context.mounted) {
          packageProvider.reset();
          nav.pop();
        }
      },
      child: Stack(
        children: [
          DestinationBackgroundWrapper(
            imagePath: destination.image,
            destinationName: Text(
              '${packageProvider.isEditMode ? 'Edit' : 'Add'} Package\nfor ${destination.name}',
              style: GoogleFonts.playpenSansArabic(
                //or  googleFonts.anton
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: -1.5,
              ),
              textAlign: .center,
            ),
            onBackTap: () {
              NavigationService().maybePop();
              // packageProvider.reset();
            },
            // child: SingleChildScrollView(
            // padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Form(
              key: packageProvider.formKey,
              child: Column(
                children: [
                  const ProfileHeader(),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     border: .all(
                  //       color: AppConstants.whiteColorP5,
                  //       width: .5.w,
                  //     ),
                  //     borderRadius: .circular(15.r),
                  //     color: AppConstants.primaryTransGColor,
                  //   ),
                  //   padding: .fromLTRB(.05.sw, .03.sh, .05.sw, .03.sh),
                  //   child:
                  CustomGlassWrapper(
                    height: .5.sh,
                    child: Column(
                      children: [
                        // 🏢 Company Selection
                        Consumer<CompanyProvider>(
                          builder: (context, companyProv, _) {
                            final companies = companyProv.companies;

                            return DropdownButtonFormField<String>(
                              initialValue: packageProvider.companyId.isEmpty
                                  ? null
                                  : packageProvider.companyId,
                              decoration: const InputDecoration(
                                labelText: 'Select Company',
                                labelStyle: TextStyle(color: Colors.white70),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white24),
                                ),
                              ),
                              dropdownColor: AppConstants.secondaryColor,

                              // disabledHint: Text(
                              //   'dot',
                              //   style: TextStyle(color: Colors.white70),
                              // ),
                              style: const TextStyle(color: Colors.white),
                              items: companies.map((c) {
                                return DropdownMenuItem(
                                  value: c.companyId,
                                  child: Text(c.companyName),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (destProvider.isAdmin) {
                                  if (val != null) {
                                    final selected = companies.firstWhere(
                                      (c) => c.companyId == val,
                                    );
                                    packageProvider.setCompanyInfo(selected);
                                  }
                                }
                              },
                              validator: (v) =>
                                  v == null ? 'Please select a company' : null,
                            );
                          },
                        ),
                        SizedBox(height: 10.h),
                        CustTextFormField(
                          label: 'Package Name',
                          hint: 'e.g. Summer Special',
                          readOnly: packageProvider.isEditMode ? true : false,
                          initialValue: packageProvider.packageName,
                          onChanged: (v) {
                            if (!packageProvider.isEditMode) {
                              packageProvider.setPackageName(v);
                            }
                          },
                          onSaved: (v) => packageProvider.packageName = v ?? '',
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),

                        // 🆔 Tour ID Display (Cleaned up logic)
                        if (packageProvider.isEditMode)
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Text(
                              'Editing Tour ID:\n${packageProvider.packageId}',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12.sp,
                              ),
                              textAlign: .center,
                            ),
                          )
                        else if (packageProvider.packageName != '')
                          Text(
                            'Tour ID:\n${Provider.of<AddPackageProvider>(context, listen: false).getPreviewId(context)}',
                            style: TextStyle(color: AppConstants.whiteColorP5),
                            textAlign: .center,
                          ),
                        CustTextFormField(
                          label: 'Duration',
                          hint: 'e.g. 2 Days/ 3 Nights',
                          initialValue: packageProvider.duration,
                          onSaved: (v) => packageProvider.duration = v ?? '',
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                        CustTextFormField(
                          label: 'Date',
                          hint: 'YYYY-MM-DD',
                          controller: _dateController,
                          readOnly: true,
                          // onTap: () async {
                          //   final pickedDate = await showDatePicker(
                          //     context: context,
                          //     initialDate: DateTime.now(),
                          //     firstDate: DateTime.now(),
                          //     lastDate: DateTime(2050),
                          //     builder: (context, child) {
                          //       return Theme(
                          //         data: Theme.of(context).copyWith(
                          //           colorScheme: const ColorScheme.dark(
                          //             primary:
                          //                 AppConstants.famzyGold, // FAMZY Gold
                          //             onPrimary: Colors.white,
                          //             surface: AppConstants
                          //                 .secondaryColor, // Dark Surface
                          //             onSurface: Colors.white,
                          //           ),
                          //           textButtonTheme: TextButtonThemeData(
                          //             style: TextButton.styleFrom(
                          //               foregroundColor: AppConstants.famzyGold,
                          //             ),
                          //           ),
                          //           datePickerTheme: DatePickerThemeData(
                          //             shape: RoundedRectangleBorder(
                          //               borderRadius: BorderRadius.circular(
                          //                 50.r,
                          //               ),
                          //               side: BorderSide(
                          //                 color: Colors.white,
                          //                 width: 2.r,
                          //               ),
                          //             ),
                          //           ),
                          //           dialogTheme: const DialogThemeData(
                          //             backgroundColor:
                          //                 AppConstants.primaryTransGColor,
                          //           ),
                          //         ),

                          //         child: child!,
                          //       );
                          //     },
                          //   );

                          //   if (pickedDate != null) {
                          //     final formatted = DateFormat(
                          //       'yyyy-MM-dd',
                          //     ).format(pickedDate);
                          //     _dateController.text = formatted;
                          //     packageProvider.departureDate = formatted;
                          //   }
                          // },
                          onTap: () async {
                            final pickedDate =
                                await DatePickerUtil.showFamzyDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2050),
                                );

                            if (pickedDate != null) {
                              final formatted = DateFormat(
                                'yyyy-MM-dd',
                              ).format(pickedDate);
                              _dateController.text = formatted;
                              packageProvider.departureDate = formatted;
                            }
                          },
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Select date' : null,
                        ),

                        CustTextFormField(
                          label: 'Time',
                          hint: '10:00 AM',
                          controller: _timeController,
                          readOnly: true,
                          onTap: () async {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.dark(
                                      primary: AppConstants.textColor,
                                      onPrimary: AppConstants.whiteColorP5,
                                      surface: Colors.white,
                                      onSurface: Colors.white,
                                    ),
                                    timePickerTheme: TimePickerThemeData(
                                      backgroundColor:
                                          AppConstants.secondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          22.r,
                                        ),
                                        side: const BorderSide(
                                          color: Colors.white,
                                          width: 0.5,
                                        ),
                                      ),
                                      // Styling the dial
                                      dialHandColor: AppConstants.famzyGold,
                                      dialBackgroundColor:
                                          AppConstants.whiteColorP5,
                                      dialTextColor: Colors.white,
                                      hourMinuteTextColor: Colors.white,
                                      hourMinuteShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          50.r,
                                        ),
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

                            if (pickedTime == null) return;
                            // ignore: use_build_context_synchronously
                            final formatted = pickedTime.format(context);
                            if (!mounted) return;
                            _timeController.text = formatted;
                            packageProvider.departureTime = formatted;
                          },
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Select time' : null,
                        ),
                        CustTextFormField(
                          label: 'Key Spots',
                          hint: 'e.g. Maho dand, Fizza gat',
                          initialValue: packageProvider.keySpots,
                          onSaved: (v) => packageProvider.keySpots = v ?? '',
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                        CustTextFormField(
                          label: 'Vehicle',
                          hint: 'e.g. Luxury Bus / SUV',
                          initialValue: packageProvider.vehicle,
                          onSaved: (v) => packageProvider.vehicle = v ?? '',
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                        CustTextFormField(
                          label: 'Price',
                          hint: 'e.g. 500',

                          initialValue: packageProvider.price > 0
                              ? packageProvider.price.toString()
                              : '',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(5),
                          ],
                          onSaved: (v) => packageProvider.price =
                              int.tryParse(v ?? '0') ?? 0,
                          // validator: (v) => v!.isEmpty || v==0  ? 'Required' : null,
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Required';

                            final n = int.tryParse(v);
                            if (n == null) return 'Enter a valid number';
                            if (n <= 1000) {
                              return 'Price must be greater than 1000';
                            }

                            return null;
                          },
                        ),
                        CustTextFormField(
                          label: 'Total Seats',
                          hint: 'e.g. 30 seats',
                          initialValue: packageProvider.totalSeats > 0
                              ? packageProvider.totalSeats.toString()
                              : '',
                          keyboardType: .number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(2),
                          ],
                          onSaved: (v) => packageProvider.totalSeats =
                              int.tryParse(v ?? '0') ?? 0,
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Enter seats';
                            final count = int.tryParse(v) ?? 0;
                            if (count < 1) return 'Must be at least 1';
                            return null;
                          },
                        ),
                        CustTextFormField(
                          label: 'Description',
                          hint: 'Tell users about the trip...',

                          initialValue: packageProvider.description,
                          maxLines: 4,
                          onSaved: (v) => packageProvider.description = v ?? '',
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  CustomLoadingButton(
                    isLoading: packageProvider.isLoading,
                    text: packageProvider.isEditMode
                        ? 'Edit Package'
                        : 'Add Package',
                    onPressed: () async {
                      final confirmed = await AppConfirmDialog.show(
                        context,
                        title: packageProvider.isEditMode
                            ? 'Edit Package?'
                            : 'Add Package?',
                        message: 'Are you sure you want to save?',
                      );

                      if (!mounted) return;

                      await packageProvider.submitWithConfirmation(
                        destinationName: destination.name,
                        confirmed: confirmed,
                      );
                    },
                  ),
                  SizedBox(height: 10.h),
                  // SizedBox(height: 300.h),
                ],
              ),
            ),
            // ),
          ),

          if (packageProvider.showSuccess)
            LottieOverlay(
              assetPath: 'assets/animations/success.json',
              onAnimationComplete: () {
                FocusScope.of(context).unfocus();
                packageProvider.reset();
                nav.pop();
              },
            ),
          if (packageProvider.showError)
            LottieOverlay(
              assetPath: 'assets/animations/error.json',
              onAnimationComplete: () {
                FocusScope.of(context).unfocus();
                packageProvider.toggleError(false);
              },
            ),
        ],
      ),
    );
  }
}

 // // 1. Get the current user from UserProvider
                        // final isLoggedIn = context
                        //     .read<UserProvider>()
                        //     .isLoggedIn;
                        // if (!isLoggedIn) {
                        //   debugPrint('********not logged in');
                        //   // NavigationService().navigateAndClearStack(
                        //   //   AppRoutes.welcome,
                        //   // );
                        // }

                        // final user = context.read<UserProvider>().user;
                        // if (user == null) {
                        //   // Show a snackbar if for some reason the user is not loaded
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //       content: Text(
                        //         'User profile not found. Please log in again.',
                        //       ),
                        //     ),
                        //   );
                        //   return;
                        // }
                        // final confirmed = await AppConfirmDialog.show(
                        //   context,
                        //   title: packageProvider.isEditMode
                        //       ? 'Edit Package?'
                        //       : 'Add Package?',
                        //   message: 'Are you sure you want to save?',
                        // );

                        // if (!mounted) return;

                        // await packageProvider.submitWithConfirmation(
                        //   destinationName: destination.name,
                        //   user: user,
                        //   confirmed: confirmed,
                        // );