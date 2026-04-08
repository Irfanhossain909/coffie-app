import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/wallet/domain/model/wallet_balance_model.dart';
import 'package:coffie/feature/wallet/domain/model/wallet_card_list_model.dart';
import 'package:coffie/feature/wallet/domain/repository/wallet_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class MyWalletController extends GetxController
    with GetSingleTickerProviderStateMixin {
  /// repository here
  final WalletRepository walletRepository = WalletRepository.instance;

  //Scroll Controller
  late ScrollController scrollController;

  /// wallet balance model here
  Rxn<WalletBalanceModel> walletBalanceModel = Rxn<WalletBalanceModel>();
  RxList<WalletCardListDataModel> walletCardList =
      <WalletCardListDataModel>[].obs;

  int page = 1;
  int limit = 9;

  /// pagination state
  final RxBool hasMoreWalletCardList = true.obs;
  final RxBool isLoadingMoreWalletCardList = false.obs;

  // Tab Controller
  late TabController tabController;
  var currentIndex = 0.obs;

  /// isLoading here
  RxBool isLoading = false.obs;
  final RxBool isLoadingWalletCardList = false.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    getWalletBalance();
    scrollController.addListener(() {
      if (!scrollController.hasClients) return;

      // Prevent auto-trigger when list isn't scrollable yet
      if (scrollController.position.maxScrollExtent <= 0) return;

      // Only trigger while user is scrolling downwards
      if (scrollController.position.userScrollDirection !=
          ScrollDirection.reverse) {
        return;
      }

      final isNearBottom = scrollController.position.extentAfter < 120;
      if (!isNearBottom) return;

      final String? type = _typeFromTabIndex(currentIndex.value);
      getWalletCardList(type: type, loadMore: true);
    });
    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      if (tabController.indexIsChanging) return;

      currentIndex.value = tabController.index;

      // 👇 Tab change hole function call
      onTabChanged(tabController.index);
    });
    getWalletCardList(reset: true);
  }

  @override
  void onClose() {
    scrollController.dispose();
    tabController.dispose();
    super.onClose();
  }

  void onTabChanged(int index) {
    if (index == 0) {
      getWalletCardList(type: null, reset: true);
    } else if (index == 1) {
      getWalletCardList(type: "deposit", reset: true);
    } else if (index == 2) {
      getWalletCardList(type: "spend", reset: true);
    }
  }

  String? _typeFromTabIndex(int index) {
    if (index == 1) return "deposit";
    if (index == 2) return "spend";
    return null;
  }

  Future<void> reloadWalletCardList({String? type}) async {
    page = 1;
    limit = 9;
    hasMoreWalletCardList.value = true;
    await getWalletCardList(type: type, reset: true);
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

  /// get wallet card list function here
  Future<void> getWalletCardList({
    String? type,
    bool reset = false,
    bool loadMore = false,
  }) async {
    try {
      if (reset) {
        page = 1;
        limit = 9;
        hasMoreWalletCardList.value = true;
        walletCardList.clear();
      }

      if (!hasMoreWalletCardList.value) return;

      if (loadMore) {
        if (isLoadingMoreWalletCardList.value ||
            isLoadingWalletCardList.value) {
          return;
        }
        isLoadingMoreWalletCardList.value = true;
      } else {
        if (isLoadingWalletCardList.value) return;
        isLoadingWalletCardList.value = true;
      }

      final result = await walletRepository.getWalletCardList(
        type: type,
        page: page,
        limit: limit,
      );

      if (result.isEmpty) {
        hasMoreWalletCardList.value = false;
        return;
      }

      if (page == 1) {
        walletCardList.assignAll(result);
      } else {
        walletCardList.addAll(result);
      }

      // If API returns less than limit, assume no more pages
      if (result.length < limit) {
        hasMoreWalletCardList.value = false;
      } else {
        page++;
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoadingWalletCardList.value = false;
      isLoadingMoreWalletCardList.value = false;
    }
  }
}
