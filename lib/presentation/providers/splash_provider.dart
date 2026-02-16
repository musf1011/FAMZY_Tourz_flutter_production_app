// //created by: FAMZY CodeWorks
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
// import 'package:famzy_tourz_v2/data/services/session_service.dart';
// import 'package:famzy_tourz_v2/routes/app_routes.dart';
// import 'package:flutter/material.dart';

// class SplashProvider extends ChangeNotifier {
//   final NavigationService _navigation = NavigationService();

//   Future<void> initialize() async {
//     final status = await SessionService.getSessionStatus();

//     if (status.isLoggedIn && status.isProfileCompleted) {
//       await _navigation.navigateReplacement(AppRoutes.main);
//     }
//     if (status.isLoggedIn && !status.isProfileCompleted) {
//       if (!status.isEmailVerified) {
//         await _navigation.navigateReplacement(AppRoutes.emailVerification);
//         return;
//       }
//       if (!status.hasAdditionalInfo) {
//         await _navigation.navigateReplacement(AppRoutes.additionalInfoScreen);
//         return;
//       }
//     }

//     _navigation.showSnackBar(
//       title: 'Welcome!',
//       message: 'Here we go \n "AROUND THE WORLD"',
//       type: ContentType.success,
//     );
//     await _navigation.navigateReplacement(AppRoutes.welcome);
//     return;
//   }
// }

// created by: FAMZY CodeWorks
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:famzy_tourz_v2/data/services/auth-services/email_auth_service.dart';
import 'package:famzy_tourz_v2/data/services/link_service.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/data/services/session_service.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/user_provider.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashProvider extends ChangeNotifier {
  final NavigationService _navigation = NavigationService();

  Future<void> initialize(BuildContext context) async {
    final userProvider = context.read<UserProvider>();
    // 1️⃣ WAIT until UserProvider finishes initializing
    while (userProvider.initializing) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    //DEEP LINK HAS ABSOLUTE PRIORITY
    if (LinkService.pendingRoute != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        LinkService.consume(_navigation);
      });
      return;
    }

    // 2. NORMAL SESSION FLOW
    final status = await SessionService.getSessionStatus();

    debugPrint('******splash provider is logged in: ${status.isLoggedIn}');
    debugPrint('******is profile completed: ${status.isProfileCompleted}');
    debugPrint('******has additional info: ${status.hasAdditionalInfo}');
    debugPrint('******is email verified: ${status.isEmailVerified}');

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (status.isLoggedIn && status.isProfileCompleted) {
        await _navigation.navigateReplacement(AppRoutes.main);
        return;
      }

      if (status.isLoggedIn && !status.isProfileCompleted) {
        if (!status.isEmailVerified) {
          await EmailAuthService.instance.sendVerificationEmail(null);
          await _navigation.navigateReplacement(AppRoutes.emailVerification);
          return;
        }

        if (!status.hasAdditionalInfo) {
          await _navigation.navigateReplacement(AppRoutes.additionalInfoScreen);
          return;
        }
      }

      // 3. FALLBACK (NEW / LOGGED OUT USER)
      _navigation.showSnackBar(
        title: 'Welcome!',
        message: 'Here we go \n "AROUND THE WORLD"',
        type: ContentType.success,
      );

      await _navigation.navigateReplacement(AppRoutes.welcome);
    });
  }
}
