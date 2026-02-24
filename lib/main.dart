// import 'package:famzy_tourz_v2/constants.dart';
// import 'package:famzy_tourz_v2/data/services/link_service.dart';
// import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
// import 'package:famzy_tourz_v2/firebase_options.dart';
// import 'package:famzy_tourz_v2/presentation/providers/auth_provider.dart';
// import 'package:famzy_tourz_v2/presentation/providers/main_provider.dart';
// import 'package:famzy_tourz_v2/presentation/providers/splash_provider.dart';
// import 'package:famzy_tourz_v2/routes/app_routes.dart';
// import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // firebase initialization
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   // await LinkService.init();
//   runApp(const FamzyApp());
// }

// class FamzyApp extends StatefulWidget {
//   const FamzyApp({super.key});

//   @override
//   State<FamzyApp> createState() => _FamzyAppState();
// }

// class _FamzyAppState extends State<FamzyApp> {
//   @override
//   void initState() {
//     super.initState();
//     // 3. Start listening for deep links AFTER the app structure is created
//     // We use microtask to ensure the build method has started
//     // Future.microtask(() => LinkService.init());

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       LinkService.init();
//     });
//     // 2. The "Watcher": Listen for forced logouts
//     FirebaseAuth.instance.authStateChanges().listen((User? user) {
//       // FIX: Check if the widget is still in the tree before using context
//       if (!mounted) return;
//       if (user == null) {
//         // If the user becomes null suddenly (revoked),
//         // clear local data and kick to welcome screen.
//         final authProvider = Provider.of<AuthProvider>(context, listen: false);
//         // 2. IMPORTANT: Check where we currently are
//         // If we are already on Splash or Welcome, don't trigger logout again
//         final currentRoute = ModalRoute.of(context)?.settings.name;
//         if (currentRoute == AppRoutes.splash ||
//             currentRoute == AppRoutes.welcome) {
//           return;
//         }
//         // Only trigger if we aren't already on the welcome/login screen
//         authProvider.emailSignOut();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(390, 844),
//       minTextAdapt: true,
//       builder: (_, child) {
//         return MultiProvider(
//           providers: [
//             ChangeNotifierProvider(create: (_) => AuthProvider()),
//             ChangeNotifierProvider(create: (_) => SplashProvider()),
//             ChangeNotifierProvider(create: (_) => MainProvider()),
//           ],
//           child: MaterialApp(
//             title: 'FAMZY Tourz',
//             theme: ThemeData(
//               useMaterial3: false, // important for consistent behavior

//               textSelectionTheme: const TextSelectionThemeData(
//                 cursorColor: AppConstants.tertiaryColor,
//                 selectionColor: AppConstants.primaryTransGColor,
//                 selectionHandleColor: AppConstants.tertiaryColor,
//               ),
//             ),
//             debugShowCheckedModeBanner: false,
//             navigatorKey: NavigationService().navigatorKey,
//             initialRoute: AppRoutes.splash,
//             onGenerateRoute:
//                 AppRoutes.generateRoute, // handling all route creation
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/firebase_options.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/auth_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/user_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/add_package_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/admin_bookings_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/booking_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/desstinations_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/payment_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/user_bookings_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/main_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/splash_provider.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:famzy_tourz_v2/routes/app_routes_obsserver.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Pre-initialize ScreenUtil for sizing logic
  await ScreenUtil.ensureScreenSize();

  // // This is the CRITICAL part for development
  // await FirebaseAppCheck.instance.activate(
  //   // This allows you to bypass Play Integrity while you are developing
  //   androidProvider: AndroidProvider.debug,
  // );

  // // This activates App Check and fixes the "empty reCAPTCHA token"
  // await FirebaseAppCheck.instance.activate(

  //   // If you're debugging, use the debug provider.
  //   // Once you have a Play Console account, use playIntegrity for release.
  //   androidProvider: kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
  //   appleProvider: AppleProvider.debug,
  // );
  // This is the latest syntax for version 0.4.1+3
  await FirebaseAppCheck.instance.activate(
    // Use the Debug provider for development
    // In production, you will change this to PlayIntegrityAppCheckProvider()
    providerAndroid: kDebugMode
        ? const AndroidDebugProvider()
        : const AndroidPlayIntegrityProvider(),
    providerApple: kDebugMode
        ? const AppleDebugProvider()
        : const AppleDeviceCheckProvider(),
  );
  runApp(
    // MOVED: Providers are now at the very top of the widget tree
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        // ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<UserProvider, AuthProvider>(
          create: (context) => AuthProvider(context.read<UserProvider>()),
          update: (context, userProvider, previous) =>
              previous ?? AuthProvider(userProvider),
        ),

        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => DestinationsProvider()),
        // ChangeNotifierProvider(
        //   create: (_) => AddPackageProvider(),
        // ),
        ChangeNotifierProxyProvider<UserProvider, AddPackageProvider>(
          create: (context) => AddPackageProvider(context.read<UserProvider>()),
          update: (context, userProvider, previous) =>
              previous ?? AddPackageProvider(userProvider),
        ),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => UserBookingsProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => AdminBookingsProvider()),
      ],
      child: const FamzyApp(),
    ),
  );
}

