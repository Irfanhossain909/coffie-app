import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/order/domain/model/order_card_model.dart';
import 'package:coffie/feature/order/domain/repository/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

/// Pagination matches wallet history: shared [orderListPageLimit], per-tab list /
/// page / has-more, separate [ScrollController] per tab (shared controller bug).
class OrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final OrderRepository orderRepository = OrderRepository.instance;

  /// One scroll controller per order tab — avoids duplicate pagination when
  /// [TabBarView] rebuilds share one controller.
  late final List<ScrollController> orderScrollControllers;

  static const int orderListPageLimit = 9;

  /// Per-tab order lists (0: Upcoming, 1: Completed).
  late final List<RxList<OrderCardDataModel>> orderTabLists;

  late final List<int> orderTabPage;

  late final List<RxBool> orderTabHasMore;

  late final List<bool> orderTabFetchStarted;

  late final List<RxBool> orderTabFirstResponseDone;

  late final List<RxBool> orderTabInitialLoading;

  late final List<RxBool> orderTabLoadingMore;

  late TabController tabController;
  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    orderTabLists = List<RxList<OrderCardDataModel>>.generate(
      2,
      (_) => <OrderCardDataModel>[].obs,
    );
    orderTabPage = List<int>.filled(2, 1);
    orderTabHasMore = List<RxBool>.generate(2, (_) => true.obs);
    orderTabFetchStarted = List<bool>.filled(2, false);
    orderTabFirstResponseDone = List<RxBool>.generate(2, (_) => false.obs);
    orderTabInitialLoading = List<RxBool>.generate(2, (_) => false.obs);
    orderTabLoadingMore = List<RxBool>.generate(2, (_) => false.obs);

    orderScrollControllers = List<ScrollController>.generate(2, (int tabIndex) {
      final ScrollController c = ScrollController();
      c.addListener(() => _onOrderTabScroll(c, tabIndex));
      return c;
    });

    tabController = TabController(length: 2, vsync: this);

    tabController.addListener(() {
      if (tabController.indexIsChanging) return;

      currentIndex.value = tabController.index;

      onTabChanged(tabController.index);
    });

    orderTabFetchStarted[0] = true;
    getOrderList(tabIndex: 0, reset: true);
  }

  void _onOrderTabScroll(ScrollController scrollController, int tabIndex) {
    if (currentIndex.value != tabIndex) return;
    if (!scrollController.hasClients) return;

    if (scrollController.position.maxScrollExtent <= 0) return;

    if (scrollController.position.userScrollDirection !=
        ScrollDirection.reverse) {
      return;
    }

    final isNearBottom = scrollController.position.extentAfter < 120;
    if (!isNearBottom) return;

    getOrderList(tabIndex: tabIndex, loadMore: true);
  }

  @override
  void onClose() {
    for (final ScrollController c in orderScrollControllers) {
      c.dispose();
    }
    tabController.dispose();
    super.onClose();
  }

  void onTabChanged(int index) {
    if (orderTabFetchStarted[index]) return;
    orderTabFetchStarted[index] = true;
    getOrderList(tabIndex: index, reset: true);
  }

  String _orderTypeFromTabIndex(int index) {
    if (index == 1) return "completed";
    return "upcoming";
  }

  Future<void> reloadOrderList({required int tabIndex}) async {
    await getOrderList(tabIndex: tabIndex, reset: true);
  }

  void _resetTabPaginationState(int tabIndex) {
    orderTabPage[tabIndex] = 1;
    orderTabHasMore[tabIndex].value = true;
    orderTabLists[tabIndex].clear();
  }

  Future<void> getOrderList({
    required int tabIndex,
    bool reset = false,
    bool loadMore = false,
  }) async {
    assert(tabIndex >= 0 && tabIndex < 2);
    final String orderType = _orderTypeFromTabIndex(tabIndex);
    bool apiIssued = false;
    try {
      if (reset) {
        _resetTabPaginationState(tabIndex);
      }

      if (!orderTabHasMore[tabIndex].value) return;

      if (loadMore) {
        if (orderTabLoadingMore[tabIndex].value ||
            orderTabInitialLoading[tabIndex].value) {
          return;
        }
        orderTabLoadingMore[tabIndex].value = true;
      } else {
        if (orderTabInitialLoading[tabIndex].value) return;
        orderTabInitialLoading[tabIndex].value = true;
      }

      apiIssued = true;
      final int page = orderTabPage[tabIndex];
      final result = await orderRepository.getOrderList(
        orderType: orderType,
        page: page,
        limit: orderListPageLimit,
      );

      if (result.isEmpty) {
        orderTabHasMore[tabIndex].value = false;
        return;
      }

      final RxList<OrderCardDataModel> list = orderTabLists[tabIndex];

      if (page == 1) {
        list.assignAll(result);
      } else {
        final Set<String?> seen =
            list.map((OrderCardDataModel e) => e.id).toSet();
        for (final OrderCardDataModel item in result) {
          if (item.id != null && seen.contains(item.id)) continue;
          if (item.id != null) seen.add(item.id);
          list.add(item);
        }
      }

      if (result.length < orderListPageLimit) {
        orderTabHasMore[tabIndex].value = false;
      } else {
        orderTabPage[tabIndex]++;
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      if (apiIssued) {
        orderTabFirstResponseDone[tabIndex].value = true;
      }
      orderTabInitialLoading[tabIndex].value = false;
      orderTabLoadingMore[tabIndex].value = false;
    }
  }
}
