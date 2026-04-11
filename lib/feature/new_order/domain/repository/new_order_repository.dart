import 'package:coffie/core/service/api_service/api_services.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/new_order/domain/entity/add_to_cart_entity.dart';
import 'package:coffie/feature/new_order/domain/model/cart_item_model.dart'
    hide SelectedCustomization;
import 'package:coffie/feature/new_order/domain/model/cart_summary_model.dart';
import 'package:coffie/feature/new_order/domain/model/shop_categoty_model.dart';
import 'package:coffie/feature/new_order/domain/model/single_product_model.dart';
import 'package:coffie/feature/new_order/domain/model/store_model.dart';
import 'package:coffie/feature/new_order/domain/model/store_product_model.dart';

class NewOrderRepository {
  NewOrderRepository._();
  static final NewOrderRepository _instance = NewOrderRepository._();
  static NewOrderRepository get instance => _instance;

  /// Get Stores
  ApiServices apiServices = ApiServices.instance;

  Future<List<StoreDataModel>> getStores({
    double? latitude,
    double? longitude,
    String? searchTerm,
    int limit = 10,
    int page = 1,
  }) async {
    List<StoreDataModel> stores = <StoreDataModel>[];
    try {
      Map<String, dynamic> queryParameters = {};
      if (latitude != null) {
        queryParameters["latitude"] = latitude;
      }
      if (longitude != null) {
        queryParameters["longitude"] = longitude;
      }
      if (searchTerm != null) {
        queryParameters["searchTerm"] = searchTerm;
      }
      queryParameters["limit"] = limit;
      queryParameters["page"] = page;
      final response = await ApiServices.instance.apiGetServices(
        AppApiEndPoint.instance.stores,
        queryParameters: queryParameters,
      );
      if (response["success"] == true) {
        for (var store in response["data"]) {
          stores.add(StoreDataModel.fromJson(store));
        }
      }
    } catch (e) {
      AppLogger.error("Error in getStores: $e");
    }
    return stores;
  }

  Future<List<StoreCategoryDataModel>> getStoreCategories() async {
    List<StoreCategoryDataModel> storeCategories = <StoreCategoryDataModel>[];
    try {
      final response = await ApiServices.instance.apiGetServices(
        AppApiEndPoint.instance.storeCategories,
      );
      if (response["success"] == true && response["data"] != null) {
        for (var category in response["data"]) {
          storeCategories.add(StoreCategoryDataModel.fromJson(category));
        }
      }
    } catch (e) {
      AppLogger.error("Error in getStoreCategories: $e");
    }
    return storeCategories;
  }

  Future<List<StoreProjectDataModel>> getStoreProductById(
    String storeId,
    String? categoryId,
  ) async {
    List<StoreProjectDataModel> storeProducts = <StoreProjectDataModel>[];
    try {
      Map<String, dynamic> queryParameters = {};
      if (categoryId != null) {
        queryParameters["category"] = categoryId;
      }
      final response = await ApiServices.instance.apiGetServices(
        AppApiEndPoint.storeProductById(storeId),
        queryParameters: queryParameters,
      );
      if (response["success"] == true) {
        for (var product in response["data"]) {
          storeProducts.add(StoreProjectDataModel.fromJson(product));
        }
      }
    } catch (e) {
      AppLogger.error("Error in getStoreProductById: $e");
    }
    return storeProducts;
  }

  Future<SingleProductModel?> getSingleProduct(String productId) async {
    try {
      final response = await ApiServices.instance.apiGetServices(
        AppApiEndPoint.singleProduct(productId),
      );
      if (response != null && response is Map<String, dynamic>) {
        return SingleProductModel.fromJson(response);
      }
    } catch (e) {
      AppLogger.error("Error in getSingleProduct: $e");
    }
    return null;
  }

  Future<bool> addToCart({
    required String product,
    required int quantity,
    required List<SelectedCustomization> addToCart,
  }) async {
    try {
      final response = await apiServices.apiPostServices(
        url: AppApiEndPoint.instance.addToCart,
        body: {
          "product": product,
          "quantity": quantity,
          "selectedCustomizations": addToCart.map((e) => e.toJson()).toList(),
        },
      );
      if (response != null && response is Map<String, dynamic>) {
        return true;
      }
      return false;
    } catch (e) {
      AppLogger.error("Error in addToCart: $e");
    }

    return false;
  }

