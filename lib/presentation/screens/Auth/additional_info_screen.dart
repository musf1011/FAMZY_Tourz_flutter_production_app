// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../../constants.dart';
// import '../../../routes/app_routes.dart';

// class AdditionalInfoScreen extends StatefulWidget {
//   final User user;

//   const AdditionalInfoScreen({super.key, required this.user});

//   @override
//   State<AdditionalInfoScreen> createState() => _AdditionalInfoScreenState();
// }

// class _AdditionalInfoScreenState extends State<AdditionalInfoScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _ageController = TextEditingController();

//   String? _selectedGender;
//   bool _isLoading = false;

//   @override
//   void dispose() {
//     _ageController.dispose();
//     super.dispose();
//   }

//   Future<void> _submit() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isLoading = true);

//     try {
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(widget.user.uid)
//           .set({
//             'age': int.parse(_ageController.text.trim()),
//             'gender': _selectedGender,
//             'updatedAt': FieldValue.serverTimestamp(),
//           }, SetOptions(merge: true));

//       if (!mounted) return;

//       Navigator.pushReplacementNamed(context, AppRoutes.main);
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Failed to save data: $e')));
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: 1.sh,
//         width: 1.sw,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/bg_app.jpg'),
//             fit: BoxFit.fill,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: 30.h),

//               /// LOGO
//               Image.asset(
//                 'assets/logos/FAMZYLogo.png',
//                 width: .8.sw,
//                 height: .2.sh,
//               ),

//               SizedBox(height: 10.h),

//               /// TITLE
//               Text(
//                 'Additional Information',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.playfairDisplay(
//                   fontSize: 28.sp,
//                   fontWeight: FontWeight.bold,
//                   color: AppConstants.primaryColor,
//                 ),
//               ),

//               SizedBox(height: 20.h),

