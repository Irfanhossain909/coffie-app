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
      builder: (controller) {
        Widget buildOrderTab({
          required int tabIndex,
          required String detailsScreenName,
        }) {
          return Obx(() {
            final list = controller.orderTabLists[tabIndex];
            if (!controller.orderTabFirstResponseDone[tabIndex].value &&
                controller.currentIndex.value != tabIndex) {
              return const SizedBox.shrink();
            }
            final isInitialLoading =
                controller.orderTabInitialLoading[tabIndex].value &&
                list.isEmpty;

            if (isInitialLoading) {
              return ListView.builder(
                padding: EdgeInsets.all(16.r),
                itemCount: 6,
                itemBuilder: (_, __) => const LoyaltyCardShimmer(),
              );
            }

            if (list.isEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  await controller.reloadOrderList(tabIndex: tabIndex);
                },
                child: ListView(
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
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                await controller.reloadOrderList(tabIndex: tabIndex);
              },
              child: ListView.builder(
                controller: controller.orderScrollControllers[tabIndex],
                padding: EdgeInsets.all(16.r),
                itemCount: list.length + 1,
                itemBuilder: (context, index) {
                  if (index >= list.length) {
                    if (controller.orderTabLoadingMore[tabIndex].value) {
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

                    if (!controller.orderTabHasMore[tabIndex].value) {
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

                  final data = list[index];
                  return OrderCard(
                    data: data,
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.instance.rewardDetailsScreen,
                        arguments: {
                          "screen_name": detailsScreenName,
                          "order_id": data.id,
                        },
                      );
                    },
                  );
                },
              ),
            );
          });
        }

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
                    buildOrderTab(
                      tabIndex: 0,
                      detailsScreenName: "Reward Details",
                    ),
                    buildOrderTab(tabIndex: 1, detailsScreenName: "My Order"),
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
              spacing: 2.h,
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
                  data: data.orderStatus ?? "",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
                AppText(
                  data: "Pickup Time: Ready in ${data.readyTime} mins",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                AppText(
                  data: joinWithLessThan(data.productNames),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      data: "\$${data.orderTotal} ",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
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
          ),

          // Spacer(),
        ],
      ),
    );
  }
}


String joinWithLessThan(List<String>? items) {
  if (items == null || items.isEmpty) return "";
  return items.join(', ');
}