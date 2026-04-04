import 'package:coffie/core/service/api_service/api_services.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/new_order/domain/model/store_model.dart';

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
}
