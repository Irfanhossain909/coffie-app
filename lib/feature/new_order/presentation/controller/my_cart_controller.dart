import 'package:coffie/core/component/app_webview/stripe_web_view_page.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:coffie/feature/gift_card/presentation/controller/gift_card_controller.dart';
import 'package:coffie/feature/gift_card/presentation/widget/app_success_dialog.dart';
import 'package:coffie/feature/new_order/domain/model/cart_item_model.dart';
import 'package:coffie/feature/new_order/domain/model/cart_summary_model.dart';
import 'package:coffie/feature/new_order/domain/repository/new_order_repository.dart';
import 'package:coffie/feature/reward/presentation/controller/reward_controller.dart';
import 'package:coffie/feature/wallet/presentation/controller/my_wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCartController extends GetxController {
  /// repository here
  final NewOrderRepository _newOrderRepository = NewOrderRepository.instance;

  //controller here
  final RewardController rewardController = Get.find<RewardController>();
  final GiftCardController giftCardController = Get.find<GiftCardController>();
  final MyWalletController walletController = Get.find<MyWalletController>();

  /// Observable variables
  Rxn<CartItemModel> cartItem = Rxn<CartItemModel>();
  Rxn<CartSummaryModel> cartSummary = Rxn<CartSummaryModel>();
  RxBool isLoading = false.obs;
  RxBool isPaymentProcessing = false.obs;
  String paymentMethod = "";

  List<Item> get cartListItem => cartItem.value?.data?.items ?? const [];

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

  /// place order here
  Future<void> placeOrder({
    required String paymentMethod,
    double? tipAmount,
    double? loyaltyPointsToUse,
  }) async {
    try {
      isPaymentProcessing.value = true;
      if (paymentMethod.isEmpty) {
        AppSnackBar.error("Please select a payment method");
        return;
      }
      final response = await _newOrderRepository.placeOrder(
        paymentMethod: paymentMethod,
        tipAmount: tipAmount?.toInt(),
        loyaltyPointsToUse: loyaltyPointsToUse,
      );

      if (response == true) {
        AppSnackBar.success("Order placed successfully");
        Get.back();
      } else if (response is String) {
        openStripePayment(
          context: Get.context!,
          paymentUrl: response,
          successUrl: "/payment/success",
          cancelUrl: "/payment/cancel",
        );
      }
    } catch (e) {
      AppLogger.error("Error in placeOrder: $e");
      AppSnackBar.error("Failed to process payment");
    } finally {
      isPaymentProcessing.value = false;
    }
  }

  Future<void> openStripePayment({
    BuildContext? context,
    required String paymentUrl,
    required String successUrl,
    required String cancelUrl,
  }) async {
    if (context == null) return;
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StripeWebViewPage(
          paymentUrl: paymentUrl,
          successEndpoint: successUrl,
          cancelEndpoint: cancelUrl,
        ),
      ),
    );

    if (result != null && context.mounted) {
      if (result['status'] == 'success') {
        AppSuccessDialog.show(
          context: context,
          icon: Icon(
            Icons.check_circle_rounded,
            color: AppColors.green,
            size: 64,
          ),
          title: "Thanks for your order",
          message:
              "You have just completed your payment. The seller will reach out to you as soon as possible.",
          buttonTitle: "View My Wallet",
          onButtonPressed: () => Get.close(1),
        );
      } else {
        AppLogger.info("Payment Cancelled");
      }
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

  /// delete cart here
  Future<void> deleteCart() async {
    try {
      final response = await _newOrderRepository.deleteCart();
      if (response) {
        AppSnackBar.success("Cart Cleared");
        cartItem.value = null;
        cartSummary.value = null;
        cartItem.refresh();
        cartSummary.refresh();
        Get.back();
      } else {
        AppSnackBar.error("Failed to delete cart");
      }
    } catch (e) {
      AppLogger.error("Error in deleteCart: $e");
    }
  }
}
