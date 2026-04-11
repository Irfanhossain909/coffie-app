import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/core/utils/formet_date.dart';
import 'package:coffie/feature/reward/domain/model/reward_card_model.dart';
import 'package:coffie/feature/reward/presentation/controller/reward_controller.dart';
import 'package:coffie/feature/reward/presentation/widget/loyelty_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RewardController>(
      builder: (controller) {
        Widget buildRewardHistoryTab({required int tabIndex}) {
          return Obx(() {
            final list = controller.rewardTabLists[tabIndex];
            if (!controller.rewardTabFirstResponseDone[tabIndex].value &&
                controller.currentIndex.value != tabIndex) {
              return const SizedBox.shrink();
            }
            final isInitialLoading =
                controller.rewardTabInitialLoading[tabIndex].value &&
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
                  await controller.reloadRewardHistoryTab(tabIndex: tabIndex);
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
                await controller.reloadRewardHistoryTab(tabIndex: tabIndex);
              },
              child: ListView.builder(
                controller: controller.rewardScrollControllers[tabIndex],
                padding: EdgeInsets.all(16.r),
                itemCount: list.length + 1,
                itemBuilder: (context, index) {
                  if (index >= list.length) {
                    if (controller.rewardTabLoadingMore[tabIndex].value) {
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

                    if (!controller.rewardTabHasMore[tabIndex].value) {
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

                  final Datum data = list[index];
                  return LoyaltyCard(
                    type: data.type == "earn" ? "plus" : "minus",
                    name: data.relatedOrderId?.store?.name,
                    address: data.relatedOrderId?.store?.address,
                    date: formatDate(data.relatedOrderId?.createdAt),
                    point: data.pointsChange?.toString() ?? "0",
                    image:
                        "${AppApiEndPoint.domain}${data.relatedOrderId?.store?.image}",
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.instance.rewardDetailsScreen,
                        arguments: {
                          "screen_name": "Reward Details",
                          "order_id": data.relatedOrderId?.id,
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
          appBar: CustomAppbar(
            showLeading: false,
            text: "Rewards & Loyalty Program",
          ),
          body: Column(
            spacing: 12.h,
            children: [
              Obx(() {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.yellow),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: Column(
                    spacing: 5.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        data: "Your Rewards",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      Row(
                        children: [
                          AppText(
                            data: "Total Points Available: ",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.deepBlue,
                          ),
                          AppText(
                            data:
                                "${controller.rewardPointModel.value?.data?.loyaltyPoints ?? 0}p",
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.deepBlue,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 8.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
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
                    Tab(text: "All"),
                    Tab(text: "Earned"),
                    Tab(text: "Used"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    buildRewardHistoryTab(tabIndex: 0),
                    buildRewardHistoryTab(tabIndex: 1),
                    buildRewardHistoryTab(tabIndex: 2),
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

class LoyaltyCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String? type;
  final String? point;
  final String? name;
  final String? address;
  final String? date;
  final String? image;
  const LoyaltyCard({
    super.key,
    this.onTap,
    this.type = "plus",
    this.point,
    this.name,
    this.address,
    this.date,
    this.image,
  });

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
        spacing: 10.w,
        children: [
          AppImageCircular(
            url:
                image ??
                "https://i.pinimg.com/736x/f0/4e/90/f04e90b671eccbde302107dc0a447135.jpg",
            width: 40.w,
            height: 40.h,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                AppText(
                  data: name ?? "",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                AppText(
                  data: address ?? "",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                AppText(
                  data: date ?? "",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          // Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8.h,
            children: [
              AppText(
                data: "${type == "plus" ? "+" : ""}${point ?? "0"}p",
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: type == "normal"
                    ? AppColors.black
                    : type == "plus"
                    ? AppColors.green
                    : AppColors.red,
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
    );
  }
}