//               /// FORM CARD
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: .05.sw),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15.r),
//                     color: AppConstants.transGColor,
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(.04.sw),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         children: [
//                           /// AGE
//                           TextFormField(
//                             controller: _ageController,
//                             keyboardType: TextInputType.number,
//                             style: const TextStyle(color: Colors.white),
//                             decoration: const InputDecoration(
//                               labelText: 'Age',
//                               hintText: '18',
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your age';
//                               }
//                               final age = int.tryParse(value);
//                               if (age == null || age < 13 || age > 130) {
//                                 return 'Age must be between 13 and 130';
//                               }
//                               return null;
//                             },
//                           ),

//                           SizedBox(height: 25.h),

//                           /// GENDER
//                           DropdownButtonFormField<String>(
//                             initialValue: _selectedGender,
//                             dropdownColor: AppConstants.transGColor,
//                             decoration: const InputDecoration(
//                               labelText: 'Gender',
//                             ),
//                             validator: (value) {
//                               if (value == null) {
//                                 return 'Please select gender';
//                               }
//                               return null;
//                             },
//                             items: const [
//                               DropdownMenuItem(
//                                 value: 'male',
//                                 child: Text(
//                                   'Male',
//                                   style: TextStyle(color: Colors.lightBlue),
//                                 ),
//                               ),
//                               DropdownMenuItem(
//                                 value: 'female',
//                                 child: Text(
//                                   'Female',
//                                   style: TextStyle(color: Colors.pinkAccent),
//                                 ),
//                               ),
//                               DropdownMenuItem(
//                                 value: 'other',
//                                 child: Text(
//                                   'Other',
//                                   style: TextStyle(color: Colors.yellow),
//                                 ),
//                               ),
//                             ],
//                             onChanged: (value) {
//                               setState(() => _selectedGender = value);
//                             },
//                           ),

//                           SizedBox(height: 40.h),

//                           /// SUBMIT BUTTON
//                           SizedBox(
//                             width: double.infinity,
//                             height: 50.h,
//                             child: ElevatedButton(
//                               style: AppConstants.primaryButtonStyle,
//                               onPressed: _isLoading ? null : _submit,
//                               child: _isLoading
//                                   ? const CircularProgressIndicator(
//                                       color: Colors.white,
//                                     )
//                                   : const Text('Submit'),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               SizedBox(height: 40.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/presentation/widgets/back_logo_row.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_app_background.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_drop_down_field.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_text_form_field.dart';
import 'package:famzy_tourz_v2/presentation/widgets/sign_out_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../../providers/auth_provider.dart';

class AdditionalInfoScreen extends StatefulWidget {
  const AdditionalInfoScreen({super.key});

  @override
  State<AdditionalInfoScreen> createState() => _AdditionalInfoScreenState();
}

class _AdditionalInfoScreenState extends State<AdditionalInfoScreen> {
  @override
  void initState() {
    super.initState();

    // This waits until the first frame is drawn
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavigationService().showSnackBar(
        title: 'Action Required!',
        message: 'Just a few more details to personalize your experience.',
        type: ContentType.warning,
      );
    });
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ageController = TextEditingController();
  String? selectedGender;

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  void _submit(AuthProvider auth) {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    final age = int.tryParse(_ageController.text.trim()) ?? 0;

    auth.submitAdditionalInfo(age: age, gender: selectedGender!);
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      notAllowPop: true,
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
          Padding(
            padding: .fromLTRB(.03.sw, .03.sh, .03.sw, .05.sh),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: .circular(15.r),
                color: AppConstants.primaryTransGColor,
                border: .all(color: Colors.white, width: .5.w),
              ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: .fromLTRB(.05.sw, .02.sh, .05.sw, .02.sh),
                  child: Column(
                    children: [
                      SizedBox(height: 12.h),

                      // age
                      CustTextFormField(
                        controller: _ageController,
                        label: 'Age',
                        hint: '18',
                        keyboardType: .number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Enter age';
                          }
                          final n = int.tryParse(v);
                          if (n == null || n < 13 || n > 130) {
                            return 'Invalid age';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 15.h),

                      // gender
                      // DropdownButtonFormField<String>(
                      //   validator: (value) {
                      //     if (value == null) {
                      //       return 'Please select gender';
                      //     }
                      //     return null;
                      //   },
                      //   decoration: InputDecoration(
                      //     label: const Text(
                      //       'Gender',
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //     hint: Text(
                      //       'Not Selected',
                      //       style: TextStyle(
                      //         color: AppConstants.whiteColorP5,
                      //       ),
                      //     ),
                      //     enabledBorder: const UnderlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.grey),
                      //     ),
                      //     focusedBorder: const UnderlineInputBorder(
                      //       borderSide: BorderSide(
                      //         color: AppConstants.tertiaryColor,
                      //       ),
                      //     ),
                      //   ),
                      //   dropdownColor: AppConstants.primaryTransGColor,
                      //   iconEnabledColor: AppConstants.tertiaryColor,
                      //   borderRadius: .circular(15.r),
                      //   initialValue: selectedGender,
                      //   items: [
                      //     const DropdownMenuItem(
                      //       value: 'male',
                      //       child: Text(
                      //         'Male',
                      //         style: TextStyle(
                      //           color: AppConstants.accentColor,
                      //         ),
                      //       ),
                      //     ),
                      //     DropdownMenuItem(
                      //       value: 'female',
                      //       child: Text(
                      //         'Female',
                      //         style: TextStyle(color: Colors.pink[200]),
                      //       ),
                      //     ),
                      //     DropdownMenuItem(
                      //       value: 'other',
                      //       child: Text(
                      //         'Other',
                      //         style: TextStyle(color: Colors.yellow[200]),
                      //       ),
                      //     ),
                      //   ],
                      //   onChanged: (v) {
                      //     setState(() => selectedGender = v);
                      //   },
                      // ),
                      GenderDropdownField(
                        value: selectedGender,
                        validator: (v) {
                          if (v == null) {
                            return 'Please select gender';
                          }
                          return null;
                        },
                        onChanged: (v) {
                          setState(() => selectedGender = v);
                        },
                      ),

                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // SizedBox(height: 5sd.h),
          // submit button
          Consumer<AuthProvider>(
            builder: (context, auth, _) {
              return CustomLoadingButton(
                text: 'CONTINUE',
                isLoading: auth.loading,
                onPressed: () => _submit(auth),
              );
            },
          ),

          SizedBox(height: 30.h),
          // Consumer<AuthProvider>(
          //   builder: (context, auth, child) {
          //     return CustomLoadingButton(
          //       onPressed: () {
          //         print('******auth loading ${auth.loading}');
          //         auth.loading ? null : auth.emailSignOut();
          //       },
          //       isLoading: auth.loading,
          //       child: auth.loading
          //           ? const SpinKitSpinningLines(color: Colors.white)
          //           : Row(
          //               mainAxisAlignment: .spaceEvenly,
          //               children: [
          //                 Text(
          //                   'Sign Out',
          //                   style: AppConstants.elevatedButtonTextStyle,
          //                 ),
          //                 Icon(
          //                   Icons.logout,
          //                   color: Colors.white,
          //                   size: 30.r,
          //                 ),
          //               ],
          //             ),
          //     );
          //   },
          // ),
          Consumer<AuthProvider>(
            builder: (context, auth, _) {
              return ConfirmActionButton(
                buttonText: 'Sign Out',
                icon: Icons.logout_rounded,
                dialogTitle: 'Sign Out',
                dialogMessage:
                    'Are you sure you want to log out of FAMZY Tourz?',
                isDanger: true,
                confirmColor: Colors.red,
                isLoading: auth.loading,
                onConfirmed: () => auth.emailSignOut(),
              );
            },
          ),
        ],
      ),
    );
  }
}
