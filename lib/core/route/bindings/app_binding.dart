import 'package:coffie/feature/gift_card/presentation/controller/gift_card_controller.dart';
import 'package:coffie/feature/home/presentation/controller/home_controller.dart';
import 'package:coffie/feature/order/presentation/controller/order_controller.dart';
import 'package:coffie/feature/profile/presentation/controller/change_password_controller.dart';
import 'package:coffie/feature/profile/presentation/controller/contact_up_controller.dart';
import 'package:coffie/feature/profile/presentation/controller/delete_account_controller.dart';
import 'package:coffie/feature/profile/presentation/controller/favorate_controller.dart';
import 'package:coffie/feature/profile/presentation/controller/privicy_controller.dart';
import 'package:coffie/feature/profile/presentation/controller/profile_controller.dart';
import 'package:coffie/feature/reward/presentation/controller/reward_controller.dart';
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
  }
}
