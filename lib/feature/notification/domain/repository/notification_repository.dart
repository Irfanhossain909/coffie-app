import 'package:coffie/core/service/api_service/api_services.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/notification/domain/model/notification_model.dart';

class NotificationRepository {
  NotificationRepository._();
  static final NotificationRepository _instance = NotificationRepository._();
  static NotificationRepository get instance => _instance;

  ApiServices apiServices = ApiServices.instance;

  Future<List<NotificationDataModel>> getNotifications({
    required int page,
    required int limit,
  }) async {
    List<NotificationDataModel> notifications = <NotificationDataModel>[];
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.notification,
        queryParameters: {"page": page, "limit": limit},
      );
      if (response != null && response is Map<String, dynamic>) {
        for (var notification in response["data"]) {
          notifications.add(NotificationDataModel.fromJson(notification));
        }
      }
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return notifications;
  }

  Future<bool> markAllAsRead() async {
    try {
      final response = await apiServices.apiPatchServices(
        url: "${AppApiEndPoint.instance.notification}/mark-all-as-read",
      );
      if (response != null && response is Map<String, dynamic>) {
        return response["success"] == true;
      }
    } catch (e) {
      AppLogger.error(e.toString());
    }

    return false;
  }
}
