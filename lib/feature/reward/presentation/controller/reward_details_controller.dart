import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/reward/domain/model/reward_card_details_model.dart';
import 'package:coffie/feature/reward/domain/repository/reward_repository.dart';
import 'package:get/get.dart';

class RewardDetailsController extends GetxController {
  /// repository here
  final RewardRepository rewardRepository = RewardRepository.instance;

  /// model here
  final Rxn<RewardCardDetailsModel> rewardCardDetailsModel =
      Rxn<RewardCardDetailsModel>();

  /// controller here
  final RxBool isLoading = false.obs;

  String? screenName;
  String? orderId;

  /// init state here
  @override
  void onInit() {
    super.onInit();
    screenName = Get.arguments["screen_name"];
    orderId = Get.arguments["order_id"];
    if (screenName == null || orderId == null) {
      Get.back();
      return;
    }
    getLoyeltyCardDetails();
  }

  Future<void> getLoyeltyCardDetails() async {
    try {
      isLoading.value = true;
      final result = await rewardRepository.getLoyeltyCardDetails(
        orderId: orderId ?? "",
      );
      if (result != null) {
        rewardCardDetailsModel.value = result;
        update();
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
