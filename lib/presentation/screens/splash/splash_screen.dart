// import 'package:famzy_tourz_v2/data/services/splash_service.dart';
// import 'package:famzy_tourz_v2/presentation/providers/auth_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     // Splashservices().isLogin(context);

//     super.initState();
//     final auth = context.read<AuthProvider>();
//   SplashServices().checkAuthentication(context, auth);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/bg_app.jpg'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Center(
//           child: Text(
//             'Welcome',
//             style: TextStyle(
//               fontSize: 30.sp,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/presentation/providers/splash_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_app_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<SplashProvider>().initialize(context);
      }
    });
  }

  @override
  void didChangeDependencies() {
    // PRE-CACHE: Loads the optimized background image into memory
    // immediately to prevent the "white flash" or frame skipping.
    precacheImage(const AssetImage(AppConstants.appBgImage), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AppAuthBackground(
      child: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.h),
            SpinKitSpinningLines(
              color: Colors.white,
              size: 70.r,
              lineWidth: 2.r,
            ),
          ],
        ),
      ),
    );
  }
}
