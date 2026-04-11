import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/utils/formet_time_ago.dart';
import 'package:coffie/feature/notification/domain/model/notification_model.dart';
import 'package:coffie/feature/notification/presentation/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(
            text: "Notification",
            action: [
              TextButton(
                onPressed: () {
                  controller.markAllAsRead();
                },
                child: AppText(
                  data: "Read All",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blue,
                ),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await controller.reloadNotifications();
            },
            child: Obx(() {
              final isInitialLoading = controller.initialLoading.value &&
                  controller.notifications.isEmpty;

              if (isInitialLoading) {
                return ListView(
                  padding: EdgeInsets.all(16.h),
                  children: List.generate(
                    6,
                    (int i) => Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      height: 72.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                );
              }

              if (controller.notifications.isEmpty) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(height: 140.h),
                    Center(
                      child: AppText(
                        data: "No data found",
                        fontSize: 16.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              }

              return ListView.builder(
                controller: controller.notificationScrollController,
                padding: EdgeInsets.all(16.h),
                itemCount: controller.notifications.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index >= controller.notifications.length) {
                    if (controller.loadingMore.value) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: const Center(
                          child: SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      );
                    }

                    if (!controller.hasMore.value) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Center(
                          child: AppText(
                            data: "End",
                            fontSize: 14.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }

                    return SizedBox(height: 16.h);
                  }

                  final NotificationDataModel notification =
                      controller.notifications[index];
                  return NotificationCard(
                    notification: notification,
                    onTap: () {
                      controller.singleReadNotification(notification.id ?? "");
                    },
                  );
                },
              );
            }),
          ),
        );
      },
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationDataModel notification;
  final VoidCallback? onTap;
  const NotificationCard({super.key, required this.notification, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.yellow),
          borderRadius: BorderRadius.circular(10.r),
          color: notification.isRead == true
              ? AppColors.backgrounColor
              : AppColors.offWhite,
        ),
        child: Row(
          spacing: 12.w,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                color: AppColors.offWhite,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notification_important,
                color: AppColors.lightBlue.withValues(alpha: 0.5),
                size: 16.w,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  AppText(
                    data: notification.title ?? "",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                  AppText(
                    data: notification.message ?? "",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.black.withValues(alpha: 0.5),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: AppText(
                data: formatTimeAgo(notification.createdAt),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
