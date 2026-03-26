import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/presentation/widgets/back_logo_row.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_app_background.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_date_time_picker.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_drop_down_field.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_glass_wrapper.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_text_form_field.dart';
import 'package:famzy_tourz_v2/presentation/widgets/google_button_inkwell.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_providers/auth_provider.dart';

class SignUpScreen extends StatelessWidget {
  // final _formKey = GlobalKey<FormState>();
  // This ensures it isn't recreated when build() runs
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignUpScreen({super.key});
  // final TextEditingController _fullName = TextEditingController();
  // final TextEditingController _email = TextEditingController();
  // final TextEditingController _password = TextEditingController();
  // final TextEditingController _confirmPassword = TextEditingController();
  // final TextEditingController _age = TextEditingController();

  // // Inside your State class:
  // UserType _selectedUserType = UserType.tourist;
  // bool get isCompany => _selectedUserType == UserType.company;
  // @override
  // void dispose() {
  //   _fullName.dispose();
  //   _email.dispose();
  //   _password.dispose();
  //   _confirmPassword.dispose();
  //   _age.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    return AppAuthBackground(
      child: SingleChildScrollView(
        child: Column(
          children: [
            //back and logo
            const BackAndLogoRow(),
            //title
            Text(
              ' Sign Up',
              textAlign: .center,
              style: AppConstants.screenTitleTextStyle,
            ),

            //form container
            CustomGlassWrapper(
              bottomMargin: 20.h,
              // child:
              //  Padding(
              //   padding: .fromLTRB(.05.sw, .02.sh, .05.sw, .03.sh),
              // child:
              // Container(
              //   decoration: AppConstants.glassCardDecoration,

              // decoration: BoxDecoration(
              //   borderRadius: .circular(15.r),
              //   color: AppConstants.primaryTransGColor,
              //   border: .all(color: Colors.white, width: .5.w),
              // ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: .symmetric(horizontal: .05.sw),
                  child: Column(
                    children: [
                      SizedBox(height: 8.h),
                      // Row(
                      //   children: [
                      //     RadioMenuButton(
                      //       value: value,
                      //       groupValue: groupValue,
                      //       onChanged: () {},
                      //       child: const Text('Comapany'),
                      //     ),
                      //     RadioMenuButton(
                      //       value: value,
                      //       groupValue: groupValue,
                      //       onChanged: () {},
                      //       child: const Text('Tourist'),
                      //     ),
                      //   ],
                      // ),

                      // Full name
                      CustTextFormField(
                        // controller: _fullName,
                        onChanged: (v) {
                          authProvider.fullName = v;
                        },
                        label: 'Full Name',
                        hint: 'Billy Boy',
                        validator: (v) => v == null || v.isEmpty
                            ? 'Full Name required'
                            : null,
                      ),
                      SizedBox(height: 10.h),

                      // Email
                      CustTextFormField(
                        // controller: _email,
                        onChanged: (v) {
                          authProvider.email = v;
                        },
                        label: 'G-Mail',
                        hint: 'you@gmail.com',
                        keyboardType: .emailAddress,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'G-Mail required' : null,
                      ),
                      SizedBox(height: 10.h),

                      // Password
                      Consumer<AuthProvider>(
                        builder: (context, auth, child) {
                          return Column(
                            children: [
                              CustTextFormField(
                                // controller: _password,
                                onChanged: (v) {
                                  authProvider.password = v.trim();
                                },
                                label: 'Password',
                                hint: 'password',
                                keyboardType: .visiblePassword,
                                obscureText: true,
                                isPasswordHidden:
                                    authProvider.isPasswordVisible,
                                toggleVisibility: () {
                                  // setState(() {
                                  //   _isPasswordNotVisible = !_isPasswordNotVisible;
                                  // });
                                  authProvider.togglePasswordVisibility();
                                },
                                validator: (v) => v == null || v.isEmpty
                                    ? 'Password required'
                                    : null,
                              ),
                              SizedBox(height: 10.h),

                              // confirm password
                              CustTextFormField(
                                // controller: _confirmPassword,
                                onChanged: (v) {
                                  authProvider.confirmPassword;
                                },
                                label: 'Confirm Password',
                                hint: 'password',
                                obscureText: true,
                                isPasswordHidden:
                                    authProvider.isPasswordVisible,
                                toggleVisibility: () {
                                  authProvider.togglePasswordVisibility();
                                },
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return 'Confirm password';
                                  }
                                  if (v.trim() != authProvider.password) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 10.h),

                      // age and gender row
                      Row(
                        children: [
                          Padding(
                            padding: .only(top: 6.h),
                            child: SizedBox(
                              width: .455.sw,
                              // child: CustTextFormField(
                              //   // controller: _age,
                              //   onChanged: (v) {
                              //     authProvider.age = v;
                              //   },
                              //   label: 'Age',
                              //   hint: '18',
                              //   keyboardType: .number,
                              //   inputFormatters: [
                              //     FilteringTextInputFormatter.digitsOnly,
                              //   ],
                              //   validator: (v) {
                              //     if (v == null || v.isEmpty) {
                              //       return 'Enter age';
                              //     }
                              //     final n = int.tryParse(v);
                              //     if (n == null || n < 13 || n > 130) {
                              //       return 'Invalid age';
                              //     }
                              //     return null;
                              //   },
                              // ),
                              child: CustTextFormField(
                                label: 'Date',
                                hint: 'YYYY-MM-DD',
                                // controller: _dateController,
                                onChanged: (v) {
                                  authProvider.age = v;
                                },

                                readOnly: true,
                                // onTap: () async {
                                //   final pickedDate = await showDatePicker(
                                //     onDatePickerModeChange: (value) {
                                //       authProvider.age = value.toString();
                                //     },
                                //     context: context,
                                //     initialDate: DateTime.now().subtract(
                                //       const Duration(days: 12 * 365),
                                //     ),
                                //     firstDate: DateTime(1900),
                                //     lastDate: DateTime.now().subtract(
                                //       const Duration(days: 12 * 365),
                                //     ),
                                //     builder: (context, child) {
                                //       return Theme(
                                //         data: Theme.of(context).copyWith(
                                //           colorScheme: const ColorScheme.dark(
                                //             primary: AppConstants
                                //                 .famzyGold, // FAMZY Gold
                                //             onPrimary: Colors.white,
                                //             surface: AppConstants
                                //                 .secondaryColor, // Dark Surface
                                //             onSurface: Colors.white,
                                //           ),
                                //           textButtonTheme: TextButtonThemeData(
                                //             style: TextButton.styleFrom(
                                //               foregroundColor:
                                //                   AppConstants.famzyGold,
                                //             ),
                                //           ),
                                //           datePickerTheme: DatePickerThemeData(
                                //             shape: RoundedRectangleBorder(
                                //               borderRadius:
                                //                   BorderRadius.circular(50.r),
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
                                //     authProvider.age = formatted;
                                //     // packageProvider.departureDate = formatted;
                                //   }
                                // },
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
                                    authProvider.age = formatted;
                                  }
                                },
                                validator: (v) => v == null || v.isEmpty
                                    ? 'Select date'
                                    : null,
                              ),
                            ),
                          ),
                          Padding(
                            padding: .only(left: .03.sw),
                            child: SizedBox(
                              width: .25.sw,
                              child: CustomGenderDropdownField(
                                value: authProvider.selectedGender,
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return 'Please select your gender';
                                  }
                                  return null;
                                },
                                onChanged: (v) {
                                  authProvider.selectGender(v);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
                // ),
                // ),
              ), //   child: Form(
              //     key: _formKey,
              //     child: Column(
              //       children: [
              //         SizedBox(height: 8.h),
              //         Consumer<AuthProvider>(
              //           builder: (context, auth, child) {
              //             return Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 //company/tourist
              //                 RadioMenuButton<UserType>(
              //                   value: UserType.company,
              //                   groupValue: authProvider.selectedUserType,
              //                   style: const ButtonStyle(
              //                     iconColor: WidgetStatePropertyAll(Colors.amber),
              //                   ),

              //                   onChanged: (UserType? value) {
              //                     if (value != null) {
              //                       // authProvider.setState(
              //                       //   () => _selectedUserType = value,
              //                       // authProvider.
              //                       // );
              //                       authProvider.setUserType(value);
              //                     }
              //                   },
              //                   child: Text(
              //                     'Company',
              //                     style: TextStyle(
              //                       color: authProvider.isCompany
              //                           ? Colors.white
              //                           : AppConstants.whiteColorP5,
              //                     ),
              //                   ),
              //                 ),
              //                 RadioMenuButton<UserType>(
              //                   value: UserType.tourist,
              //                   groupValue: authProvider.selectedUserType,
              //                   onChanged: (UserType? value) {
              //                     if (value != null) {
              //                       // setState(() => _selectedUserType = value);
              //                       authProvider.setUserType(value);
              //                     }
              //                   },
              //                   child: Text(
              //                     'Tourist',
              //                     style: TextStyle(
              //                       color: authProvider.isCompany
              //                           ? AppConstants.whiteColorP5
              //                           : Colors.white,
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             );
              //           },
              //         ),
              //         //full name/company name
              //         CustTextFormField(
              //           // controller: _fullName,
              //           onChanged: (v) {
              //             authProvider.fullName = v;
              //           },
              //           label: authProvider.isCompany
              //               ? 'Company Name'
              //               : 'Full Name',
              //           hint: authProvider.isCompany
              //               ? 'Famzy Tourz Ltd'
              //               : 'Billy Boy',
              //           validator: (v) => v == null || v.isEmpty
              //               ? (authProvider.isCompany
              //                     ? 'Company Name required'
              //                     : 'Full Name required')
              //               : null,
              //         ),
              //         SizedBox(height: 10.h),
              //         //email
              //         CustTextFormField(
              //           // controller: _email,
              //           onChanged: (v) {
              //             authProvider.email = v;
              //           },
              //           label: 'G-Mail',
              //           hint: 'you@gmail.com',
              //           keyboardType: TextInputType.emailAddress,
              //           validator: (v) =>
              //               v == null || v.isEmpty ? 'G-Mail required' : null,
              //         ),
              //         SizedBox(height: 10.h),
              //         // Password
              //         Consumer<AuthProvider>(
              //           builder: (context, auth, child) {
              //             return Column(
              //               children: [
              //                 CustTextFormField(
              //                   // controller: _password,
              //                   onChanged: (v) {
              //                     authProvider.password = v;
              //                   },
              //                   label: 'Password',
              //                   hint: 'password',
              //                   obscureText: true,
              //                   isPasswordHidden: auth.isPasswordVisible,
              //                   toggleVisibility: () {
              //                     // setState(() {
              //                     //   _isPasswordNotVisible = !_isPasswordNotVisible;
              //                     // });
              //                     auth.togglePasswordVisibility();
              //                   },
              //                   validator: (v) => v == null || v.isEmpty
              //                       ? 'Password required'
              //                       : null,
              //                 ),

              //                 SizedBox(height: 10.h),
              //                 // confirm password
              //                 CustTextFormField(
              //                   // controller: _confirmPassword,
              //                   onChanged: (v) {
              //                     authProvider.confirmPassword = v;
              //                   },
              //                   label: 'Confirm Password',
              //                   hint: 'password',
              //                   obscureText: true,
              //                   isPasswordHidden: auth.isPasswordVisible,
              //                   toggleVisibility: () {
              //                     // setState(() {
              //                     //   _isPasswordNotVisible = !_isPasswordNotVisible;
              //                     // });
              //                     auth.togglePasswordVisibility();
              //                     // _isPasswordNotVisible =
              //                     //     !_isPasswordNotVisible;
              //                   },
              //                   validator: (v) {
              //                     if (v == null || v.isEmpty) {
              //                       return 'Confirm password';
              //                     }
              //                     if (v != auth.password) {
              //                       return 'Passwords do not match';
              //                     }
              //                     return null;
              //                   },
              //                 ),
              //                 //       ],
              //                 //     );
              //                 //   },
              //                 // ),
              //                 // SizedBox(height: 10.h),
              //                 // Consumer<AuthProvider>(
              //                 //   builder: (context, auth, child) {
              //                 //     return
              //                 auth.isCompany
              //                     ? SizedBox(height: 10.h)
              //                     : Row(
              //                         children: [
              //                           Padding(
              //                             padding: EdgeInsets.only(top: 6.h),
              //                             child: SizedBox(
              //                               width: .455.sw,
              //                               child: CustTextFormField(
              //                                 // controller: _age,
              //                                 onChanged: (v) {
              //                                   authProvider.age = v;
              //                                 },
              //                                 label: 'Age',
              //                                 hint: '18',
              //                                 readOnly: authProvider.isCompany,
              //                                 keyboardType: TextInputType.number,
              //                                 inputFormatters: [
              //                                   FilteringTextInputFormatter
              //                                       .digitsOnly,
              //                                 ],
              //                                 validator: (v) {
              //                                   if (authProvider.isCompany) {
              //                                     return null;
              //                                   }
              //                                   if (v == null || v.isEmpty) {
              //                                     return 'Enter age';
              //                                   }
              //                                   final n = int.tryParse(v);
              //                                   if (n == null ||
              //                                       n < 13 ||
              //                                       n > 130) {
              //                                     return 'Invalid age';
              //                                   }
              //                                   return null;
              //                                 },
              //                               ),
              //                             ),
              //                           ),
              //                           Padding(
              //                             padding: EdgeInsets.only(left: .01.sw),
              //                             child: SizedBox(
              //                               width: .38.sw,
              //                               child: CustomGenderDropdownField(
              //                                 value:
              //                                     //  authProvider.isCompany
              //                                     //     ? null
              //                                     //     :
              //                                     authProvider.selectedGender,
              //                                 onChanged: authProvider.isCompany
              //                                     ? null
              //                                     : (v) {
              //                                         // setState(
              //                                         //   () => selectedGender = v,
              //                                         // );
              //                                         authProvider.selectGender(
              //                                           v,
              //                                         );
              //                                       },
              //                                 validator: (v) {
              //                                   if (authProvider.isCompany) {
              //                                     return null;
              //                                   }
              //                                   if (v == null || v.isEmpty) {
              //                                     return 'Please select gender';
              //                                   }
              //                                   return null;
              //                                 },
              //                               ),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //               ],
              //             );
              //           },
              //         ),

              //         SizedBox(height: 30.h),
              //       ],
              //     ),
              //   ),
            ),
            SizedBox(height: .01.sh),

            //sign up button
            Consumer<AuthProvider>(
              builder: (context, auth, child) {
                return CustomLoadingButton(
                  text: 'SIGN UP',
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      // final intAge = int.tryParse(_age.text.trim()) ?? 0;
                      final bool success = await auth.signUpWithEmail(
                        //   fullName: _fullName.text.trim(),
                        //   email: _email.text.trim(),
                        //   password: _password.text.trim(),
                        //   age: intAge,
                        //   gender: authProvider.selectedGender,
                      );
                      auth.reset();
                    }
                  },
                  isLoading: auth.loading,
                );
              },
            ),
            SizedBox(height: 30.h),
            Text(
              'Or continue with',
              style: TextStyle(
                color: AppConstants.whiteColorP9,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 10.h),
            // // google button
            Consumer<AuthProvider>(
              builder: (context, auth, child) {
                return GoogleButtonInkWell(auth: auth);
              },
            ),
            SizedBox(height: 10.h),
            const Text(
              'G O O G L E',
              style: TextStyle(color: Colors.white, fontWeight: .bold),
            ),

            SizedBox(height: 10.h),
            // already have account
            Row(
              mainAxisAlignment: .center,
              crossAxisAlignment: .end,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
                const SizedBox(width: 8.0),
                GestureDetector(
                  onTap: () {
                    authProvider.reset();
                    NavigationService().navigateTo(AppRoutes.login);
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: .bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
  //   Widget _custTextField({
  //     required TextEditingController controller,
  //     required String label,
  //     required String hint,
  //     bool obscureText = false,
  //     bool isVisible = true,
  //     VoidCallback? toggleVisibility,
  //     TextInputType keyboardType = TextInputType.text,
  //     List<TextInputFormatter>? inputFormatters,
  //     String? Function(String?)? validator,
  //   }) {
  //     return TextFormField(
  //       controller: controller,
  //       obscureText: obscureText ? isVisible : false,
  //       keyboardType: keyboardType,
  //       inputFormatters: inputFormatters,
  //       style: const TextStyle(color: Colors.white),
  //       validator: validator,
  //       decoration: InputDecoration(
  //         labelText: label,
  //         labelStyle: TextStyle(color: AppConstants.whiteColorP9),
  //         hintText: hint,
  //         hintStyle: TextStyle(color: AppConstants.whiteColorP5),
  //         suffixIcon: obscureText
  //             ? IconButton(
  //                 icon: Icon(isVisible ? Icons.visibility_off : Icons.visibility),
  //                 color: AppConstants.whiteColorP9,
  //                 onPressed: toggleVisibility,
  //               )
  //             : null,
  //       ),
  //     );
  //   }

// google button
              // Consumer<AuthProvider>(
              //   builder: (context, auth, child) {
              //     return IconButton(
              //       iconSize: 50.r,
              //       icon: Image.asset('assets/logos/google_logo.png'),
              //       onPressed: auth.loading
              //           ? null
              //           : () => auth.signInWithGoogle(),
              //     );
              //   },
              // ),
