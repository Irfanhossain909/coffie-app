import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/route/bindings/app_binding.dart';
import 'package:coffie/core/route/bindings/auth_binding.dart';
import 'package:coffie/feature/auth/presentation/ui/forget_password/forget_otp_verify_screen.dart';
import 'package:coffie/feature/auth/presentation/ui/forget_password/forget_password_screen.dart';
import 'package:coffie/feature/auth/presentation/ui/login_screen.dart';
import 'package:coffie/feature/auth/presentation/ui/forget_password/new_password_screen.dart';
import 'package:coffie/feature/auth/presentation/ui/register_screen.dart';
import 'package:coffie/feature/gift_card/presentation/ui/gift_card_screen.dart';
import 'package:coffie/feature/home/presentation/ui/home_screen.dart';
import 'package:coffie/feature/navigation/presentation/ui/navigation_screen.dart';
import 'package:coffie/feature/order/presentation/ui/order_screen.dart';
import 'package:coffie/feature/profile/presentation/ui/change_password_screen.dart';
import 'package:coffie/feature/profile/presentation/ui/profile_screen.dart';
import 'package:coffie/feature/profile/presentation/ui/setting_screen.dart';
import 'package:coffie/feature/reward/presentation/ui/reward_screen.dart';
import 'package:get/get.dart';

List<GetPage> appRootRoutesFile = <GetPage>[
  //   /////////////////  splash screen start
  // GetPage(
  //   name: AppRoutes.instance.initial,
  //   binding: SplashScreenBinding(),
  //   page: () => const SplashScreen(),
  //   transitionDuration: Duration(milliseconds: 800),
  //   opaque: false,
  // ),
  // --------------------- Navigation ---------------------
  GetPage(
    name: AppRoutes.instance.navigationScreen,
    page: () => const NavigationScreen(),
  ),
  // -- -----------  Auth ---------------------
  GetPage(
    name: AppRoutes.instance.loginScreen,
    binding: AuthBinding(),
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.registerScreen,
    binding: AuthBinding(),
    page: () => const RegisterScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.forgetPasswordScreen,
    binding: AuthBinding(),
    page: () => const ForgetPasswordScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.newPasswordScreen,
    binding: AuthBinding(),
    page: () => const NewPasswordScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.forgetOtpVerifyScreen,
    binding: AuthBinding(),
    page: () => const ForgetOtpVerifyScreen(),
  ),

  // --------------------- Home ---------------------
  GetPage(
    name: AppRoutes.instance.homeScreen,
    binding: AppBinding(),
    page: () => const HomeScreen(),
  ),

  // --------------------- Reward ---------------------
  GetPage(
    name: AppRoutes.instance.rewardScreen,
    binding: AppBinding(),
    page: () => const RewardScreen(),
  ),

  // --------------------- Order ---------------------
  GetPage(
    name: AppRoutes.instance.orderScreen,
    binding: AppBinding(),
    page: () => const OrderScreen(),
  ),

  // --------------------- Gift Card ---------------------
  GetPage(
    name: AppRoutes.instance.giftCardScreen,
    binding: AppBinding(),
    page: () => const GiftCardScreen(),
  ),

  // --------------------- Profile ---------------------
  GetPage(
    name: AppRoutes.instance.profileScreen,
    binding: AppBinding(),
    page: () => const ProfileScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.settingScreen,
    binding: AppBinding(),
    page: () => const SettingScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.changePasswordScreen,
    binding: AppBinding(),
    page: () => const ChangePasswordScreen(),
  ),
];
