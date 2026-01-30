import 'package:famzy_tourz_v2/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoogleButtonInkWell extends StatelessWidget {
  final AuthProvider auth;
  const GoogleButtonInkWell({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //manually handle the disabled state for InkWell
      onTap: auth.loading ? null : () => auth.signInWithGoogle(),
      borderRadius: .circular(12),
      child: Opacity(
        //visually show it's disabled
        opacity: auth.loading ? 0.5 : 1.0,
        child: Image.asset(
          'assets/logos/google_logo.png',
          height: 50.h,
          width: 50.h,
        ),
      ),
    );
  }
}
