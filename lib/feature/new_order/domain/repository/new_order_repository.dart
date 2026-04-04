import 'package:coffie/core/service/api_service/api_services.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/new_order/domain/model/shop_categoty_model.dart';
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
}
