//created by: FAMZY CodeWorks
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/data/services/session_service.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier {
  final NavigationService _navigation = NavigationService();

  Future<void> initialize() async {
    final status = await SessionService.getSessionStatus();

    if (status.isLoggedIn && status.isProfileCompleted) {
      await _navigation.navigateReplacement(AppRoutes.main);
    }
    if (status.isLoggedIn && !status.isProfileCompleted) {
      if (!status.isEmailVerified) {
        await _navigation.navigateReplacement(AppRoutes.emailVerification);
        return;
      }
      if (!status.hasAdditionalInfo) {
        await _navigation.navigateReplacement(AppRoutes.additionalInfoScreen);
        return;
      }
    }

    _navigation.showSnackBar(
      title: 'Welcome!',
      message: 'Here we go \n "AROUND THE WORLD"',
      type: ContentType.success,
    );
    await _navigation.navigateReplacement(AppRoutes.welcome);
    return;
  }
}