// class FamzyApp extends StatefulWidget {
//   const FamzyApp({super.key});

//   @override
//   State<FamzyApp> createState() => _FamzyAppState();
// }

// class _FamzyAppState extends State<FamzyApp> {
//   // Store subscription to prevent memory leaks
//   StreamSubscription<User?>? _authSubscription;

//   @override
//   void initState() {
//     super.initState();

//     // 1. Deep Link initialization
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       LinkService.init();
//     });

//     // 2. The Auth Watcher: Listens for forced logouts or session changes
//     _authSubscription = FirebaseAuth.instance.authStateChanges().listen((
//       User? user,
//     ) {
//       if (!mounted) return;

//       if (user == null) {
//         // Now context works because Provider is above this widget
//         final authProvider = Provider.of<AuthProvider>(context, listen: false);

//         // Uses our NavigationService to check current location
//         final currentRoute = NavigationService().currentRouteName;

//         // Only sign out if we aren't already on the login/splash path
//         if (currentRoute != AppRoutes.splash &&
//             currentRoute != AppRoutes.welcome &&
//             currentRoute != AppRoutes.login &&
//             currentRoute != AppRoutes.signup &&
//             currentRoute != AppRoutes.enterEmail &&
//             currentRoute != null) {
//           debugPrint('done you are out*************=$currentRoute');
//           authProvider.emailSignOut();
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     // CRITICAL: Stop listening when the app is destroyed
//     _authSubscription?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(390, 844),
//       minTextAdapt: true,
//       builder: (context, child) {
//         return MaterialApp(
//           title: 'FAMZY Tourz',
//           theme: ThemeData(
//             scaffoldBackgroundColor: AppConstants.primaryTransGColor,
//             useMaterial3: false, // Ensures consistent UI for your design
//             textSelectionTheme: const TextSelectionThemeData(
//               cursorColor: AppConstants.tertiaryColor,
//               selectionColor: AppConstants.primaryTransGColor,
//               selectionHandleColor: AppConstants.tertiaryColor,
//             ),
//             // // 1. APPLY MONTSERRAT GLOBALLY
//             // textTheme:
//             //     GoogleFonts.montserratTextTheme(
//             //       Theme.of(context).textTheme,
//             //     ).copyWith(
//             //       // 2. DEFINE YOUR 60.sp HERO STYLE HERE
//             //       displayLarge: GoogleFonts.montserrat(
//             //         fontSize: 60.sp,
//             //         fontWeight: FontWeight.bold,
//             //         color: Colors.white,
//             //         shadows: [
//             //           Shadow(
//             //             blurRadius: 100.0,
//             //             color: AppConstants.blackColorP5,
//             //             offset: const Offset(2, 2),
//             //           ),
//             //         ],
//             //       ),
//             //     ),
//           ),
//           debugShowCheckedModeBanner: false,
//           navigatorKey: NavigationService().navigatorKey,
//           navigatorObservers: [
//             AppRouteObserver(),
//           ], // Connects the route tracker
//           initialRoute: AppRoutes.splash,
//           onGenerateRoute: AppRoutes.generateRoute,
//         );
//       },
//     );
//   }
// }

class FamzyApp extends StatelessWidget {
  const FamzyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'FAMZY Tourz',
          theme: ThemeData(
            scaffoldBackgroundColor: AppConstants.primaryTransGColor,
            useMaterial3: false,
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: AppConstants.tertiaryColor,
              selectionColor: AppConstants.primaryTransGColor,
              selectionHandleColor: AppConstants.tertiaryColor,
            ),
            radioTheme: RadioThemeData(
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppConstants.primaryColor;
                }
                return AppConstants.whiteColorP5;
              }),
            ),
          ),
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigationService().navigatorKey,
          navigatorObservers: [AppRouteObserver()],
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
