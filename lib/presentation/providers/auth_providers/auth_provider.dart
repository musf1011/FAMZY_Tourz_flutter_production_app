//created by: FAMZY CodeWorks
import 'dart:async';
import 'dart:math';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:famzy_tourz_v2/data/services/auth-services/email_auth_service.dart';
import 'package:famzy_tourz_v2/data/services/auth-services/firestor_user_service.dart';
import 'package:famzy_tourz_v2/data/services/auth-services/google_auth_service.dart';
import 'package:famzy_tourz_v2/data/services/auth-services/password_reset_service.dart';
import 'package:famzy_tourz_v2/data/services/navigation_service.dart';
import 'package:famzy_tourz_v2/data/services/session_service.dart';
import 'package:famzy_tourz_v2/presentation/providers/auth_providers/user_provider.dart';
import 'package:famzy_tourz_v2/presentation/widgets/dialogs/custom_app_confirm_dialog.dart';
import 'package:famzy_tourz_v2/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  // final TextEditingController _fullName = TextEditingController();
  // final TextEditingController _email = TextEditingController();
  // final TextEditingController _password = TextEditingController();
  // final TextEditingController _confirmPassword = TextEditingController();
  // final TextEditingController _age = TextEditingController();
  String fullName = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String age = '';

  final TextEditingController ageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final NavigationService _navigation = NavigationService();
  final GoogleAuthService _googleAuth = GoogleAuthService.instance;

  final UserProvider _userProvider;

  AuthProvider(this._userProvider);
  bool _loading = false;
  bool get loading => _loading;

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void resetLoading() {
    _loading = false;
    notifyListeners();
  }

  String? _uid;
  String? get uid => _uid;

  bool get isAuthenticated => _uid != null;

  void setUid(String uid) {
    _uid = uid;
    notifyListeners();
  }

  void clear() {
    _uid = null;
    notifyListeners();
  }

  // //check profile completeness
  // Future<bool> checkAndSyncProfileStatus(String uid) async {
  //   try {
  //     final doc = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(uid)
  //         .get();

  //     final data = doc.data();
  //     final bool hasAge = data != null && data['age'] != null;

  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('hasAge', hasAge);

  //     return hasAge;
  //   } catch (e) {
  //     // In production, log this error to a service like Sentry or Crashlytics
  //     return false;
  //   }
  // }

  int _requestSessionId = 0; // The "Cancel Token" counter
  // Call this when the user clicks "Back"
  void cancelAuthentication() {
    _requestSessionId++; // This invalidates the current signInWithEmail "session"
    _setLoading(false);
    debugPrint('******loading in cancel auth= $loading');
    notifyListeners();
  }

  //email & password signin for existing account
  Future<void> signInWithEmail(
    // String email, String password
  ) async {
    // // Increment counter to mark a NEW request session
    // final int sessionId = ++_activeRequestCounter;
    // Capture the ID at the start of THIS specific function call
    final int currentSessionId = _requestSessionId;
    try {
      _setLoading(true);
      debugPrint('*****$email & $password');
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // --- THE CANCEL CHECK ---
      // If the user pressed 'Back', cancelAuthentication() was called,
      // incrementing _requestSessionId. Now currentId != _requestSessionId.
      if (currentSessionId != _requestSessionId) return;

      // final firebaseUser = _auth.currentUser;
      // if (firebaseUser != null) {
      //   setUid(firebaseUser.uid);
      //   // Load user data via UserProvider if context is available
      //   await _userProvider.loadUser(firebaseUser.uid);
      //   debugPrint('*****here we go to sign in');
      // }
      debugPrint('***no way');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      await HapticFeedback.lightImpact();

      _navigation.showSnackBar(
        title: 'Welcome Back',
        message: 'Signed in successfully',
        type: ContentType.success,
      );

      final status = await SessionService.getSessionStatus();
      print('****sign in is email verified: ${status.isEmailVerified}');
      print('****has additioinal info: ${status.hasAdditionalInfo}');
      print('****is logged in: ${status.isLoggedIn}');
      print('****is profile completed : ${status.isProfileCompleted}');

      // 2. Final check before we trigger ANY navigation side effects
      if (currentSessionId == _requestSessionId) {
        if (!status.isEmailVerified) {
          await handleEmailVerification(null);
        } else if (!status.hasAdditionalInfo) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _navigation.navigateAndClearStack(AppRoutes.additionalInfoScreen);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _navigation.navigateAndClearStack(AppRoutes.main);
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Sign In Failed',
        message: _getFirebaseErrorMessage(e.code),
        type: ContentType.failure,
      );
    } catch (e) {
      if (currentSessionId != _requestSessionId) return;
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Error',
        message: 'Something went wrong. Please try again',
        type: ContentType.failure,
      );
    } finally {
      // Only set loading to false if this is still the active session
      if (currentSessionId == _requestSessionId) {
        _setLoading(false);
      }
    }
  }

  Future<void> signInWithGoogle() async {
    final currentSessionId = _requestSessionId;
    try {
      _setLoading(true);

      final result = await _googleAuth.signInWithGoogle();

      //user cancelled
      if (result == null) {
        _setLoading(false);
        return;
      }
      debugPrint('***here we go isnnew user: ${result.isNewUser}');

      if (currentSessionId != _requestSessionId) return;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setBool('isEmailVerified', true);

      await HapticFeedback.lightImpact();

      _navigation.showSnackBar(
        title: 'Success',
        message: 'Signed in with Google',
        type: ContentType.success,
      );
      if (result.isNewUser) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _navigation.navigateAndClearStack(AppRoutes.additionalInfoScreen);
        });
      }

      //load user info if already registered
      // final firebaseUser = _auth.currentUser;

      // if (firebaseUser != null) {
      //   debugPrint('********doen"$firebaseUser');
      //   setUid(firebaseUser.uid);
      //   await _userProvider.loadUser(firebaseUser.uid);
      // }

      //to ask where to go
      final status = await SessionService.getSessionStatus();

      if (currentSessionId == _requestSessionId) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!status.hasAdditionalInfo) {
            _navigation.navigateAndClearStack(AppRoutes.additionalInfoScreen);
            return;
          }
          _navigation.navigateAndClearStack(AppRoutes.main);
        });
      }
    } on TimeoutException {
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Timeout',
        message: 'Google sign in took too long. Please try again',
        type: ContentType.warning,
      );
    } on FirebaseAuthException catch (e) {
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Google Sign In Failed',
        message: _getFirebaseErrorMessage(e.code),
        type: ContentType.failure,
      );
    } on PlatformException catch (e) {
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Error',
        message: _getFirebaseErrorMessage(e.code),
        type: ContentType.failure,
      );
    } catch (e) {
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Error',
        message: _getFirebaseErrorMessage(e.toString()),
        type: ContentType.failure,
      );
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> submitAdditionalInfo(
    // {
    // required int age,
    // required String gender,
    // }
  ) async {
    final currentSessionId = _requestSessionId;
    try {
      _setLoading(true);

      debugPrint('*****submitting');
      // await FirestoreUserService.addInfo(age, gender);
      await FirestoreUserService.addInfo(age, selectedGender ?? 'other');
      if (currentSessionId != _requestSessionId) return false;
      debugPrint('*****submitted');
      await HapticFeedback.lightImpact();

      _navigation.showSnackBar(
        title: 'Profile Updated',
        message: 'Your information has been saved',
        type: ContentType.success,
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasAge', true);
      await prefs.setBool('isProfileCompleted', true);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigation.navigateReplacement(AppRoutes.main);
      });
      return true;
    } catch (_) {
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Error',
        message: 'Failed to save information',
        type: ContentType.failure,
      );
      return false;
    } finally {
      _setLoading(false);
    }
  }

  //if new, signn up using email & password
  Future<bool> signUpWithEmail(
    // {
    // required String fullName,
    // required String email,
    // required String password,
    // required int age,
    // required String? gender,
    // }
  ) async {
    final currentSessionId = _requestSessionId;
    try {
      _setLoading(true);

      debugPrint(
        '***1st step $email and $password , **$fullName , ** $age , ***$selectedGender ,',
      );
      //create firebase user
      final userCred = await EmailAuthService.instance.signUpWithEmail(
        email.trim(),
        password.trim(),
      );
      if (currentSessionId != _requestSessionId) return false;
      debugPrint('***2nd step');
      final user = userCred.user;
      // if (user == null) {
      //   throw Exception('Failed to create user.');
      // }
      // setUid(user.uid);
      // await _userProvider.loadUser(user.uid);

      // debugPrint('***3rd step; user uid: ${user!.uid}');
      //save user in Firestore
      // await EmailAuthService.instance.saveUserToFirestore(
      //   uid: user!.uid,
      //   fullName: fullName,
      //   email: email,
      //   // age: int.parse(age),
      //   age: age.isEmpty ? 0 : int.parse(age),
      //   gender: selectedGender ?? 'other',
      //   photoUrl: '',
      // );
      debugPrint('***2nd step');

      await EmailAuthService.instance.saveUserToFirestore(
        userId: user!.uid,
        fullName: fullName.trim(),
        email: email.trim(),
        age: age.isEmpty ? '' : age,
        gender: selectedGender ?? 'other',
      );

      debugPrint('***3.5th step');
      if (currentSessionId != _requestSessionId) return false;
      debugPrint('***4thst step');
      //logged in saved locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setBool('hasAdditionalInfo', true);
      await handleEmailVerification(user);

      _navigation.showSnackBar(
        title: 'Account Created',
        message: 'Verification email has been sent',
        type: ContentType.success,
      );
      debugPrint('***5th step the last step succes is true now');
      // await prefs.setBool('isProfileCompleted', true);
      // print('*****is logged in: ${getbool}');

      // //send verification email
      // await EmailAuthService.instance.sendVerificationEmail(user);

      // await HapticFeedback.lightImpact();

      // // _navigation.showSnackBar(
      // //   title: 'Account Created',
      // //   message: 'Verification email has been sent',
      // //   type: ContentType.success,
      // // );

      // // _setLoading(false);
      // // 2. NORMAL SESSION FLOW
      // final status = await SessionService.getSessionStatus();
      // print('******signup screen: is logged in: ${status.isLoggedIn}');
      // print('******is profile completed: ${status.isProfileCompleted}');
      // print('******has additional info: ${status.hasAdditionalInfo}');
      // print('******is email verified: ${status.isEmailVerified}');
      // //navigate to email verification pending screen
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   _navigation.navigateAndClearStack(AppRoutes.emailVerification);
      // });
      return true;
    } on FirebaseAuthException catch (e) {
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Sign Up Failed',
        message: _getFirebaseErrorMessage(e.code),
        type: ContentType.failure,
      );
      return false;
    } on PlatformException catch (e) {
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Sign Up Failed',
        message: _getFirebaseErrorMessage(e.code),
        type: ContentType.failure,
      );
      return false;
    } catch (e) {
      await HapticFeedback.mediumImpact();
      _navigation.showSnackBar(
        title: 'Error',
        message: 'Sign up failed. Please try again',
        type: ContentType.failure,
      );
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> handleEmailVerification(User? user) async {
    try {
      await EmailAuthService.instance.sendVerificationEmail(user);
      await HapticFeedback.lightImpact();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigation.navigateAndClearStack(AppRoutes.emailVerification);
      });
    } catch (e) {
      _navigation.showSnackBar(
        title: 'Error in Sending verification Email',
        message: 'Error: $e',
      );
    } finally {
      _setLoading(false);
    }
  }

  String _getFirebaseErrorMessage(String code) {
    switch (code) {
      // --- GOOGLE / PLAY SERVICES SPECIFIC ---
      case '4908':
      case 'Clear Failed':
      case 'service-version-update-required': // Some plugins use this kebab-case
      case 'SERVICE_VERSION_UPDATE_REQUIRED':
        return 'Please update Google Play Services to continue.';
      case 'API_NOT_CONNECTED':
        return 'Google Play Services not available';
      case 'api-not-available':
        return 'Google Play Services is not available on this device.';
      case 'service-invalid':
        return 'Google Play Services is outdated or missing.';
      case 'sign-in-failed':
        return 'Google Sign-In failed. Please try again.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different login method.';
      case 'Connection with Google Play Services was not successful':
        return 'Google Play Services Error';
      case 'internal_error':
        return 'Google Play Services internal error. Try restarting your phone.';
      // --- AUTH SPECIFIC ---
      case 'wrong-password':
        return 'Incorrect Password';
      case 'invalid-credential':
        return 'Invalid email or password';
      case 'user-not-found':
        return 'No account found with this email';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'invalid-email':
        return 'Invalid email format';
      case 'email-already-in-use':
        return 'Email is already registered';
      case 'weak-password':
        return 'Password is too weak';
      // --- DEEP LINK / ACTION CODE SPECIFIC ---
      case 'invalid-action-code':
        return 'This link is invalid, expired, or has already been used.';
      case 'expired-action-code':
        return 'This link has expired. Please request a new one.';
      case 'action-code-settings-invalid':
        return 'There was a configuration error. Please contact support.';
      // --- GENERAL ---
      case 'network-request-failed':
        return 'No internet connection. Please check your network.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return 'Operation failed. Please try again. Google Play Services may cause it.';
    }
  }

  bool _emailChecking = false;
  bool _canResendEmail = false;
  int _resendCooldown = 60;

  bool get emailChecking => _emailChecking;
  bool get canResendEmail => _canResendEmail;
  int get resendCooldown => _resendCooldown;

  Timer? _verificationTimer;
  Timer? _cooldownTimer;

  void startEmailVerificationFlow() {
    _navigation.showSnackBar(
      title: 'Action Required!',
      message: 'Please check your inbox to activate your account.',
      type: ContentType.warning,
    );
    _startVerificationCheck();
    _startCooldownTimer();
  }

  void _startVerificationCheck() {
    _verificationTimer?.cancel();
    _verificationTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => checkEmailVerification(),
    );
  }

  void _startCooldownTimer() {
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_resendCooldown > 0) {
        _resendCooldown--;
      } else {
        _canResendEmail = true;
      }
      notifyListeners();
    });
  }

  Future<void> checkEmailVerification() async {
    if (_emailChecking) return;

    try {
      _emailChecking = true;
      notifyListeners();

      await _auth.currentUser?.reload();
      final user = _auth.currentUser;

      // print('user*****: ${user!.emailVerified}');
      // 2. NORMAL SESSION FLOW
      // final status = await SessionService.getSessionStatus();
      // print('******email pending screen: is logged in: ${status.isLoggedIn}');
      // print('******is profile completed: ${status.isProfileCompleted}');
      // print('******has additional info: ${status.hasAdditionalInfo}');
      // print('******is email verified: ${status.isEmailVerified}');
      if (user != null && user.emailVerified) {
        _verificationTimer?.cancel();
        _cooldownTimer?.cancel();

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isEmailVerified', true);
        await prefs.setBool('isProfileCompleted', true);

        // _setLoading(false);

        //////******navigate without await to avoid finally block interference
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _navigation.navigateAndClearStack(AppRoutes.main);
        });
      }
    } catch (e) {
      _navigation.showSnackBar(
        title: 'Status Check Failed',
        message: 'We encountered a minor issue while checking...',
        type: ContentType.warning,
      );
    } finally {
      _emailChecking = false;
      _setLoading(false);
    }
  }

  Future<void> resendVerificationEmail() async {
    if (!_canResendEmail) return;

    _setLoading(true);
    _canResendEmail = false;
    _resendCooldown = 60;
    notifyListeners();

    try {
      await _auth.currentUser?.sendEmailVerification();

      _navigation.showSnackBar(
        title: 'Email Sent',
        message: 'Verification email has been resent',
        type: ContentType.success,
      );
    } finally {
      _setLoading(false);
    }
  }

  void disposeEmailVerificationFlow() {
    _verificationTimer?.cancel();
    _cooldownTimer?.cancel();
    checkEmailVerification();
  }

  Future<void> emailSignOut() async {
    try {
      _setLoading(true);
      _navigation.showSnackBar(
        title: 'Signing you out',
        message: 'You will be signed out and returned to the welcome screen',
        type: ContentType.help,
        duration: 2,
      );

      //  Sign out from all services
      await _auth.signOut();
      // await GoogleSignIn.instance.signOut();
      // await GoogleAuthService.instance.googleSignOut();
      try {
        await GoogleAuthService.instance.googleSignOut();
      } catch (e) {
        // We ignore this error because the user is already signed out of Firebase
      }

      // //clear Local Data base
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.clear(); //total reset for safety
      await SessionService.clearSession();

      await HapticFeedback.lightImpact();

      _setLoading(false);

      await _navigation.navigateAndClearStack(AppRoutes.welcome);
    } on FirebaseAuthException {
      _navigation.showSnackBar(
        title: 'Sign out failed',
        // message: 'Please check your connection and try again.',
        message: _getFirebaseErrorMessage(e.toString()),
        type: ContentType.failure,
      );
    } on PlatformException catch (e) {
      _navigation.showSnackBar(
        title: 'Sign out failed',
        // message: 'Please check your connection and try again.',
        message: _getFirebaseErrorMessage(e.code),
        type: ContentType.failure,
      );
    } catch (e) {
      _navigation.showSnackBar(
        title: 'Sign out failed',
        // message: 'Please check your connection and try again.',
        message: _getFirebaseErrorMessage(e.toString()),
        type: ContentType.failure,
      );
    } finally {
      _setLoading(false);
    }
  }

  //reset password logic

  //vilidate email
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    if (!isValidEmail(email)) {
      _navigation.showSnackBar(
        title: 'Invalid Email',
        message: 'Please enter a valid email address',
        type: ContentType.failure,
      );
      return;
    }

    //ask confirmation using custom dialog
    final confirmed = await AppConfirmDialog.show(
      context,
      title: 'Confirm Email',
      message: 'Is this email correct?\n\n$email',
      confirmText: 'Send Reset Link',
      icon: Icons.mark_email_read_rounded,
    );

    if (!confirmed) return;

    try {
      _setLoading(true);

      await PasswordResetService.sendResetEmail(email);

      await HapticFeedback.lightImpact();

      _navigation.showSnackBar(
        title: 'Email Sent',
        // message: 'Password reset link sent to $email',
        message:
            'If an account exists for $email, you will receive a reset link shortly.',
        type: ContentType.success,
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigation.navigateReplacement(
          AppRoutes.resetEmailSent,
          arguments: email,
        );
      });
    } on FirebaseAuthException catch (e) {
      _navigation.showSnackBar(
        title: 'Reset Email Sending Failed',
        message: _getFirebaseErrorMessage(e.code),
        type: ContentType.failure,
      );
    } finally {
      _setLoading(false);
    }
  }

  bool _showResetSuccessAnimation = false;
  bool get showResetSuccessAnimation => _showResetSuccessAnimation;
  //reset password screen
  Future<void> confirmResetPassword({
    required String oobCode,
    required String newPassword,
  }) async {
    try {
      _setLoading(true);

      await _auth.confirmPasswordReset(code: oobCode, newPassword: newPassword);
      _showResetSuccessAnimation = true;
      notifyListeners();

      _navigation.showSnackBar(
        title: 'Password ',
        message:
            'Your password has been reset successfully \nEnter credentials to Log In',
        type: ContentType.success,
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigation.navigateAndClearStack(AppRoutes.welcome);
      });
    } on FirebaseAuthException catch (e) {
      _navigation.showSnackBar(
        title: 'Reset Failed',
        message: _getFirebaseErrorMessage(e.code),
        // message: '$e',
        type: ContentType.failure,
      );
      // If the link is dead, send them back to start the process over
      if (e.code == 'invalid-action-code') {
        Future.delayed(const Duration(seconds: 2), () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _navigation.navigateAndClearStack(AppRoutes.welcome);
          });
        });
      }
    } finally {
      _setLoading(false);
    }
  }

  // Function to handle cleanup after animation finishes
  void onResetAnimationComplete() {
    _showResetSuccessAnimation = false;
    notifyListeners();
    _navigation.navigateAndClearStack(AppRoutes.login);
  }

  UserType _selectedUserType = UserType.tourist;
  UserType get selectedUserType => _selectedUserType;

  bool get isCompany => _selectedUserType == UserType.company;

  void setUserType(UserType userType) {
    _selectedUserType = userType;
    notifyListeners();
  }

  bool _isPasswordVisible = true;
  bool get isPasswordVisible => _isPasswordVisible;
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  String? _selectedGender;
  String? get selectedGender => _selectedGender;
  void selectGender(String? selectedGender) {
    _selectedGender = selectedGender;
    debugPrint('**** selected gender: $_selectedGender ******');
  }

  /// RESET ALL FIELDS
  void reset() {
    email = '';
    password = '';
    confirmPassword = '';
    age = '';
    _selectedGender = null;
    fullName = '';
    // 1. DO NOT call ageController.dispose() here!
    // Just clear the text instead.
    ageController.clear();

    // 2. REMOVE super.dispose();
    // 3. REMOVE any other logic that "kills" the class
    notifyListeners();
  }
}

// Define an enum for clarity
enum UserType { company, tourist } //
