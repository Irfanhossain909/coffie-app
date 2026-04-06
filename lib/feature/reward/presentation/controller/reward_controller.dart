import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/reward/domain/model/reward_card_details_model.dart';
import 'package:coffie/feature/reward/domain/model/reward_card_model.dart';
import 'package:coffie/feature/reward/domain/model/reward_point_model.dart';
import 'package:coffie/feature/reward/domain/repository/reward_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RewardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // repository here
  final RewardRepository rewardRepository = RewardRepository.instance;

  // model here
  final Rxn<RewardPointModel> rewardPointModel = Rxn<RewardPointModel>();
  final Rxn<RewardCardModel> rewardHistoryModel = Rxn<RewardCardModel>();
  final Rxn<RewardCardDetailsModel> rewardCardDetailsModel =
      Rxn<RewardCardDetailsModel>();

  // controller here
  late TabController tabController;
  var currentIndex = 0.obs;

  // isLoading here
  final RxBool isLoading = false.obs;
  final RxBool isLoadingHistory = false.obs;

  /// init state here
  @override
  void onInit() {
    super.onInit();
    getRewardPoints();
    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      if (tabController.indexIsChanging) return;

      currentIndex.value = tabController.index;

      // 👇 Tab change hole function call
      onTabChanged(tabController.index);
    });
    getRewardHistory();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void onTabChanged(int index) {
    if (index == 0) {
      getRewardHistory();
    } else if (index == 1) {
      getRewardHistory();
    } else if (index == 2) {
      getRewardHistory();
    }
  }

  // get reward points function here
  Future<void> getRewardPoints() async {
    try {
      isLoading.value = true;
      final result = await rewardRepository.getRewardPoints();
      if (result != null) {
        rewardPointModel.value = result;
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getRewardHistory() async {
    try {
      isLoadingHistory.value = true;

      final startTime = DateTime.now();

      final result = await rewardRepository.getRewardHistory(
        type: currentIndex.value == 0
            ? null
            : currentIndex.value == 1
            ? "earn"
            : "spend",
        page: 1,
        limit: 10,
      );

      final elapsed = DateTime.now().difference(startTime);

      // Minimum shimmer show time (smooth UX)
      if (elapsed.inMilliseconds < 600) {
        await Future.delayed(
          Duration(milliseconds: 600 - elapsed.inMilliseconds),
        );
      }

      if (result != null) {
        rewardHistoryModel.value = result;
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoadingHistory.value = false;
    }
  }

  
}
