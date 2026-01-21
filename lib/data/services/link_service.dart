// // created by: FAMZY CodeWorks
// import 'package:app_links/app_links.dart';
// import 'package:flutter/material.dart';

// import 'navigation_service.dart';
// import '../../routes/app_routes.dart';

// class LinkService {
//   static final AppLinks _appLinks = AppLinks();
//   static final NavigationService _navigation = NavigationService();

//   static Future<void> init() async {
//     // Cold start
//     final Uri? initialUri = await _appLinks.getInitialLink();
//     if (initialUri != null) {
//       _handleUri(initialUri);
//     }

//     // Background / foreground
//     _appLinks.uriLinkStream.listen(
//       (uri) => _handleUri(uri),
//       onError: (err) {
//         debugPrint('App link error: $err');
//       },
//     );
//   }

//   static void _handleUri(Uri uri) async {
//     print('DEBUG: Received URI: $uri');
//     final mode = uri.queryParameters['mode'];
//     final oobCode = uri.queryParameters['oobCode'];

//     if (mode == null || oobCode == null) return;
//     // Add a small delay to ensure the app's navigation stack is ready
//     await Future.delayed(const Duration(seconds: 1));

//     switch (mode) {
//       case 'resetPassword':
//         await _navigation.navigateAndClearStack(
//           AppRoutes.resetPassword,
//           arguments: oobCode,
//         );
//         break;

//       case 'verifyEmail':
//         await _navigation.navigateReplacement(AppRoutes.emailVerification);
//         break;
//     }
//   }
// }

// import 'package:app_links/app_links.dart';
// import 'package:flutter/widgets.dart';
// import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
// import 'package:famzy_tourz_v2/routes/app_routes.dart';

// class LinkService {
//   static final AppLinks _appLinks = AppLinks();
//   static bool _initialized = false;

//   static Future<void> init() async {
//     if (_initialized) return;
//     _initialized = true;

//     // 1. Handle app opened from terminated state
//     final Uri? initialUri = await _appLinks.getInitialLink();
//     if (initialUri != null) {
//       _handleLink(initialUri);
//     }

//     // 2. Handle app opened while running
//     _appLinks.uriLinkStream.listen((uri) {
//       _handleLink(uri);
//     });
//   }

//   static void _handleLink(Uri uri) {
//     debugPrint('🔗 Raw deep link: $uri');

//     final nav = NavigationService();

//     try {
//       Uri finalUri = uri;

//       // If firebase wrapper link, extract inner link
//       if (uri.queryParameters.containsKey('link')) {
//         final decoded = Uri.decodeFull(uri.queryParameters['link']!);
//         finalUri = Uri.parse(decoded);
//         debugPrint('🔓 Decoded inner link: $finalUri');
//       }

//       final mode = finalUri.queryParameters['mode'];
//       final oob = finalUri.queryParameters['oob'];

//       debugPrint('🎯 Firebase mode: $mode');

//       if (mode == 'resetPassword') {
//         debugPrint(
//           '🎯 Firebase mode: $mode and enter to reset passsssssssssssss',
//         );
//         nav.navigateAndClearStack(AppRoutes.resetPassword, arguments: oob);
//         return;
//       }

//       if (mode == 'verifyEmail') {
//         nav.navigateAndClearStack(AppRoutes.emailVerification);
//         return;
//       }

//       debugPrint('⚠️ Unknown deep link mode');
//     } catch (e) {
//       debugPrint('❌ Deep link parse error: $e');
//     }
//   }
// }

// import 'package:app_links/app_links.dart';
// import 'package:flutter/widgets.dart';
// import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
// import 'package:famzy_tourz_v2/routes/app_routes.dart';

// class LinkService {
//   static final AppLinks _appLinks = AppLinks();
//   static bool _initialized = false;

//   static Future<void> init() async {
//     if (_initialized) return;
//     _initialized = true;

//     final Uri? initialUri = await _appLinks.getInitialLink();
//     if (initialUri != null) {
//       _handleLink(initialUri);
//     }

//     _appLinks.uriLinkStream.listen((uri) {
//       _handleLink(uri);
//     });
//   }

//   static void _handleLink(Uri uri) {
//     debugPrint('🔗 Raw deep link: $uri');

//     try {
//       Uri finalUri = uri;

//       // Firebase wrapper
//       if (uri.queryParameters.containsKey('link')) {
//         final decoded = Uri.decodeFull(uri.queryParameters['link']!);
//         finalUri = Uri.parse(decoded);
//         debugPrint('🔓 Decoded inner link: $finalUri');
//       }

//       final mode = finalUri.queryParameters['mode'];
//       final oobCode = finalUri.queryParameters['oobCode'];

//       debugPrint('🎯 mode=$mode oob=$oobCode');

//       final nav = NavigationService();

//       if (mode == 'resetPassword' && oobCode != null) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           nav.navigateAndClearStack(
//             AppRoutes.resetPassword,
//             arguments: oobCode,
//           );
//         });
//         return;
//       }

//       if (mode == 'verifyEmail') {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           nav.navigateAndClearStack(AppRoutes.emailVerification);
//         });
//         return;
//       }

//       debugPrint('⚠️ Unhandled deep link');
//     } catch (e) {
//       debugPrint('❌ Deep link parse error: $e');
//     }
//   }
// }

import 'package:app_links/app_links.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';

class LinkService {
  static String? pendingRoute;
  static Object? pendingArgs;

  static final AppLinks _appLinks = AppLinks();
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    final Uri? initialUri = await _appLinks.getInitialLink();
    //to open the closed app
    if (initialUri != null) {
      _handleLink(initialUri);
    }

    //when already app is open
    _appLinks.uriLinkStream.listen(_handleLink);
  }

  static void _handleLink(Uri uri) {
    debugPrint('🔗 Raw deep link: $uri');

    Uri finalUri = uri;

    if (uri.queryParameters.containsKey('link')) {
      final decoded = Uri.decodeFull(uri.queryParameters['link']!);
      finalUri = Uri.parse(decoded);
    }

    final mode = finalUri.queryParameters['mode'];
    final oobCode = finalUri.queryParameters['oobCode'];

    if (mode == 'resetPassword' && oobCode != null) {
      pendingRoute = AppRoutes.resetPassword;
      pendingArgs = oobCode;
      return;
    }

    if (mode == 'verifyEmail') {
      FirebaseAuth.instance.applyActionCode(oobCode!);
      pendingRoute = AppRoutes.emailVerification;
      pendingArgs = null;
      return;
    }
  }

  static void consume(NavigationService nav) {
    if (pendingRoute != null) {
      nav.navigateAndClearStack(pendingRoute!, arguments: pendingArgs);
      pendingRoute = null;
      pendingArgs = null;
    }
  }
}
