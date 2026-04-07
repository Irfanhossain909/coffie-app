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
      init: NotificationController(),
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
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              padding: EdgeInsets.all(16.h),
              itemCount: controller.notifications.length,
              itemBuilder: (context, index) {
                final notification = controller.notifications[index];
                return NotificationCard(notification: notification);
              },
            );
          }),
        );
      },
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationDataModel notification;
  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