  Future<CartItemModel?> getCart() async {
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.addToCart,
      );
      if (response != null && response is Map<String, dynamic>) {
        return CartItemModel.fromJson(response);
      }
    } catch (e) {
      AppLogger.error("Error in getCart: $e");
    }

    return null;
  }

  Future<bool> updateItemQuantity({
    required String itemId,
    required int quantity,
  }) async {
    try {
      final response = await apiServices.apiPatchServices(
        url: AppApiEndPoint.instance.updateItemQuantity,
        body: {"itemId": itemId, "quantity": quantity},
      );
      if (response != null && response is Map<String, dynamic>) {
        return true;
      }
      return false;
    } catch (e) {
      AppLogger.error("Error in updateItemQuantity: $e");
    }

    return false;
  }

  Future<CartSummaryModel?> getOrderSummary() async {
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.orderSummary,
      );
      if (response != null && response is Map<String, dynamic>) {
        return CartSummaryModel.fromJson(response);
      }
    } catch (e) {
      AppLogger.error("Error in getOrderSummary: $e");
    }

    return null;
  }

  Future<bool> updateTipAndPoints({
    double? tipAmount,
    int? redeemLoyaltyPoints,
  }) async {
    try {
      Map<String, dynamic> body = {};
      if (tipAmount != null && tipAmount > 0) {
        body["tipAmount"] = tipAmount;
      }
      if (redeemLoyaltyPoints != null) {
        body["redeemLoyaltyPoints"] = redeemLoyaltyPoints;
      }
      final response = await apiServices.apiPatchServices(
        url: AppApiEndPoint.instance.updatetipAndPoints,
        body: body,
      );
      if (response != null && response is Map<String, dynamic>) {
        return true;
      }
      return false;
    } catch (e) {
      AppLogger.error("Error in updateTipAndPoints: $e");
    }

    return false;
  }

  Future<dynamic> placeOrder({
    required String paymentMethod,
    int? tipAmount,
    double? loyaltyPointsToUse,
  }) async {
    try {
      Map<String, dynamic> body = {};
      body["paymentMethod"] = paymentMethod;
      if (tipAmount != null && tipAmount > 0) {
        body["tipAmount"] = tipAmount;
      }
      if (loyaltyPointsToUse != null && loyaltyPointsToUse > 0) {
        body["loyaltyPointsToUse"] = loyaltyPointsToUse;
      }
      final response = await apiServices.apiPostServices(
        url: AppApiEndPoint.instance.placeOrder,
        body: body,
      );
      if (response != null && response is Map<String, dynamic>) {
        if (response["data"]?["paymentResult"]?["checkoutUrl"] != null) {
          AppLogger.api(
            response["data"]?["paymentResult"]?["checkoutUrl"],
            title: "Place Order Response",
          );
          return response["data"]?["paymentResult"]?["checkoutUrl"];
        } else {
          return true;
        }
      }
      return false;
    } catch (e) {
      AppLogger.error("Error in placeOrder: $e");
    }

    return false;
  }

  Future<bool> deleteCart() async {
    try {
      final response = await apiServices.apiDeleteServices(
        url: AppApiEndPoint.instance.deleteCart,
      );
      if (response != null && response is Map<String, dynamic>) {
        return true;
      }
      return false;
    } catch (e) {
      AppLogger.error("Error in deleteCart: $e");
    }
    return false;
  }

  Future<bool> addFavorite({required String id, required String type}) async {
    try {
      final response = await apiServices.apiPostServices(
        url: AppApiEndPoint.instance.favorite,
        body: {type: id},
      );
      if (response != null && response is Map<String, dynamic>) {
        return true;
      }
      return false;
    } catch (e) {
      AppLogger.error("Error in addFavorite: $e");
    }
    return false;
  }

  Future<bool> removeFavorite({
    required String id,
    required String type,
  }) async {
    try {
      final response = await apiServices.apiDeleteServices(
        url: AppApiEndPoint.instance.favorite,
        body: {type: id},
      );
      if (response != null && response is Map<String, dynamic>) {
        return true;
      }
      return false;
    } catch (e) {
      AppLogger.error("Error in removeFavorite: $e");
    }
    return false;
  }
}
