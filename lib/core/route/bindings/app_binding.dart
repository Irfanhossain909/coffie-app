import 'package:coffie/feature/auth/presentation/controller/personal_info/personal_info_controller.dart';
import 'package:coffie/feature/geust/presentation/controller/geust_profile_controller.dart';
import 'package:coffie/feature/gift_card/presentation/controller/add_exising_card_controller.dart';
import 'package:coffie/feature/gift_card/presentation/controller/gift_card_controller.dart';
import 'package:coffie/feature/gift_card/presentation/controller/perchese_gift_card_controller.dart';
import 'package:coffie/feature/home/presentation/controller/home_controller.dart';
import 'package:coffie/feature/new_order/presentation/controller/pickup_location_controller.dart';
import 'package:coffie/feature/new_order/presentation/controller/product_info_controller.dart';
import 'package:coffie/feature/new_order/presentation/controller/shop_order_information_controller.dart';
import 'package:coffie/feature/notification/presentation/controller/notification_controller.dart';
import 'package:coffie/feature/order/presentation/controller/order_controller.dart';
import 'package:coffie/feature/profile/presentation/controller/change_password_controller.dart';
import 'package:coffie/feature/profile/presentation/controller/contact_up_controller.dart';
import 'package:coffie/feature/profile/presentation/controller/delete_account_controller.dart';
import 'package:coffie/feature/profile/presentation/controller/edit_profile_info_controller.dart';
import 'package:coffie/feature/favorite/presentation/controller/favorate_controller.dart';
import 'package:coffie/feature/profile/presentation/controller/privicy_controller.dart';
import 'package:coffie/feature/profile/presentation/controller/profile_controller.dart';
import 'package:coffie/feature/profile/presentation/controller/transection_controller.dart';
import 'package:coffie/feature/reward/presentation/controller/reward_controller.dart';
import 'package:coffie/feature/wallet/presentation/controller/my_wallet_controller.dart';
import 'package:coffie/feature/wallet/presentation/controller/wallet_add_controller.dart';
import 'package:coffie/feature/wallet/presentation/controller/wallet_history_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => RewardController());
    Get.lazyPut(() => OrderController());
    Get.lazyPut(() => GiftCardController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => ChangePasswordController());
    Get.lazyPut(() => ContactUsController());
    Get.lazyPut(() => PrivicyPolicyController());
    Get.lazyPut(() => DeleteAccountController());
    Get.lazyPut(() => FavorateController());
    Get.lazyPut(() => TransectionController());
    Get.lazyPut(() => EditProfileInfoController());
    Get.lazyPut(() => MyWalletController());
    Get.lazyPut(() => PersonalInfoController());
    Get.lazyPut(() => PickupLocationWithGetShopController());
    Get.lazyPut(() => ShopOrderInformationController());
    Get.lazyPut(() => PercheseGiftCardController());
    Get.lazyPut(() => AddExisingCardController());
    Get.lazyPut(() => WalletHistoryController());
    Get.lazyPut(() => WalletAddController());
    Get.lazyPut(() => ProductInfoController());
    Get.lazyPut(() => NotificationController());

    // --------------------- Guest ---------------------
    Get.lazyPut(() => GeustProfileController());
  }
}
