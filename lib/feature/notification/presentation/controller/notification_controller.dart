import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/notification/domain/model/notification_model.dart';
import 'package:coffie/feature/notification/domain/repository/notification_repository.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  // repository here
  final NotificationRepository notificationRepository =
      NotificationRepository.instance;

  // model here
  RxList<NotificationDataModel> notifications = <NotificationDataModel>[].obs;

  // controller here
  RxBool isLoading = false.obs;
  int page = 1;
  int limit = 10;

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  Future<void> getNotifications() async {
    try {
      isLoading.value = true;
      final result = await notificationRepository.getNotifications(
        page: page,
        limit: limit,
      );
      if (result.isNotEmpty) {
        notifications.value = result;
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markAllAsRead() async {
    try {
      final result = await notificationRepository.markAllAsRead();
      if (result) {
        notifications.value = notifications
            .where((notification) => notification.isRead == true)
            .toList();
      }
      notifications.refresh();
    } catch (e) {
      AppLogger.error(e.toString());
    }
  }
}
