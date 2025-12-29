// // created by FAMZY CodeWorks
// import 'package:flutter/material.dart';

// class NavigationService {
//   static final NavigationService _instance = NavigationService._internal();
//   factory NavigationService() => _instance;
//   NavigationService._internal();

//   GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//   BuildContext? get context => navigatorKey.currentContext;

//   Future<void> navigateTo(String routeName, {Object? arguments}) async {
//     if (context != null) {
//       Navigator.pushNamed(context!, routeName, arguments: arguments);
//     }
//   }

//   Future<void> navigateReplacement(
//     String routeName, {
//     Object? arguments,
//   }) async {
//     if (context != null) {
//       Navigator.pushReplacementNamed(context!, routeName, arguments: arguments);
//     }
//   }

//   void pop() {
//     if (context != null) {
//       Navigator.pop(context!);
//     }
//   }

//   void showSnackBar(String message) {
//     if (context != null) {
//       ScaffoldMessenger.of(
//         context!,
//       ).showSnackBar(SnackBar(content: Text(message)));
//     }
//   }
// }

// created by FAMZY CodeWorks
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:famzy_tourz_v2/constants.dart';
import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext? get context => navigatorKey.currentContext;

  Future<void> navigateTo(String routeName, {Object? arguments}) async {
    if (context != null) {
      await Navigator.pushNamed(context!, routeName, arguments: arguments);
    }
  }

  Future<void> navigateReplacement(
    String routeName, {
    Object? arguments,
  }) async {
    if (context != null) {
      await Navigator.pushReplacementNamed(
        context!,
        routeName,
        arguments: arguments,
      );
    }
  }

  void pop() {
    if (context != null) {
      Navigator.pop(context!);
    }
  }

  //pop until specified route
  void popUntil(String routeName) {
    if (context != null) {
      Navigator.popUntil(context!, (route) => route.settings.name == routeName);
    }
  }

  //clear everything that's in stack
  Future<void> navigateAndClearStack(
    String routeName, {
    Object? arguments,
    bool Function(Route<dynamic>)? predicate,
  }) async {
    if (context != null) {
      await Navigator.pushNamedAndRemoveUntil(
        context!,
        routeName,
        predicate ?? (route) => false, //default, clear all routes
        arguments: arguments,
      );
    }
  }

  //awesome snackbar content
  void showSnackBar({
    required String title,
    required String message,
    ContentType type = ContentType.success,
  }) {
    if (context == null) return;
    // Guard: If the context is null or the widget is unmounted, stop.
    // if (currentContext == null || !currentContext.mounted) return
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      // dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 3),
      content: AwesomeSnackbarContent(
        titleTextStyle: AppConstants.snackbarTitle,
        title: title,
        message: message,
        messageTextStyle: AppConstants.snackbarMessage,
        contentType: type,
      ),
    );

    ScaffoldMessenger.of(context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
