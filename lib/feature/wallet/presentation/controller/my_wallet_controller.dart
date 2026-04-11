import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/wallet/domain/model/wallet_balance_model.dart';
import 'package:coffie/feature/wallet/domain/model/wallet_card_list_model.dart';
import 'package:coffie/feature/wallet/domain/repository/wallet_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

/// Shared pagination rules for wallet history (all tabs use the same [limit] /
/// page increment / scroll-to-load behavior). Each tab keeps its own list, page
/// cursor, and has-more flag so switching tabs does not mix data.
class MyWalletController extends GetxController
    with GetSingleTickerProviderStateMixin {
  /// repository here
  final WalletRepository walletRepository = WalletRepository.instance;

  /// One controller per wallet-history tab — sharing one [ScrollController] across
  /// multiple [ListView]s in [TabBarView] causes duplicate scroll events and
  /// repeated pagination with the same page.
  late final List<ScrollController> walletScrollControllers;

  /// wallet balance model here
  Rxn<WalletBalanceModel> walletBalanceModel = Rxn<WalletBalanceModel>();

  static const int walletListPageLimit = 9;

  /// Per-tab wallet transaction lists (0: All, 1: deposit, 2: spend).
  late final List<RxList<WalletCardListDataModel>> walletTabLists;

  /// Per-tab next page to request (starts at 1 for every tab).
  late final List<int> walletTabPage;

  /// Per-tab: more pages available from API.
  late final List<RxBool> walletTabHasMore;

  /// First request started for this tab (avoids duplicate initial fetch on tab change).
  late final List<bool> walletTabFetchStarted;

  /// Becomes true after the first API attempt for this tab completes (success, empty, or error).
  late final List<RxBool> walletTabFirstResponseDone;

  /// Initial/full-page load in flight for this tab.
  late final List<RxBool> walletTabInitialLoading;

  /// Load-more in flight for this tab.
  late final List<RxBool> walletTabLoadingMore;

  // Tab Controller
  late TabController tabController;
  var currentIndex = 0.obs;

  /// isLoading here
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    walletTabLists = List<RxList<WalletCardListDataModel>>.generate(
      3,
      (_) => <WalletCardListDataModel>[].obs,
    );
    walletTabPage = List<int>.filled(3, 1);
    walletTabHasMore = List<RxBool>.generate(3, (_) => true.obs);
    walletTabFetchStarted = List<bool>.filled(3, false);
    walletTabFirstResponseDone = List<RxBool>.generate(3, (_) => false.obs);
    walletTabInitialLoading =
        List<RxBool>.generate(3, (_) => false.obs);
    walletTabLoadingMore = List<RxBool>.generate(3, (_) => false.obs);

    walletScrollControllers = List<ScrollController>.generate(3, (int tabIndex) {
      final ScrollController c = ScrollController();
      c.addListener(() => _onWalletTabScroll(c, tabIndex));
      return c;
    });
    getWalletBalance();
    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      if (tabController.indexIsChanging) return;

      currentIndex.value = tabController.index;

      onTabChanged(tabController.index);
    });
    walletTabFetchStarted[0] = true;
    getWalletCardList(tabIndex: 0, reset: true);
  }

  void _onWalletTabScroll(ScrollController scrollController, int tabIndex) {
    if (currentIndex.value != tabIndex) return;
    if (!scrollController.hasClients) return;

    if (scrollController.position.maxScrollExtent <= 0) return;

    if (scrollController.position.userScrollDirection !=
        ScrollDirection.reverse) {
      return;
    }

    final isNearBottom = scrollController.position.extentAfter < 120;
    if (!isNearBottom) return;

    getWalletCardList(tabIndex: tabIndex, loadMore: true);
  }

  @override
  void onClose() {
    for (final ScrollController c in walletScrollControllers) {
      c.dispose();
    }
    tabController.dispose();
    super.onClose();
  }

  void onTabChanged(int index) {
    if (walletTabFetchStarted[index]) return;
    walletTabFetchStarted[index] = true;
    getWalletCardList(tabIndex: index, reset: true);
  }

  String? _typeFromTabIndex(int index) {
    if (index == 1) return "deposit";
    if (index == 2) return "spend";
    return null;
  }

  /// Pull-to-refresh: reloads that tab from page 1 with the same pagination rules.
  Future<void> reloadWalletCardList({required int tabIndex}) async {
    await getWalletCardList(tabIndex: tabIndex, reset: true);
  }

  /// After add-money or when any code needs the active tab refreshed.
  Future<void> refreshActiveTabWalletList() async {
    await getWalletCardList(tabIndex: currentIndex.value, reset: true);
  }

  /// get wallet balance function here
  Future<void> getWalletBalance() async {
    try {
      isLoading.value = true;
      final result = await walletRepository.getWalletBalance();
      if (result != null) {
        walletBalanceModel.value = result;
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _resetTabPaginationState(int tabIndex) {
    walletTabPage[tabIndex] = 1;
    walletTabHasMore[tabIndex].value = true;
    walletTabLists[tabIndex].clear();
  }

  /// Same pagination for every tab: [walletListPageLimit] items per page,
  /// advance page when a full page returns, stop when fewer than limit or empty.
  Future<void> getWalletCardList({
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

      if (!walletTabHasMore[tabIndex].value) return;

      if (loadMore) {
        if (walletTabLoadingMore[tabIndex].value ||
            walletTabInitialLoading[tabIndex].value) {
          return;
        }
        walletTabLoadingMore[tabIndex].value = true;
      } else {
        if (walletTabInitialLoading[tabIndex].value) return;
        walletTabInitialLoading[tabIndex].value = true;
      }

      apiIssued = true;
      final int page = walletTabPage[tabIndex];
      final result = await walletRepository.getWalletCardList(
        type: type,
        page: page,
        limit: walletListPageLimit,
      );

      if (result.isEmpty) {
        walletTabHasMore[tabIndex].value = false;
        return;
      }

      final RxList<WalletCardListDataModel> list = walletTabLists[tabIndex];

      if (page == 1) {
        list.assignAll(result);
      } else {
        final Set<String?> seen =
            list.map((WalletCardListDataModel e) => e.id).toSet();
        for (final WalletCardListDataModel item in result) {
          if (item.id != null && seen.contains(item.id)) continue;
          if (item.id != null) seen.add(item.id);
          list.add(item);
        }
      }

      if (result.length < walletListPageLimit) {
        walletTabHasMore[tabIndex].value = false;
      } else {
        walletTabPage[tabIndex]++;
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      if (apiIssued) {
        walletTabFirstResponseDone[tabIndex].value = true;
      }
      walletTabInitialLoading[tabIndex].value = false;
      walletTabLoadingMore[tabIndex].value = false;
    }
  }
}
