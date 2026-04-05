import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/gift_card/domain/model/gift_card_balance_model.dart';
import 'package:coffie/feature/gift_card/domain/model/gift_card_model.dart';
import 'package:coffie/feature/gift_card/domain/model/gift_card_redeem_model.dart';
import 'package:coffie/feature/gift_card/domain/repository/gift_card_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GiftCardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Repository
  final GiftCardRepository giftCardRepository = GiftCardRepository.instance;

  // controller here
  late TabController tabController;
  var currentIndex = 0.obs;

  // Model
  final Rxn<GiftCardBalanceModel> giftCardBalanceModel =
      Rxn<GiftCardBalanceModel>();

  RxList<GiftCardDataModel> giftCardTransactions = <GiftCardDataModel>[].obs;
  RxList<GiftCardRedemDataModel> giftCardRedeem =
      <GiftCardRedemDataModel>[].obs;
  // Is Loading
  final RxBool isLoading = false.obs;
  final RxBool isLoadingGiftCardTransactions = false.obs;

  final RxString selectedCategory = "".obs;

  /// init state here
  @override
  void onInit() {
    super.onInit();
    getGiftCardBalance();
    getGiftCardTransactions(giftCardEndPoint: "available");
    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      if (tabController.indexIsChanging) return;

      currentIndex.value = tabController.index;

      // 👇 Tab change hole function call
      onTabChanged(tabController.index);
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void onTabChanged(int index) {
    if (index == 0) {
      getGiftCardTransactions(giftCardEndPoint: "available");
    } else if (index == 1) {
      getGiftCardTransactions(giftCardEndPoint: "sent");
    } else if (index == 2) {
      getGiftCardRedeem();
    }
  }

  void reload() {
    getGiftCardBalance();
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  Future<void> getGiftCardTransactions({
    required String giftCardEndPoint,
  }) async {
    try {
      isLoadingGiftCardTransactions.value = true;
      final response = await giftCardRepository.getGiftCardTransactions(
        giftCardEndPoint: giftCardEndPoint,
      );
      if (response.isNotEmpty) {
        AppLogger.api(
          giftCardTransactions.length.toString(),
          title: "data Length",
        );
        giftCardTransactions.value = response;
      } else {
        giftCardTransactions.value = [];
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoadingGiftCardTransactions.value = false;
    }
  }

  Future<void> getGiftCardRedeem() async {
    try {
      isLoadingGiftCardTransactions.value = true;
      final response = await giftCardRepository.getGiftCardRedeem();
      if (response.isNotEmpty) {
        giftCardRedeem.value = response;
      } else {
        giftCardRedeem.value = [];
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoadingGiftCardTransactions.value = false;
    }
  }

  // Function to get gift card balance
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
