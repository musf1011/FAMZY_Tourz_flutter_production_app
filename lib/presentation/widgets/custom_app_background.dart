// created by: FAMZY CodeWorks
import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/auth_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/custom_background_wrapper.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppAuthBackground extends StatelessWidget {
  final Widget child;
  final bool notAllowPop;
  // final PreferredSizeWidget? appBar; //in case some screens need an AppBar

  const AppAuthBackground({
    super.key,
    required this.child,
    this.notAllowPop = false,
    // this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    // return PopScope(
    //   canPop: allowPop,
    //   onPopInvokedWithResult: (didPop, result) async {
    //     if (didPop) {
    //       return;
    //     } else {
    //       await NavigationService().navigateAndClearStack(AppRoutes.welcome);
    //     }
    //   },
    return PopScope(
      canPop: notAllowPop,
      onPopInvokedWithResult: (didPop, result) async {
        // If didPop is true, the system already handled the back move
        if (didPop) return;

        // If didPop is false, it means loading was active (allowPop was false)
        // and the user triggered a back event.

        // 1. Cancel the active auth session and reset loading state
        debugPrint('****cancelling auth reached in app auth background class');
        final authProvider = context.read<AuthProvider>();
        authProvider.cancelAuthentication();
        authProvider.reset();

        // 2. Clear the stack and go back to a safe entry point
        await NavigationService().navigateAndClearStack(AppRoutes.welcome);
      },
      child: Scaffold(
        // ResizeToAvoidBottomInset prevents the background from
        // jumping when the keyboard appears
        resizeToAvoidBottomInset: false,
        // body: Container(
        //   height: 1.sh,
        //   width: 1.sw,
        //   decoration: const BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage(AppConstants.appBgImage),
        //       // fit: BoxFit.fill,
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        //   child: child,
        // ),
        body: CustomBackgroundWrapper(
          imagePath: AppConstants.appBgImage,
          child: child,
        ),
      ),
    );
  }
}
