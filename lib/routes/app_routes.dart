//created by: FAMZY CodeWorks
import 'package:famzy_tourz_v2/data/models/package_model.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/add_package_provider.dart';
import 'package:famzy_tourz_v2/presentation/screens/Auth/additional_info_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/Auth/email_verification_pending_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/Auth/forgotpassword/enter_email_for_reset_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/Auth/forgotpassword/reset_email_sent_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/Auth/forgotpassword/reset_password_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/Auth/signup_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/mainscreens/destinations/company_add_package_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/mainscreens/destinations/hotel_placeholder_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/mainscreens/destinations/packages_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/mainscreens/main_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String welcome = '/welcome';
  static const String signup = '/signup';
  static const String additionalInfoScreen = '/addInfo';
  static const String emailVerification = '/email_verification';
  static const String enterEmail = '/enter_email';
  static const String resetEmailSent = '/reset_email_sent';
  static const String resetPassword = '/reset_password';
  //main screens
  static const String main = '/main';
  static const String packages = '/packages';
  static const hotelPlaceholder = '/hotel-placeholder';
  static const companyAddPackage = '/comapany-add-package';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case additionalInfoScreen:
        return MaterialPageRoute(builder: (_) => const AdditionalInfoScreen());
      case enterEmail:
        return MaterialPageRoute(
          builder: (_) => const EnterEmailForResetScreen(),
        );
      case resetEmailSent:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ResetEmailSentScreen(email: email),
        );
      case resetPassword:
        final oob = settings.arguments;
        if (oob == null || oob is! String) {
          return MaterialPageRoute(builder: (_) => const SplashScreen());
        }
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen(oob: oob));
      case emailVerification:
        return MaterialPageRoute(
          builder: (_) => const EmailVerificationPendingScreen(),
        );
      case main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case hotelPlaceholder:
        // final destination = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => const HotelPlaceholderScreen(),
        );
      case packages:
        return MaterialPageRoute(builder: (_) => const PackagesScreen());
      case companyAddPackage:
        final args = settings.arguments;

        return MaterialPageRoute(
          builder: (BuildContext context) {
            final provider = context.read<AddPackageProvider>();

            if (args != null && args is PackageModel) {
              provider.loadForEdit(args);
            }

            return const CompanyAddPackageScreen();
          },
        );

      case _:
        // default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
