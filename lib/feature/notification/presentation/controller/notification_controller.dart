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

  void markAllAsRead() async {
    final success = await NotificationRepository.instance.markAllAsRead();

    if (success) {
      for (var item in notifications) {
        item.isRead = true;
      }
      notifications.refresh();
    }
  }

  void singleReadNotification(String id) async {
    final success = await NotificationRepository.instance
        .singleReadNotification(id);

    if (success) {
      int index = notifications.indexWhere((e) => e.id == id);

      if (index != -1) {
        notifications[index].isRead = true;
        notifications.refresh(); // IMPORTANT
      }
    }
  }
}
