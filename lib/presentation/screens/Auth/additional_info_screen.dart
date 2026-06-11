// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/back_logo_row.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/custom_app_background.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/custom_drop_down_field.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/custom_text_form_field.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/sign_out_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';

// import '../../providers/auth_providers/auth_provider.dart';

// class AdditionalInfoScreen extends StatelessWidget {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   AdditionalInfoScreen({super.key});

//   //   @override
//   //   State<AdditionalInfoScreen> createState() => _AdditionalInfoScreenState();
//   // }

//   // class _AdditionalInfoScreenState extends State<AdditionalInfoScreen> {
//   //   @override
//   //   void initState() {
//   //     super.initState();

//   //     // This waits until the first frame is drawn
//   //     WidgetsBinding.instance.addPostFrameCallback((_) {
//   //       NavigationService().showSnackBar(
//   //         title: 'Action Required!',
//   //         message: 'Just a few more details to personalize your experience.',
//   //         type: ContentType.warning,
//   //       );
//   //     });
//   //   }

//   // final TextEditingController _ageController = TextEditingController();
//   // String? selectedGender;

//   // @override
//   // void dispose() {
//   //   _ageController.dispose();
//   //   super.dispose();
//   // }

//   // void _submit(AuthProvider auth) {
//   // FocusScope.of(context).unfocus();

//   // if (!_formKey.currentState!.validate()) return;

//   // final age = int.tryParse(_ageController.text.trim()) ?? 0;

//   // auth.submitAdditionalInfo(age: age, gender: selectedGender!);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = context.read<AuthProvider>();
//     return AppAuthBackground(
//       notAllowPop: true,
//       child: Column(
//         children: [
//           const BackAndLogoRow(),
//           // title
//           Text(
//             'Additional Information',
//             style: AppConstants.screenTitleTextStyle,
//             textAlign: .center,
//           ),

//           // form card
//           Padding(
//             padding: .fromLTRB(.03.sw, .03.sh, .03.sw, .05.sh),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: .circular(15.r),
//                 color: AppConstants.primaryTransGColor,
//                 border: .all(color: Colors.white, width: .5.w),
//               ),
//               child: Form(
//                 key: _formKey,
//                 child: Padding(
//                   padding: .fromLTRB(.05.sw, .02.sh, .05.sw, .02.sh),
//                   child: Column(
//                     children: [
//                       SizedBox(height: 12.h),

//                       // age
//                       CustTextFormField(
//                         // controller: _ageController,
//                         label: 'Age',
//                         hint: '18',
//                         onChanged: (v) {
//                           authProvider.age = v;
//                         },
//                         keyboardType: .number,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly,
//                         ],
//                         validator: (v) {
//                           if (v == null || v.isEmpty) {
//                             return 'Enter age';
//                           }
//                           final n = int.tryParse(v);
//                           if (n == null || n < 13 || n > 130) {
//                             return 'Invalid age';
//                           }
//                           return null;
//                         },
//                       ),

//                       SizedBox(height: 15.h),

//                       // gender
//                       CustomGenderDropdownField(
//                         // value: selectedGender,
//                         value: authProvider.selectedGender,
//                         validator: (v) {
//                           if (v == null) {
//                             return 'Please select gender';
//                           }
//                           return null;
//                         },
//                         onChanged: (v) {
//                           // setState(() => selectedGender = v);
//                           authProvider.selectGender(v);
//                         },
//                       ),

//                       SizedBox(height: 30.h),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // SizedBox(height: 5sd.h),
//           // submit button
//           Consumer<AuthProvider>(
//             builder: (context, auth, _) {
//               return CustomLoadingButton(
//                 text: 'CONTINUE',
//                 isLoading: auth.loading,
//                 // onPressed: () => _submit(auth),
//                 onPressed: () {
//                   FocusScope.of(context).unfocus();

//                   if (!_formKey.currentState!.validate()) return;

//                   // final age = int.tryParse(_ageController.text.trim()) ?? 0;

//                   // auth.submitAdditionalInfo(age: age, gender: selectedGender!);
//                   auth.submitAdditionalInfo();
//                 },
//               );
//             },
//           ),

