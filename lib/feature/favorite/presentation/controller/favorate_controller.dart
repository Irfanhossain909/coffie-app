import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/favorite/domain/model/favorite_product_model.dart';
import 'package:coffie/feature/favorite/domain/model/favorite_store_model.dart';
import 'package:coffie/feature/profile/domain/entity/favorite_card_entity.dart';
import 'package:coffie/feature/favorite/domain/repository/favorite_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavorateController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // ----------------------------- REPOSITORY -----------------------------
  final FavoriteRepository favoriteRepository = FavoriteRepository.instance;

  // ----------------------------- CONTROLLER -----------------------------
  late TabController tabController;
  var currentIndex = 0.obs;

  // ----------------------------- VARIABLES -----------------------------
  RxBool isLoading = false.obs;

  RxList<FavorireStoreDataModel> favoriteStoreList =
      <FavorireStoreDataModel>[].obs;
  RxList<FavorireProductDataModel> favoriteProductList =
      <FavorireProductDataModel>[].obs;

  /// ----------------------------- FUNCTIONS -----------------------------
  @override
  void onInit() {
    super.onInit();
    getFavoriteStoreList();
    tabController = TabController(length: 2, vsync: this);

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
      getFavoriteStoreList();
    } else if (index == 1) {
      getFavoriteProductList();
    }
  }

  /// ----------------------------- FUNCTIONS -----------------------------
  Future<void> getFavoriteStoreList() async {
    try {
      isLoading.value = true;
      final result = await favoriteRepository.getFavoriteStoreList();
      favoriteStoreList.value = result;
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getFavoriteProductList() async {
    try {
      isLoading.value = true;
      final result = await favoriteRepository.getFavoriteProductList();
      favoriteProductList.value = result;
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void toggleFavorite(int index) {
    final item = favoriteCardEntityList[index];

    favoriteCardEntityList[index] = FavoriteCardEntity(
      image: item.image,
      name: item.name,
      address: item.address,
      status: item.status,
      isFavorite: !(item.isFavorite ?? false),
    );

    // favoriteCardEntityList.refresh();
    update();
  }
}
