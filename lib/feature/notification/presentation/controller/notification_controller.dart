import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/notification/domain/model/notification_model.dart';
import 'package:coffie/feature/notification/domain/repository/notification_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

/// Single-list pagination aligned with wallet history: [notificationListPageLimit]
/// per request, scroll near bottom loads next page, dedupe by [NotificationDataModel.id].
class NotificationController extends GetxController {
  final NotificationRepository notificationRepository =
      NotificationRepository.instance;

  RxList<NotificationDataModel> notifications = <NotificationDataModel>[].obs;

  late final ScrollController notificationScrollController;

  static const int notificationListPageLimit = 9;

  int _page = 1;
  final RxBool hasMore = true.obs;

  final RxBool notificationFirstResponseDone = false.obs;
  final RxBool initialLoading = false.obs;
  final RxBool loadingMore = false.obs;

  @override
  void onInit() {
    super.onInit();
    notificationScrollController = ScrollController();
    notificationScrollController.addListener(_onNotificationScroll);
    loadNotifications(reset: true);
  }

  void _onNotificationScroll() {
    if (!notificationScrollController.hasClients) return;

    if (notificationScrollController.position.maxScrollExtent <= 0) return;

    if (notificationScrollController.position.userScrollDirection !=
        ScrollDirection.reverse) {
      return;
    }

    final isNearBottom =
        notificationScrollController.position.extentAfter < 120;
    if (!isNearBottom) return;

    loadNotifications(loadMore: true);
  }

  @override
  void onClose() {
    notificationScrollController.dispose();
    super.onClose();
  }

  Future<void> reloadNotifications() async {
    await loadNotifications(reset: true);
  }

  void _resetPagination() {
    _page = 1;
    hasMore.value = true;
    notifications.clear();
  }

  Future<void> loadNotifications({
    bool reset = false,
    bool loadMore = false,
  }) async {
    bool apiIssued = false;
    try {
      if (reset) {
        _resetPagination();
      }

      if (!hasMore.value) return;

      if (loadMore) {
        if (loadingMore.value || initialLoading.value) return;
        loadingMore.value = true;
      } else {
        if (initialLoading.value) return;
        initialLoading.value = true;
      }

      apiIssued = true;
      final int page = _page;
      final result = await notificationRepository.getNotifications(
        page: page,
        limit: notificationListPageLimit,
      );

      if (result.isEmpty) {
        hasMore.value = false;
        return;
      }

      if (page == 1) {
        notifications.assignAll(result);
      } else {
        final Set<String?> seen =
            notifications.map((NotificationDataModel e) => e.id).toSet();
        for (final NotificationDataModel item in result) {
          if (item.id != null && seen.contains(item.id)) continue;
          if (item.id != null) seen.add(item.id);
          notifications.add(item);
        }
      }

      if (result.length < notificationListPageLimit) {
        hasMore.value = false;
      } else {
        _page++;
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      if (apiIssued) {
        notificationFirstResponseDone.value = true;
      }
      initialLoading.value = false;
      loadingMore.value = false;
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
        notifications.refresh();
      }
    }
  }
}
