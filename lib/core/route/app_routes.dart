class AppRoutes {
  AppRoutes._privateConstructor();
  static final AppRoutes _instance = AppRoutes._privateConstructor();
  static AppRoutes get instance => _instance;
  /////////////  initial or splash screen
  final String initial = "/";
  final String onBoardingScreen = "/onboarding-screen";
  final String navigationScreen = "/navigation-screen";


  // Auth Routes
  final String loginScreen = "/login-screen";
  final String registerScreen = "/register-screen";
  final String forgetPasswordScreen = "/forget-password-screen";
  final String newPasswordScreen = "/new-password-screen";
  final String forgetOtpVerifyScreen = "/forget-otp-verify-screen";

  // Home Routes
  final String homeScreen = "/home-screen";

  // Reward Routes
  final String rewardScreen = "/reward-screen";
  final String rewardDetailsScreen = "/reward-details-screen";

  // Order Routes
  final String orderScreen = "/order-screen";

  // Gift Card Routes
  final String giftCardScreen = "/gift-card-screen";

  // Profile Routes
  final String profileScreen = "/profile-screen";
  final String settingScreen = "/setting-screen";
  final String changePasswordScreen = "/change-password-screen";
  final String contactUsScreen = "/contact-us-screen";
  final String privicyPolicyScreen = "/privicy-policy-screen";
  final String deleteAccountScreen = "/delete-account-screen";
  final String favorateScreen = "/favorate-screen";
  final String transectionHistoryScreen = "/transection-history-screen";
  final String emailSubscrptionScreen = "/email-subscrption-screen";
  final String editProfileInfoScreen = "/edit-profile-info-screen";
  final String myWalletScreen = "/my-wallet-screen";
  final String walletHistoryScreen = "/wallet-history-screen";
  final String receiptScreen = "/receipt-screen";
}
