//created by: FAMZY CodeWorks
import 'package:famzy_tourz_v2/data/models/company_model.dart';
import 'package:famzy_tourz_v2/data/models/package_model.dart';
import 'package:famzy_tourz_v2/presentation/providers/destinations_providers/add_package_provider.dart';
import 'package:famzy_tourz_v2/presentation/screens/Auth/additional_info_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/Auth/email_verification_pending_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/Auth/forgotpassword/enter_email_for_reset_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/Auth/forgotpassword/reset_email_sent_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/Auth/forgotpassword/reset_password_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/Auth/signup_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/admin-screens/add_company_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/admin-screens/admin_bookings_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/mainscreens/company_detail_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/mainscreens/destinations/company_add_package_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/mainscreens/companies_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/mainscreens/destinations/hotel_placeholder_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/mainscreens/destinations/my_bookings_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/mainscreens/destinations/package_detail_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/mainscreens/destinations/packages_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/mainscreens/destinations/passenger_info_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/mainscreens/main_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/mainscreens/profile/profile_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/payment-screens/payment_screen.dart';
import 'package:famzy_tourz_v2/presentation/screens/Auth/welcome/welcome_screen.dart';
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
  //-----main screens----
  static const String main = '/main';
  static const String packages = '/packages';
  static const hotelPlaceholder = '/hotel-placeholder';
  static const companyAddPackage = '/comapany-add-package';
  static const packageDetail = '/package-detail';
  static const passengerInfo = '/passenger-info';
  static const String payment = '/payment';
  static const String companies = '/companies';
  static const String companyDetailScreen = '/company-detail';

  static const String myBookings = '/my-bookings';
  static const String profile = '/profile';
  static const String settings = '/settings';
  // ________________ADMIN screens__________
  static const String adminBookings = '/admin-bookings';
  static const String addCompany = '/add-company';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case additionalInfoScreen:
        return MaterialPageRoute(builder: (_) => AdditionalInfoScreen());
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
      case packageDetail:
        return MaterialPageRoute(builder: (_) => const PackageDetailScreen());
      case passengerInfo:
        return MaterialPageRoute(builder: (_) => const PassengerInfoScreen());
      case payment:
        // final bookingId = settings.arguments as String;
        // final packageId = settings.arguments as String;
        final args = settings.arguments as Map<String, String>?;
        final bookingId = args?['bookingId'] as String;
        final packageId = args?['packageId'] as String;
        return MaterialPageRoute(
          builder: (_) =>
              PaymentScreen(bookingId: bookingId, packageId: packageId),
        );
      case companies:
        return MaterialPageRoute(builder: (_) => const CompaniesScreen());
      case companyDetailScreen:
        final company = settings.arguments as CompanyModel;
        // if (company == null) {
        //   return MaterialPageRoute(builder: (_) => const SplashScreen());
        // }
        return MaterialPageRoute(
          builder: (_) => CompanyDetailScreen(company: company),
        );
      case adminBookings:
        return MaterialPageRoute(builder: (_) => const AdminBookingsScreen());
      case addCompany:
        return MaterialPageRoute(builder: (_) => const AddCompanyScreen());
      case myBookings:
        return MaterialPageRoute(builder: (_) => const MyBookingsScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      // case settings:
      //   return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case _:
        // default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
