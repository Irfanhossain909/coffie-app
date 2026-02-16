import 'package:coffie/feature/gift_card/presentation/controller/gift_card_controller.dart';
import 'package:coffie/feature/home/presentation/controller/home_controller.dart';
import 'package:coffie/feature/order/presentation/controller/order_controller.dart';
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
  }
}