//           SizedBox(height: 30.h),
//           // Consumer<AuthProvider>(
//           //   builder: (context, auth, child) {
//           //     return CustomLoadingButton(
//           //       onPressed: () {
//           //         print('******auth loading ${auth.loading}');
//           //         auth.loading ? null : auth.emailSignOut();
//           //       },
//           //       isLoading: auth.loading,
//           //       child: auth.loading
//           //           ? const SpinKitSpinningLines(color: Colors.white)
//           //           : Row(
//           //               mainAxisAlignment: .spaceEvenly,
//           //               children: [
//           //                 Text(
//           //                   'Sign Out',
//           //                   style: AppConstants.elevatedButtonTextStyle,
//           //                 ),
//           //                 Icon(
//           //                   Icons.logout,
//           //                   color: Colors.white,
//           //                   size: 30.r,
//           //                 ),
//           //               ],
//           //             ),
//           //     );
//           //   },
//           // ),
//           // Consumer<AuthProvider>(
//           //   builder: (context, auth, _) {
//           //     return const SignOutButton(
//           //       // buttonText: 'Sign Out',
//           //       // icon: Icons.logout_rounded,
//           //       // dialogTitle: 'Sign Out',
//           //       // dialogMessage:
//           //       //     'Are you sure you want to log out of FAMZY Tourz?',
//           //       // // isDanger: true,
//           //       // // confirmColor: Colors.red,
//           //       // // confirmColor: Colors.black,
//           //       // isLoading: auth.loading,
//           //       // onConfirmed: () => auth.emailSignOut(),
//           //     );
//           //   },
//           // ),
//           SignOutButton(height: 60.h, width: .8.sw),
//         ],
//       ),
//     );
//   }
// }

//uncommented versio of previous

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/widgets/back_logo_row.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_app_background.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_date_time_picker.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_drop_down_field.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_glass_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_text_form_field.dart';
import 'package:famzy_tourz_v2/presentation/widgets/sign_out_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_providers/auth_provider.dart';

class AdditionalInfoScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AdditionalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    return AppAuthBackground(
      notAllowPop: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const BackAndLogoRow(),
            // title
            Text(
              'Additional Information',
              style: AppConstants.screenTitleTextStyle,
              textAlign: .center,
            ),

            // form card
            CustomGlassWrapper(
              bottomPadding: .02.sh,
              topPadding: .01.sh,
              bottomMargin: .05.sh,
              topMargin: .03.sh,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 12.h),

                    // age
                    CustTextFormField(
                      controller: authProvider.ageController,
                      label: 'Age',
                      hint: '18',
                      onChanged: (v) {
                        context.read<AuthProvider>().age = v;
                      },
                      readOnly: true,
                      keyboardType: .number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onTap: () async {
                        final pickedDate =
                            await DatePickerUtil.showFamzyDatePicker(
                              context: context,
                              initialDate: DateTime.now().subtract(
                                const Duration(days: 12 * 365),
                              ),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now().subtract(
                                const Duration(days: 12 * 365),
                              ),
                            );

                        if (pickedDate != null) {
                          final formatted = DateFormat(
                            'yyyy-MM-dd',
                          ).format(pickedDate);
                          debugPrint(
                            '*** ready to store data in authprovider.age : $formatted',
                          );
                          authProvider.ageController.text = formatted;
                          if (context.mounted) {
                            context.read<AuthProvider>().age = formatted;
                          }
                        }
                      },
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Select date' : null,
                    ),

                    SizedBox(height: 15.h),

                    // gender
                    CustomGenderDropdownField(
                      value: authProvider.selectedGender,
                      validator: (v) {
                        if (v == null) {
                          return 'Please select gender';
                        }
                        return null;
                      },
                      onChanged: (v) {
                        authProvider.selectGender(v);
                      },
                    ),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
            Consumer<AuthProvider>(
              builder: (context, auth, _) {
                return CustomLoadingButton(
                  text: 'CONTINUE',
                  isLoading: auth.loading,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (!_formKey.currentState!.validate()) return;
                    final bool succes = await auth.submitAdditionalInfo();
                    if (succes) {
                      auth.reset();
                    }
                  },
                );
              },
            ),
            SizedBox(height: 30.h),
            SignOutButton(height: 60.h, width: .8.sw),
          ],
        ),
      ),
    );
  }
}
