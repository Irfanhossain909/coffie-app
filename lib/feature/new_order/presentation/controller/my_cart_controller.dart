import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:coffie/feature/new_order/domain/model/cart_item_model.dart';
import 'package:coffie/feature/new_order/domain/repository/new_order_repository.dart';
import 'package:get/get.dart';

class MyCartController extends GetxController {
  /// repository here
  final NewOrderRepository _newOrderRepository = NewOrderRepository.instance;

  /// Observable variables
  Rxn<CartItemModel> cartItem = Rxn<CartItemModel>();
  RxBool isLoading = false.obs;

  /// init state here
  @override
  void onInit() {
    super.onInit();
    getCart();
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
}
