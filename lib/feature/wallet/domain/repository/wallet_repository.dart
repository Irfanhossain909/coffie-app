import 'package:coffie/core/service/api_service/api_services.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/wallet/domain/model/wallet_balance_model.dart';
import 'package:coffie/feature/wallet/domain/model/wallet_card_list_model.dart';
import 'package:coffie/feature/wallet/domain/model/wallet_details_model.dart';

class WalletRepository {
  WalletRepository._();
  static final WalletRepository _instance = WalletRepository._();
  static WalletRepository get instance => _instance;

  ApiServices apiServices = ApiServices.instance;

  Future<WalletBalanceModel?> getWalletBalance() async {
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.walletBalance,
      );
      if (response != null && response is Map<String, dynamic>) {
        return WalletBalanceModel.fromJson(response);
      }
      return null;
    } catch (e) {
      AppLogger.error(e.toString());
    }

    return null;
  }

  Future<List<WalletCardListDataModel>> getWalletCardList({
    String? type,
    int? page,
    int? limit,
  }) async {
    List<WalletCardListDataModel> walletCardList = <WalletCardListDataModel>[];
    try {
      final Map<String, dynamic> queryParams = {};
      if (type != null && type.isNotEmpty) queryParams["type"] = type;
      if (page != null) queryParams["page"] = page;
      if (limit != null) queryParams["limit"] = limit;
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.walletCardList,
        queryParameters: queryParams,
      );
      if (response != null && response is Map<String, dynamic>) {
        if (response["data"] != null && response["data"] is List) {
          for (var card in response["data"]) {
            walletCardList.add(WalletCardListDataModel.fromJson(card));
          }
        }
      }
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return walletCardList;
  }

  Future<WalletDetailsModel?> getWalletHistory({
    required String walletId,
  }) async {
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.walletHistory(walletId),
      );
      if (response != null && response is Map<String, dynamic>) {
        return WalletDetailsModel.fromJson(response);
      }
      return null;
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return null;
  }

  Future<dynamic> addWalletMoney({required int amount}) async {
    try {
      final response = await apiServices.apiPostServices(
        url: AppApiEndPoint.instance.walletAdd,

        body: {"amount": amount},
      );
      if (response != null && response is Map<String, dynamic>) {
        AppLogger.api(response["data"]["checkoutUrl"]);
        return response["data"]["checkoutUrl"];
      }
      return false;
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return false;
  }
}
