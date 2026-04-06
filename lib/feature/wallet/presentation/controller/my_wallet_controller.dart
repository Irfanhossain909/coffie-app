import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/wallet/domain/model/wallet_balance_model.dart';
import 'package:coffie/feature/wallet/domain/model/wallet_card_list_model.dart';
import 'package:coffie/feature/wallet/domain/repository/wallet_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWalletController extends GetxController
    with GetSingleTickerProviderStateMixin {
  /// repository here
  final WalletRepository walletRepository = WalletRepository.instance;

  /// wallet balance model here
  Rxn<WalletBalanceModel> walletBalanceModel = Rxn<WalletBalanceModel>();
  RxList<WalletCardListDataModel> walletCardList =
      <WalletCardListDataModel>[].obs;

  // Tab Controller
  late TabController tabController;
  var currentIndex = 0.obs;

  /// isLoading here
  RxBool isLoading = false.obs;
  final RxBool isLoadingWalletCardList = false.obs;

  @override
  void onInit() {
    super.onInit();
    getWalletBalance();
    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      if (tabController.indexIsChanging) return;

      currentIndex.value = tabController.index;

      // 👇 Tab change hole function call
      onTabChanged(tabController.index);
    });
    getWalletCardList();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void onTabChanged(int index) {
    if (index == 0) {
      getWalletCardList();
    } else if (index == 1) {
      getWalletCardList(type: "deposit");
    } else if (index == 2) {
      getWalletCardList(type: "spend");
    }
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
  Future<void> getWalletCardList({String? type}) async {
    try {
      isLoadingWalletCardList.value = true;
      final result = await walletRepository.getWalletCardList(type: type);
      if (result.isNotEmpty) {
        walletCardList.value = result;
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoadingWalletCardList.value = false;
    }
  }
}
