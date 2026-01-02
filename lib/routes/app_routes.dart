import 'package:famzy_tourz_v2/presentation/screens/Auth/additional_info_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/Auth/email_verification_pending_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/Auth/forgotpassword/enter_email_for_reset_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/Auth/forgotpassword/reset_email_sent_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/Auth/signup_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/mainscreens/main_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String welcome = '/welcome';
  static const String main = '/main';
  static const String signup = '/signup';
  static const String additionalInfoScreen = '/addInfo';
  static const String emailVerification = '/email_verification';
  static const String enterEmail = '/enter_email';
  static const String resetEmailSent = '/reset_email_sent';

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
      case AppRoutes.emailVerification:
        return MaterialPageRoute(
          builder: (_) => const EmailVerificationPendingScreen(),
        );
      case main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case _:
        // default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
