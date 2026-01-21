// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:famzy_tourz_v2/presentation/controllers/signup_controller.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
// import 'package:famzy_tourz_v2/presentation/widgets/custom_text_form_field.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class SignUpScreen extends StatelessWidget {
//   SignUpScreen({super.key});

//   final SignUpController controller = SignUpController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: 1.sw,
//         height: 1.sh,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/images/bg_app.jpg"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Sign Up",
//                 style: AppConstants.appBarTextStyle.copyWith(
//                   color: AppConstants.primaryColor,
//                   fontSize: 40.sp,
//                 ),
//               ),
//               SizedBox(height: 20.h),

//               /// Full Name
//               CustTextFormField(
//                 label: "Full Name",
//                 hint: "Billy Boy",
//                 controller: controller.fullName,
//               ),
//               SizedBox(height: 12.h),

//               /// G-Mail
//               CustTextFormField(
//                 label: "Email",
//                 hint: "you@gmail.com",
//                 keyboardType: TextInputType.emailAddress,
//                 controller: controller.email,
//               ),
//               SizedBox(height: 12.h),

//               /// Password
//               CustTextFormField(
//                 label: "Password",
//                 hint: "Password",
//                 obscureText: true,
//                 controller: controller.password,
//               ),
//               SizedBox(height: 12.h),

//               /// Confirm Password
//               CustTextFormField(
//                 label: "Confirm Password",
//                 hint: "Re-enter password",
//                 obscureText: true,
//                 controller: controller.confirmPassword,
//               ),
//               SizedBox(height: 16.h),

//               /// Age Field
//               CustTextFormField(
//                 label: "Age",
//                 hint: "18",
//                 keyboardType: TextInputType.number,
//                 controller: controller.age,
//               ),
//               SizedBox(height: 16.h),

//               /// Gender Dropdown
//               DropdownButtonFormField<String>(
//                 decoration: InputDecoration(
//                   labelText: "Gender",
//                   labelStyle: TextStyle(color: Colors.white),
//                 ),
//                 items: const [
//                   DropdownMenuItem(value: "male", child: Text("Male")),
//                   DropdownMenuItem(value: "female", child: Text("Female")),
//                   DropdownMenuItem(value: "other", child: Text("Other")),
//                 ],
//                 onChanged: (value) => controller.gender = value,
//               ),

//               SizedBox(height: 30.h),

//               /// SIGN UP BUTTON
//               ValueListenableBuilder<bool>(
//                 valueListenable: controller.isLoading,
//                 builder: (_, loading, __) {
//                   return CustomLoadingButton(
//                     text: "SIGN UP",
//                     isLoading: loading,
//                     onPressed: () => controller.signUp(context),
//                   );
//                 },
//               ),

//               SizedBox(height: 20.h),

//               Center(
//                 child: Column(
//                   children: [
//                     Text(
//                       "Or continue with",
//                       style: TextStyle(color: AppConstants.whiteColorP9),
//                     ),
//                     SizedBox(height: 8.h),

//                     // google button
//                     IconButton(
//                       icon: Image.asset(
//                         'assets/logos/google_logo.png',
//                         height: 35.h,
//                       ),
//                       onPressed: () => controller.signInWithGoogle(context),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/widgets/back_logo_row.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_app_background.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_drop_down_field.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_loading_button.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_text_form_field.dart';
import 'package:famzy_tourz_v2/presentation/widgets/google_button_inkwell.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordNotVisible = true;
  bool isLoadingLocal = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _age = TextEditingController();

  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return AppBackground(
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
            Padding(
              padding: .fromLTRB(.05.sw, .02.sh, .05.sw, .03.sh),
              child: Container(
                decoration: AppConstants.glassCardDecoration,
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

                        // Full name
                        CustTextFormField(
                          controller: _fullName,
                          label: 'Full Name',
                          hint: 'Billy Boy',
                          validator: (v) => v == null || v.isEmpty
                              ? 'Full Name required'
                              : null,
                        ),
                        SizedBox(height: 10.h),

                        // Email
                        CustTextFormField(
                          controller: _email,
                          label: 'G-Mail',
                          hint: 'you@gmail.com',
                          keyboardType: .emailAddress,
                          validator: (v) =>
                              v == null || v.isEmpty ? 'G-Mail required' : null,
                        ),
                        SizedBox(height: 10.h),

                        // Password
                        CustTextFormField(
                          controller: _password,
                          label: 'Password',
                          hint: 'password',
                          obscureText: true,
                          isPasswordHidden: _isPasswordNotVisible,
                          toggleVisibility: () {
                            setState(() {
                              _isPasswordNotVisible = !_isPasswordNotVisible;
                            });
                          },
                          validator: (v) => v == null || v.isEmpty
                              ? 'Password required'
                              : null,
                        ),
                        SizedBox(height: 10.h),

                        // confirm password
                        CustTextFormField(
                          controller: _confirmPassword,
                          label: 'Confirm Password',
                          hint: 'password',
                          obscureText: true,
                          isPasswordHidden: _isPasswordNotVisible,
                          toggleVisibility: () {
                            setState(() {
                              _isPasswordNotVisible = !_isPasswordNotVisible;
                            });
                          },
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Confirm password';
                            }
                            if (v != _password.text) {
                              return 'Passwords do not match';
                            }
                            return null;
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
                                child: CustTextFormField(
                                  controller: _age,
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
                              ),
                            ),
                            Padding(
                              padding: .only(left: .03.sw),
                              child: SizedBox(
                                width: .25.sw,
                                child: GenderDropdownField(
                                  value: selectedGender,
                                  validator: (v) {
                                    if (v == null || v.isEmpty) {
                                      return 'Please select your gender';
                                    }
                                    return null;
                                  },
                                  onChanged: (v) {
                                    setState(() => selectedGender = v);
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
                ),
              ),
            ),
            SizedBox(height: .01.sh),

            //sign up button
            Consumer<AuthProvider>(
              builder: (context, auth, child) {
                return CustomLoadingButton(
                  text: 'SIGN UP',
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      // call provider
                      final intAge = int.tryParse(_age.text.trim()) ?? 0;
                      auth.signUpWithEmail(
                        fullName: _fullName.text.trim(),
                        email: _email.text.trim(),
                        password: _password.text.trim(),
                        age: intAge,
                        gender: selectedGender,
                      );
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
            // Consumer<AuthProvider>(
            //   builder: (context, auth, child) {
            //     return InkWell(
            //       onTap: auth.loading ? null : () => auth.signInWithGoogle(),
            //       borderRadius: .circular(12),
            //       child: Opacity(
            //         opacity: auth.loading ? 0.5 : 1.0,
            //         child: Image.asset(
            //           'assets/logos/google_logo.png',
            //           height: 50.h,
            //           width: 50.h,
            //         ),
            //       ),
            //     );
            //   },
            // ),
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
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(color: Colors.white, fontWeight: .bold),
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
