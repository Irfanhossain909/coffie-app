import 'package:coffie/core/service/api_service/get_storage_services.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/favorite/domain/model/favorite_product_model.dart';
import 'package:coffie/feature/favorite/domain/model/favorite_store_model.dart';
import 'package:coffie/feature/new_order/domain/repository/new_order_repository.dart';
import 'package:coffie/feature/favorite/domain/repository/favorite_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavorateController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // ----------------------------- REPOSITORY -----------------------------
  final FavoriteRepository favoriteRepository = FavoriteRepository.instance;
  final NewOrderRepository _newOrderRepository = NewOrderRepository.instance;
  final GetStorageServices getStorageServices = GetStorageServices.instance;
  bool get isGuest => getStorageServices.getIsGuest();

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

  Future<void> addStoreFavorite(String storeId) async {
    if (storeId.isEmpty) return;
    try {
      final response = await _newOrderRepository.addFavorite(
        id: storeId,
        type: "store",
      );
      if (response) {
        final idx = favoriteStoreList.indexWhere(
          (e) => e.store?.id == storeId,
        );
        if (idx != -1) {
          favoriteStoreList[idx].isFavorite = true;
          favoriteStoreList.refresh();
        }
      }
    } catch (e) {
      AppLogger.error(e.toString());
    }
  }

  Future<void> removeFavorite(String storeId) async {
    if (storeId.isEmpty) return;
    try {
      final response = await _newOrderRepository.removeFavorite(
        id: storeId,
        type: "store",
      );
      if (response) {
        favoriteStoreList.removeWhere((e) => e.store?.id == storeId);
        favoriteStoreList.refresh();
      }
    } catch (e) {
      AppLogger.error(e.toString());
    }
  }

  Future<void> addProductFavorite(String productId) async {
    if (productId.isEmpty) return;
    try {
      final response = await _newOrderRepository.addFavorite(
        id: productId,
        type: "product",
      );
      if (response) {
        final idx = favoriteProductList.indexWhere(
          (e) => e.product?.id == productId,
        );
        if (idx != -1) {
          favoriteProductList[idx].isFavorite = true;
          favoriteProductList.refresh();
        }
      }
    } catch (e) {
      AppLogger.error(e.toString());
    }
  }

  Future<void> removeProductFavorite(String productId) async {
    if (productId.isEmpty) return;
    try {
      final response = await _newOrderRepository.removeFavorite(
        id: productId,
        type: "product",
      );
      if (response) {
        favoriteProductList.removeWhere((e) => e.product?.id == productId);
        favoriteProductList.refresh();
      }
    } catch (e) {
      AppLogger.error(e.toString());
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

  
}
