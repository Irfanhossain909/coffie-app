import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/feature/order/domain/model/order_card_model.dart';
import 'package:coffie/feature/order/presentation/controller/order_controller.dart';
import 'package:coffie/feature/reward/presentation/widget/loyelty_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      init: OrderController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(showLeading: false, text: "My Order"),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.all(16.r),
                height: 45.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200, // background color
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TabBar(
                  controller: controller.tabController,
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: Color(0xFF1E4DB7), // blue selected color
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black87,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                  tabs: const [
                    Tab(text: "Upcoming"),
                    Tab(text: "Completed"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    // Add Money
                    Obx(() {
                      if (controller.isLoading.value) {
                        return ListView.builder(
                          padding: EdgeInsets.all(16.r),
                          itemCount: 6,
                          itemBuilder: (_, __) => const LoyaltyCardShimmer(),
                        );
                      }

                      if (controller.orderList.isEmpty) {
                        return Center(
                          child: AppText(
                            data: "No rewards yet",
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.all(16.r),
                        itemCount: controller.orderList.length,
                        itemBuilder: (context, index) {
                          final data = controller.orderList[index];
                          return OrderCard(
                            data: data,
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.instance.rewardDetailsScreen,
                                arguments: {
                                  "screen_name": "Reward Details",
                                  "order_id": data.id,
                                },
                              );
                            },
                          );
                        },
                      );
                    }),
                    // Spend
                    Obx(() {
                      if (controller.isLoading.value) {
                        return ListView.builder(
                          padding: EdgeInsets.all(16.r),
                          itemCount: 6,
                          itemBuilder: (_, __) => const LoyaltyCardShimmer(),
                        );
                      }

                      if (controller.orderList.isEmpty) {
                        return Center(
                          child: AppText(
                            data: "No rewards yet",
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.all(16.r),
                        itemCount: controller.orderList.length,
                        itemBuilder: (context, index) {
                          final data = controller.orderList[index];
                          return OrderCard(
                            data: data,
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.instance.rewardDetailsScreen,
                                arguments: {
                                  "screen_name": "My Order",
                                  "order_id": data.id,
                                },
                              );
                            },
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final VoidCallback? onTap;
  final OrderCardDataModel data;
  const OrderCard({super.key, this.onTap, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.yellow),
      ),
      width: double.infinity,

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        spacing: 10.w,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.yellow),
            ),
            child: AppImageCircular(
              borderRadius: 8.r,
              url: "${AppApiEndPoint.domain}${data.previewImage}",
              width: 99.w,
              height: 93.h,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                AppText(
                  data: "Order #${data.orderId} . ${data.totalItems} items",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                AppText(
                  data: data.productNames?.join(", ") ?? "",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                AppText(
                  data: "New Work | 2.6 km",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                AppText(
                  data: r"May 15, 2023 $4.50",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                AppText(
                  data: "\$${data.orderTotal} ",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
          // Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 4.h,
            children: [
              Icon(Icons.favorite_border, size: 22.sp, color: AppColors.yellow),
              AppText(
                data: data.orderStatus ?? "",
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
              SizedBox(height: 18.h),
              InkWell(
                onTap: onTap,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.yellow),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: AppText(
                    data: "View Details",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
