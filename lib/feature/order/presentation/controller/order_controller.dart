import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/order/domain/model/order_card_model.dart';
import 'package:coffie/feature/order/domain/repository/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  /// repository here
  final OrderRepository orderRepository = OrderRepository.instance;

  /// model here
  RxList<OrderCardDataModel> orderList = <OrderCardDataModel>[].obs;

  late TabController tabController;
  var currentIndex = 0.obs;

  /// controller here
  final RxBool isLoading = false.obs;
  int page = 1;
  int limit = 10;

  /// init state here
  @override
  void onInit() {
    super.onInit();
    getOrderList(orderType: "upcoming");
    tabController = TabController(length: 2, vsync: this);

    tabController.addListener(() {
      if (tabController.indexIsChanging) return;

      currentIndex.value = tabController.index;

      // 👇 Tab change hole function call
      onTabChanged(tabController.index);
    });
  }

  void onTabChanged(int index) {
    if (index == 0) {
      getOrderList(orderType: "upcoming");
    } else if (index == 1) {
      getOrderList(orderType: "completed");
    }
  }

  /// get order list function here
  Future<void> getOrderList({required String orderType}) async {
    try {
      isLoading.value = true;
      final result = await orderRepository.getOrderList(
        orderType: orderType,
        page: page,
        limit: limit,
      );
      orderList.assignAll(result);
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
