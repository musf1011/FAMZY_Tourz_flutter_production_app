// created by: FAMZY CodeWorks
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final bool allowPop;
  // final PreferredSizeWidget? appBar; //in case some screens need an AppBar

  const AppBackground({
    super.key,
    required this.child,
    this.allowPop = false,
    // this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: allowPop,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        } else {
          await NavigationService().navigateAndClearStack(AppRoutes.welcome);
        }
      },
      child: Scaffold(
        // ResizeToAvoidBottomInset prevents the background from
        // jumping when the keyboard appears
        resizeToAvoidBottomInset: false,
        body: Container(
          height: 1.sh,
          width: 1.sw,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_app.webp'),
              // fit: BoxFit.fill,
              fit: BoxFit.cover,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
