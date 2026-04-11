import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/gift_card/domain/model/gift_card_balance_model.dart';
import 'package:coffie/feature/gift_card/domain/model/gift_card_model.dart';
import 'package:coffie/feature/gift_card/domain/model/gift_card_redeem_model.dart';
import 'package:coffie/feature/gift_card/domain/repository/gift_card_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

/// Pagination matches wallet / order: [giftCardListPageLimit] per request, per-tab
/// lists and cursors, separate [ScrollController] per [TabBarView] tab.
class GiftCardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final GiftCardRepository giftCardRepository = GiftCardRepository.instance;

  late TabController tabController;
  var currentIndex = 0.obs;

  final Rxn<GiftCardBalanceModel> giftCardBalanceModel =
      Rxn<GiftCardBalanceModel>();

  late final List<ScrollController> giftScrollControllers;

  static const int giftCardListPageLimit = 9;

  /// Available (0) and Sent (1).
  late final List<RxList<GiftCardDataModel>> giftTransactionTabLists;

  /// Redeemed tab (2).
  late final RxList<GiftCardRedemDataModel> giftRedeemList;

  late final List<int> giftTabPage;
  late final List<RxBool> giftTabHasMore;
  late final List<bool> giftTabFetchStarted;
  late final List<RxBool> giftTabFirstResponseDone;
  late final List<RxBool> giftTabInitialLoading;
  late final List<RxBool> giftTabLoadingMore;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    giftTransactionTabLists = List<RxList<GiftCardDataModel>>.generate(
      2,
      (_) => <GiftCardDataModel>[].obs,
    );
    giftRedeemList = <GiftCardRedemDataModel>[].obs;

    giftTabPage = List<int>.filled(3, 1);
    giftTabHasMore = List<RxBool>.generate(3, (_) => true.obs);
    giftTabFetchStarted = List<bool>.filled(3, false);
    giftTabFirstResponseDone = List<RxBool>.generate(3, (_) => false.obs);
    giftTabInitialLoading = List<RxBool>.generate(3, (_) => false.obs);
    giftTabLoadingMore = List<RxBool>.generate(3, (_) => false.obs);

    giftScrollControllers = List<ScrollController>.generate(3, (int tabIndex) {
      final ScrollController c = ScrollController();
      c.addListener(() => _onGiftTabScroll(c, tabIndex));
      return c;
    });

    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      if (tabController.indexIsChanging) return;

      currentIndex.value = tabController.index;

      onTabChanged(tabController.index);
    });

    getGiftCardBalance();
    giftTabFetchStarted[0] = true;
    loadGiftTab(tabIndex: 0, reset: true);
  }

  void _onGiftTabScroll(ScrollController scrollController, int tabIndex) {
    if (currentIndex.value != tabIndex) return;
    if (!scrollController.hasClients) return;

    if (scrollController.position.maxScrollExtent <= 0) return;

    if (scrollController.position.userScrollDirection !=
        ScrollDirection.reverse) {
      return;
    }

    final isNearBottom = scrollController.position.extentAfter < 120;
    if (!isNearBottom) return;

    loadGiftTab(tabIndex: tabIndex, loadMore: true);
  }

  @override
  void onClose() {
    for (final ScrollController c in giftScrollControllers) {
      c.dispose();
    }
    tabController.dispose();
    super.onClose();
  }

  void onTabChanged(int index) {
    if (giftTabFetchStarted[index]) return;
    giftTabFetchStarted[index] = true;
    loadGiftTab(tabIndex: index, reset: true);
  }

  String _giftCardEndpointForTab(int transactionTabIndex) {
    assert(transactionTabIndex == 0 || transactionTabIndex == 1);
    return transactionTabIndex == 0 ? "available" : "sent";
  }

  Future<void> reloadGiftCardTab({required int tabIndex}) async {
    await loadGiftTab(tabIndex: tabIndex, reset: true);
  }

  Future<void> refreshActiveGiftCardTab() async {
    await loadGiftTab(tabIndex: currentIndex.value, reset: true);
  }

  void _resetTransactionTab(int transactionTabIndex) {
    assert(transactionTabIndex == 0 || transactionTabIndex == 1);
    giftTabPage[transactionTabIndex] = 1;
    giftTabHasMore[transactionTabIndex].value = true;
    giftTransactionTabLists[transactionTabIndex].clear();
  }

  void _resetRedeemTab() {
    giftTabPage[2] = 1;
    giftTabHasMore[2].value = true;
    giftRedeemList.clear();
  }

  Future<void> loadGiftTab({
    required int tabIndex,
    bool reset = false,
    bool loadMore = false,
  }) async {
    assert(tabIndex >= 0 && tabIndex < 3);
    if (tabIndex == 2) {
      await _loadRedeemList(reset: reset, loadMore: loadMore);
    } else {
      await _loadGiftCardTransactions(
        transactionTabIndex: tabIndex,
        reset: reset,
        loadMore: loadMore,
      );
    }
  }

  Future<void> _loadGiftCardTransactions({
    required int transactionTabIndex,
    bool reset = false,
    bool loadMore = false,
  }) async {
    assert(transactionTabIndex == 0 || transactionTabIndex == 1);
    final String endpoint = _giftCardEndpointForTab(transactionTabIndex);
    bool apiIssued = false;
    try {
      if (reset) {
        _resetTransactionTab(transactionTabIndex);
      }

      if (!giftTabHasMore[transactionTabIndex].value) return;

      if (loadMore) {
        if (giftTabLoadingMore[transactionTabIndex].value ||
            giftTabInitialLoading[transactionTabIndex].value) {
          return;
        }
        giftTabLoadingMore[transactionTabIndex].value = true;
      } else {
        if (giftTabInitialLoading[transactionTabIndex].value) return;
        giftTabInitialLoading[transactionTabIndex].value = true;
      }

      apiIssued = true;
      final int page = giftTabPage[transactionTabIndex];
      final result = await giftCardRepository.getGiftCardTransactions(
        giftCardEndPoint: endpoint,
        page: page,
        limit: giftCardListPageLimit,
      );

      if (result.isEmpty) {
        giftTabHasMore[transactionTabIndex].value = false;
        return;
      }

      final RxList<GiftCardDataModel> list =
          giftTransactionTabLists[transactionTabIndex];

      if (page == 1) {
        list.assignAll(result);
      } else {
        final Set<String?> seen =
            list.map((GiftCardDataModel e) => e.id).toSet();
        for (final GiftCardDataModel item in result) {
          if (item.id != null && seen.contains(item.id)) continue;
          if (item.id != null) seen.add(item.id);
          list.add(item);
        }
      }

      if (result.length < giftCardListPageLimit) {
        giftTabHasMore[transactionTabIndex].value = false;
      } else {
        giftTabPage[transactionTabIndex]++;
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      if (apiIssued) {
        giftTabFirstResponseDone[transactionTabIndex].value = true;
      }
      giftTabInitialLoading[transactionTabIndex].value = false;
      giftTabLoadingMore[transactionTabIndex].value = false;
    }
  }

  Future<void> _loadRedeemList({
    bool reset = false,
    bool loadMore = false,
  }) async {
    const int tabIndex = 2;
    bool apiIssued = false;
    try {
      if (reset) {
        _resetRedeemTab();
      }

      if (!giftTabHasMore[tabIndex].value) return;

      if (loadMore) {
        if (giftTabLoadingMore[tabIndex].value ||
            giftTabInitialLoading[tabIndex].value) {
          return;
        }
        giftTabLoadingMore[tabIndex].value = true;
      } else {
        if (giftTabInitialLoading[tabIndex].value) return;
        giftTabInitialLoading[tabIndex].value = true;
      }

      apiIssued = true;
      final int page = giftTabPage[tabIndex];
      final result = await giftCardRepository.getGiftCardRedeem(
        page: page,
        limit: giftCardListPageLimit,
      );

      if (result.isEmpty) {
        giftTabHasMore[tabIndex].value = false;
        return;
      }

      final RxList<GiftCardRedemDataModel> list = giftRedeemList;

      if (page == 1) {
        list.assignAll(result);
      } else {
        final Set<String?> seen =
            list.map((GiftCardRedemDataModel e) => e.id).toSet();
        for (final GiftCardRedemDataModel item in result) {
          if (item.id != null && seen.contains(item.id)) continue;
          if (item.id != null) seen.add(item.id);
          list.add(item);
        }
      }

      if (result.length < giftCardListPageLimit) {
        giftTabHasMore[tabIndex].value = false;
      } else {
        giftTabPage[tabIndex]++;
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      if (apiIssued) {
        giftTabFirstResponseDone[tabIndex].value = true;
      }
      giftTabInitialLoading[tabIndex].value = false;
      giftTabLoadingMore[tabIndex].value = false;
    }
  }

  void reload() {
    getGiftCardBalance();
  }

  Future<void> getGiftCardBalance() async {
    try {
      isLoading.value = true;
      final result = await giftCardRepository.getGiftCardBalance();
      if (result != null) {
        giftCardBalanceModel.value = result;
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
