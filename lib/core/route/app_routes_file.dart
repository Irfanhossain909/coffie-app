import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/route/bindings/app_binding.dart';
import 'package:coffie/core/route/bindings/auth_binding.dart';
import 'package:coffie/feature/auth/presentation/ui/email_otp_verify_screen.dart';
import 'package:coffie/feature/auth/presentation/ui/forget_password/forget_password_screen.dart';
import 'package:coffie/feature/auth/presentation/ui/login_screen.dart';
import 'package:coffie/feature/auth/presentation/ui/forget_password/new_password_screen.dart';
import 'package:coffie/feature/auth/presentation/ui/personal_info/personal_info_screen.dart';
import 'package:coffie/feature/auth/presentation/ui/personal_info/phone_otp_verify_screen.dart';
import 'package:coffie/feature/auth/presentation/ui/register_screen.dart';
import 'package:coffie/feature/geust/presentation/ui/geuse_screen.dart';
import 'package:coffie/feature/geust/presentation/ui/geust_profile_screen.dart';
import 'package:coffie/feature/gift_card/presentation/ui/add_existing_gift_card_screen.dart';
import 'package:coffie/feature/gift_card/presentation/ui/gift_card_screen.dart';
import 'package:coffie/feature/gift_card/presentation/ui/perchese_gift_card_screen.dart';
import 'package:coffie/feature/home/presentation/ui/home_screen.dart';
import 'package:coffie/feature/navigation/presentation/ui/navigation_screen.dart';
import 'package:coffie/feature/new_order/presentation/ui/my_cart_screen.dart';
import 'package:coffie/feature/new_order/presentation/ui/pickup_location_screen.dart';
import 'package:coffie/feature/new_order/presentation/ui/product_info_screen.dart';
import 'package:coffie/feature/new_order/presentation/ui/shop_details_screnn.dart';
import 'package:coffie/feature/new_order/presentation/ui/shop_order_information_screen.dart';
import 'package:coffie/feature/notification/presentation/ui/notification_screen.dart';
import 'package:coffie/feature/onboarding/on_boarding_screen.dart';
import 'package:coffie/feature/order/presentation/ui/order_screen.dart';
import 'package:coffie/feature/profile/presentation/ui/change_password_screen.dart';
import 'package:coffie/feature/profile/presentation/ui/contact_us_screen.dart';
import 'package:coffie/feature/profile/presentation/ui/delete_account_screen.dart';
import 'package:coffie/feature/profile/presentation/ui/edit_profile_info_screen.dart';
import 'package:coffie/feature/profile/presentation/ui/email_subscrption_screen.dart';
import 'package:coffie/feature/profile/presentation/ui/favorate_screen.dart';
import 'package:coffie/feature/wallet/presentation/ui/my_wallet_screen.dart';
import 'package:coffie/feature/profile/presentation/ui/my_wallet/receipt_screen.dart';
import 'package:coffie/feature/wallet/presentation/ui/wallet_add_screen.dart';
import 'package:coffie/feature/wallet/presentation/ui/wallet_history_screen.dart';
import 'package:coffie/feature/profile/presentation/ui/privicy_policy_screen.dart';
import 'package:coffie/feature/profile/presentation/ui/profile_screen.dart';
import 'package:coffie/feature/profile/presentation/ui/setting_screen.dart';
import 'package:coffie/feature/profile/presentation/ui/transection_history_screen.dart';
import 'package:coffie/feature/reward/presentation/ui/reward_details_screen.dart';
import 'package:coffie/feature/reward/presentation/ui/reward_screen.dart';
import 'package:get/get.dart';

List<GetPage> appRootRoutesFile = <GetPage>[
  // --------------------- Navigation ---------------------
  GetPage(
    name: AppRoutes.instance.navigationScreen,
    page: () => const NavigationScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.onBoardingScreen,
    page: () => const OnBoardingScreen(),
  ),
  // --------------------- Notification ---------------------
  GetPage(
    name: AppRoutes.instance.notificationScreen,
    binding: AppBinding(),
    page: () => const NotificationScreen(),
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
    name: AppRoutes.instance.emailOtpVerifyScreen,
    binding: AuthBinding(),
    page: () => const EmailOtpVerifyScreen(),
  ),
  // --------------------- Personal Info ---------------------
  GetPage(
    name: AppRoutes.instance.personalInfoScreen,
    binding: AppBinding(),
    page: () => const PersonalInfoScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.phoneOtpVerifyScreen,
    binding: AuthBinding(),
    page: () => const PhoneOtpVerifyScreen(),
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
  GetPage(
    name: AppRoutes.instance.rewardDetailsScreen,
    binding: AppBinding(),
    page: () => const RewardDetailsScreen(),
  ),

  // --------------------- Order ---------------------
  GetPage(
    name: AppRoutes.instance.orderScreen,
    binding: AppBinding(),
    page: () => const OrderScreen(),
  ),
  // --------------------- New Order ---------------------
  GetPage(
    name: AppRoutes.instance.pickupLocationScreen,
    binding: AppBinding(),
    page: () => const PickupLocationScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.shopDetailsScreen,
    binding: AppBinding(),
    page: () => const ShopDetailsScrenn(),
  ),
  GetPage(
    name: AppRoutes.instance.shopOrderInformationScreen,
    binding: AppBinding(),
    page: () => const ShopOrderInformationScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.productInfoScreen,
    binding: AppBinding(),
    page: () => const ProductInfoScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.myCartScreen,
    binding: AppBinding(),
    page: () => const MyCartScreen(),
  ),
  // --------------------- Gift Card ---------------------
  GetPage(
    name: AppRoutes.instance.giftCardScreen,
    binding: AppBinding(),
    page: () => const GiftCardScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.addExistingGiftCardScreen,
    binding: AppBinding(),
    page: () => const AddExistingGiftCard(),
  ),
  GetPage(
    name: AppRoutes.instance.percheseGiftCardScreen,
    binding: AppBinding(),
    page: () => const PercheseGiftCardScreen(),
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
  GetPage(
    name: AppRoutes.instance.contactUsScreen,
    binding: AppBinding(),
    page: () => const ContactUsScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.privicyPolicyScreen,
    binding: AppBinding(),
    page: () => const PrivicyPolicyScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.deleteAccountScreen,
    binding: AppBinding(),
    page: () => const DeleteAccountScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.favorateScreen,
    binding: AppBinding(),
    page: () => FavorateScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.transectionHistoryScreen,
    binding: AppBinding(),
    page: () => const TransectionHistoryScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.emailSubscrptionScreen,
    binding: AppBinding(),
    page: () => const EmailSubscrptionScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.editProfileInfoScreen,
    binding: AppBinding(),
    page: () => const EditProfileInfoScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.myWalletScreen,
    binding: AppBinding(),
    page: () => const MyWalletScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.walletHistoryScreen,
    binding: AppBinding(),
    page: () => const WalletHistoryScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.receiptScreen,
    binding: AppBinding(),
    page: () => const ReceiptScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.walletAddScreen,
    binding: AppBinding(),
    page: () => const WalletAddScreen(),
  ),

  // --------------------- Guest ---------------------
  GetPage(
    name: AppRoutes.instance.guestScreen,
    binding: AppBinding(),
    page: () => const GeuseScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.geustProfileScreen,
    binding: AppBinding(),
    page: () => GuestProfileScreen(),
  ),

  
];
