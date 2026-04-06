import 'package:coffie/core/service/api_service/api_services.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/favorite/domain/model/favorite_product_model.dart';
import 'package:coffie/feature/favorite/domain/model/favorite_store_model.dart';

class FavoriteRepository {
  FavoriteRepository._();
  static final FavoriteRepository _instance = FavoriteRepository._();
  static FavoriteRepository get instance => _instance;

  ApiServices apiServices = ApiServices.instance;

  Future<List<FavorireStoreDataModel>> getFavoriteStoreList() async {
    List<FavorireStoreDataModel> favoriteStoreList = <FavorireStoreDataModel>[];
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.favoriteStoreList,
      );
      if (response != null && response is Map<String, dynamic>) {
        if (response["data"] != null && response["data"] is List) {
          for (var store in response["data"]) {
            favoriteStoreList.add(FavorireStoreDataModel.fromJson(store));
          }
        }
      }
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return favoriteStoreList;
  }

  Future<List<FavorireProductDataModel>> getFavoriteProductList() async {
    List<FavorireProductDataModel> favoriteProductList =
        <FavorireProductDataModel>[];
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.favoriteProductList,
      );
      if (response != null && response is Map<String, dynamic>) {
        if (response["data"] != null && response["data"] is List) {
          for (var store in response["data"]) {
            favoriteProductList.add(FavorireProductDataModel.fromJson(store));
          }
        }
      }
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return favoriteProductList;
  }
}
