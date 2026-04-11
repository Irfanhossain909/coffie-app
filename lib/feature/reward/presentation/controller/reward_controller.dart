import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/reward/domain/model/reward_card_details_model.dart';
import 'package:coffie/feature/reward/domain/model/reward_card_model.dart';
import 'package:coffie/feature/reward/domain/model/reward_point_model.dart';
import 'package:coffie/feature/reward/domain/repository/reward_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

/// Reward history pagination matches wallet: [rewardListPageLimit] per request,
/// per-tab lists and cursors, separate [ScrollController] per tab.
class RewardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RewardRepository rewardRepository = RewardRepository.instance;

  final Rxn<RewardPointModel> rewardPointModel = Rxn<RewardPointModel>();
  final Rxn<RewardCardDetailsModel> rewardCardDetailsModel =
      Rxn<RewardCardDetailsModel>();

  late TabController tabController;
  var currentIndex = 0.obs;

  late final List<ScrollController> rewardScrollControllers;

  static const int rewardListPageLimit = 9;

  /// Per-tab history rows (0: All, 1: Earned, 2: Used).
  late final List<RxList<Datum>> rewardTabLists;

  late final List<int> rewardTabPage;
  late final List<RxBool> rewardTabHasMore;
  late final List<bool> rewardTabFetchStarted;
  late final List<RxBool> rewardTabFirstResponseDone;
  late final List<RxBool> rewardTabInitialLoading;
  late final List<RxBool> rewardTabLoadingMore;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    rewardTabLists = List<RxList<Datum>>.generate(
      3,
      (_) => <Datum>[].obs,
    );
    rewardTabPage = List<int>.filled(3, 1);
    rewardTabHasMore = List<RxBool>.generate(3, (_) => true.obs);
    rewardTabFetchStarted = List<bool>.filled(3, false);
    rewardTabFirstResponseDone = List<RxBool>.generate(3, (_) => false.obs);
    rewardTabInitialLoading = List<RxBool>.generate(3, (_) => false.obs);
    rewardTabLoadingMore = List<RxBool>.generate(3, (_) => false.obs);

    rewardScrollControllers = List<ScrollController>.generate(3, (int tabIndex) {
      final ScrollController c = ScrollController();
      c.addListener(() => _onRewardTabScroll(c, tabIndex));
      return c;
    });

    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      if (tabController.indexIsChanging) return;

      currentIndex.value = tabController.index;

      onTabChanged(tabController.index);
    });

    getRewardPoints();
    rewardTabFetchStarted[0] = true;
    loadRewardHistory(tabIndex: 0, reset: true);
  }

  void _onRewardTabScroll(ScrollController scrollController, int tabIndex) {
    if (currentIndex.value != tabIndex) return;
    if (!scrollController.hasClients) return;

    if (scrollController.position.maxScrollExtent <= 0) return;

    if (scrollController.position.userScrollDirection !=
        ScrollDirection.reverse) {
      return;
    }

    final isNearBottom = scrollController.position.extentAfter < 120;
    if (!isNearBottom) return;

    loadRewardHistory(tabIndex: tabIndex, loadMore: true);
  }

  @override
  void onClose() {
    for (final ScrollController c in rewardScrollControllers) {
      c.dispose();
    }
    tabController.dispose();
    super.onClose();
  }

  void onTabChanged(int index) {
    if (rewardTabFetchStarted[index]) return;
    rewardTabFetchStarted[index] = true;
    loadRewardHistory(tabIndex: index, reset: true);
  }

  String? _typeFromTabIndex(int index) {
    if (index == 1) return "earn";
    if (index == 2) return "spend";
    return null;
  }

  Future<void> reloadRewardHistoryTab({required int tabIndex}) async {
    await loadRewardHistory(tabIndex: tabIndex, reset: true);
  }

  Future<void> refreshActiveRewardHistoryTab() async {
    await loadRewardHistory(tabIndex: currentIndex.value, reset: true);
  }

  void _resetTabPaginationState(int tabIndex) {
    rewardTabPage[tabIndex] = 1;
    rewardTabHasMore[tabIndex].value = true;
    rewardTabLists[tabIndex].clear();
  }

  Future<void> loadRewardHistory({
    required int tabIndex,
    bool reset = false,
    bool loadMore = false,
  }) async {
    assert(tabIndex >= 0 && tabIndex < 3);
    final String? type = _typeFromTabIndex(tabIndex);
    bool apiIssued = false;
    try {
      if (reset) {
        _resetTabPaginationState(tabIndex);
      }

      if (!rewardTabHasMore[tabIndex].value) return;

      if (loadMore) {
        if (rewardTabLoadingMore[tabIndex].value ||
            rewardTabInitialLoading[tabIndex].value) {
          return;
        }
        rewardTabLoadingMore[tabIndex].value = true;
      } else {
        if (rewardTabInitialLoading[tabIndex].value) return;
        rewardTabInitialLoading[tabIndex].value = true;
      }

      apiIssued = true;
      final int page = rewardTabPage[tabIndex];
      final result = await rewardRepository.getRewardHistory(
        type: type,
        page: page,
        limit: rewardListPageLimit,
      );

      final List<Datum> items = result?.data ?? [];

      if (items.isEmpty) {
        rewardTabHasMore[tabIndex].value = false;
        return;
      }

      final RxList<Datum> list = rewardTabLists[tabIndex];

      if (page == 1) {
        list.assignAll(items);
      } else {
        final Set<String?> seen = list.map((Datum e) => e.id).toSet();
        for (final Datum item in items) {
          if (item.id != null && seen.contains(item.id)) continue;
          if (item.id != null) seen.add(item.id);
          list.add(item);
        }
      }

      if (items.length < rewardListPageLimit) {
        rewardTabHasMore[tabIndex].value = false;
      } else {
        rewardTabPage[tabIndex]++;
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      if (apiIssued) {
        rewardTabFirstResponseDone[tabIndex].value = true;
      }
      rewardTabInitialLoading[tabIndex].value = false;
      rewardTabLoadingMore[tabIndex].value = false;
    }
  }

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
}
