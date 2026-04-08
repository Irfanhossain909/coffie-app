import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:coffie/feature/new_order/domain/model/cart_item_model.dart';
import 'package:coffie/feature/new_order/domain/model/cart_summary_model.dart';
import 'package:coffie/feature/new_order/domain/repository/new_order_repository.dart';
import 'package:coffie/feature/reward/presentation/controller/reward_controller.dart';
import 'package:get/get.dart';

class MyCartController extends GetxController {
  /// repository here
  final NewOrderRepository _newOrderRepository = NewOrderRepository.instance;

  //controller here
  RewardController rewardController = Get.find<RewardController>();

  /// Observable variables
  Rxn<CartItemModel> cartItem = Rxn<CartItemModel>();
  Rxn<CartSummaryModel> cartSummary = Rxn<CartSummaryModel>();
  RxBool isLoading = false.obs;

  /// init state here
  @override
  void onInit() {
    super.onInit();
    getCart();
    getOrderSummary();
  }

  /// get cart here
  Future<void> getCart() async {
    try {
      isLoading.value = true;
      final result = await _newOrderRepository.getCart();
      cartItem.value = result;
    } catch (e) {
      AppLogger.error("Error in getCart: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// update item quantity here
  Future<void> updateItemQuantity({
    required String itemId,
    required int quantity,
  }) async {
    try {
      final result = await _newOrderRepository.updateItemQuantity(
        itemId: itemId,
        quantity: quantity,
      );
      if (result) {
        if (quantity == 0) {
          cartItem.value?.data?.items?.removeWhere(
            (element) => element.id == itemId,
          );
          cartItem.refresh();
        }
        AppSnackBar.success("Item quantity updated successfully");
      } else {
        AppSnackBar.error("Failed to update item quantity");
      }
    } catch (e) {
      AppLogger.error("Error in updateItemQuantity: $e");
      AppSnackBar.error("Failed to update item quantity");
    }
  }

  /// get order summary here
  Future<void> getOrderSummary() async {
    try {
      isLoading.value = true;
      final result = await _newOrderRepository.getOrderSummary();
      cartSummary.value = result;
    } catch (e) {
      AppLogger.error("Error in getOrderSummary: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// update tip and points here
  Future<void> updateTipAndPoints({
    double? tipAmount,
    int? redeemLoyaltyPoints,
  }) async {
    try {
      final response = await _newOrderRepository.updateTipAndPoints(
        tipAmount: tipAmount,
        redeemLoyaltyPoints: redeemLoyaltyPoints,
      );
      if (response) {
        getOrderSummary();
        AppSnackBar.success("Tip and points updated successfully");
      } else {
        AppSnackBar.error("Failed to update tip and points");
      }
    } catch (e) {
      AppLogger.error("Error in updateTipAndPoints: $e");
    }
  }
}
