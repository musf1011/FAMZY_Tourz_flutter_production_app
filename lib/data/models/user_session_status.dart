class UserSessionStatus {
  final bool isLoggedIn;
  final bool isEmailVerified;
  final bool hasAdditionalInfo;
  final bool isProfileCompleted;

  UserSessionStatus({
    required this.isLoggedIn,
    required this.isEmailVerified,
    required this.hasAdditionalInfo,
    required this.isProfileCompleted,
  });
}
