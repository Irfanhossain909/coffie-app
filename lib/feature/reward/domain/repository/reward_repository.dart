import 'package:coffie/core/service/api_service/api_services.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/reward/domain/model/reward_card_details_model.dart';
import 'package:coffie/feature/reward/domain/model/reward_card_model.dart';
import 'package:coffie/feature/reward/domain/model/reward_point_model.dart';

class RewardRepository {
  RewardRepository._();
  static final RewardRepository _instance = RewardRepository._();
  static RewardRepository get instance => _instance;

  ApiServices apiServices = ApiServices.instance;

  Future<RewardPointModel?> getRewardPoints() async {
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.rewardPoints,
      );
      if (response != null && response is Map<String, dynamic>) {
        return RewardPointModel.fromJson(response);
      }
      return null;
    } catch (e) {
      AppLogger.error(e.toString());
    }

    return null;
  }

  Future<RewardCardModel?> getRewardHistory({
    String? type,
    int? page,
    int? limit,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {};

      if (type != null) queryParams["type"] = type;
      if (page != null) queryParams["page"] = page;
      if (limit != null) queryParams["limit"] = limit;

      final response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.rewardHistory,
        queryParameters: queryParams,
      );

      if (response != null && response is Map<String, dynamic>) {
        return RewardCardModel.fromJson(response);
      }
      return null;
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return null;
  }

  Future<RewardCardDetailsModel?> getLoyeltyCardDetails({
    required String orderId,
  }) async {
    try {
      
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.loyeltyCardDetails(orderId),
      );
      if (response != null && response is Map<String, dynamic>) {
        return RewardCardDetailsModel.fromJson(response);
      }
      return null;
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return null;
  }
}
