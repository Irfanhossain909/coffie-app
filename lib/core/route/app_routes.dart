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

  
}
