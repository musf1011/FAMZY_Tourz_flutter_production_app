import 'package:famzy_tourz_v2/constants.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/firebase_options.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/main_provider.dart';
import 'package:famzy_tourz_v2/presentation/providers/splash_provider.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const FamzyApp());
}

class FamzyApp extends StatelessWidget {
  const FamzyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (_, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => SplashProvider()),
            ChangeNotifierProvider(create: (_) => MainProvider()),
          ],
          child: MaterialApp(
            title: 'FAMZY Tourz',
            theme: ThemeData(
              useMaterial3: false, // important for consistent behavior

              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: AppConstants.tertiaryColor,
                selectionColor: AppConstants.primaryTransGColor,
                selectionHandleColor: AppConstants.tertiaryColor,
              ),
            ),
            debugShowCheckedModeBanner: false,
            navigatorKey: NavigationService().navigatorKey,
            initialRoute: AppRoutes.splash,
            onGenerateRoute:
                AppRoutes.generateRoute, // handling all route creation
          ),
        );
      },
    );
  }
}
