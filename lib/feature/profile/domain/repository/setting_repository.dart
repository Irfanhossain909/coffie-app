import 'package:coffie/core/service/api_service/api_services.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/profile/domain/model/transection_history_model.dart';

class SettingRepository {
  SettingRepository._();
  static final SettingRepository _instance = SettingRepository._();
  static SettingRepository get instance => _instance;

  ApiServices apiServices = ApiServices.instance;

  Future<List<TtrancestionHistoryDataModel>> getTransectionHistory({
    int? page,
    int? limit,
  }) async {
    List<TtrancestionHistoryDataModel> transectionHistory =
        <TtrancestionHistoryDataModel>[];
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.transectionHistory,
        queryParameters: {"page": page, "limit": limit},
      );
      if (response == null || response is! Map) {
        return [];
      }
      final map = Map<String, dynamic>.from(response);
      if (map["success"] == true && map["data"] is List) {
        for (var transection in map["data"]) {
          transectionHistory.add(
            TtrancestionHistoryDataModel.fromJson(transection),
          );
        }
      }
      return transectionHistory;
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return [];
  }

  Future<bool> changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      final response = await apiServices.apiPostServices(
        url: AppApiEndPoint.instance.changePassword,
        body: {
          "currentPassword": currentPassword,
          "newPassword": newPassword,
          "confirmPassword": confirmPassword,
        },
      );
      if (response["success"] == true) {
        return true;
      }
      return false;
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return false;
  }

  Future<bool> contactUs(
    String name,
    String email,
    String subject,
    String message,
  ) async {
    try {
      final response = await apiServices.apiPostServices(
        url: AppApiEndPoint.instance.contactUs,
        body: {
          "name": name,
          "email": email,
          "subject": subject,
          "message": message,
        },
      );
      if (response["success"] == true) {
        return true;
      }
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return false;
  }

  Future<bool> deleteAccount(String password, String userId) async {
    try {
      final response = await apiServices.apiDeleteServices(
        url: AppApiEndPoint.deleteAccount(userId),
        body: {
          "password": password,
        },
      );
      if (response["success"] == true) {
        return true;
      }
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return true;
  }

  Future<String?> getPrivacyPolicy(String endPoint) async {
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.privacyPolicy(endPoint),
      );
      if (response["success"] == true) {
        AppLogger.api(response["data"]["content"]);
        return response["data"]["content"];
      }
      return "";
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return null;
  }
}
