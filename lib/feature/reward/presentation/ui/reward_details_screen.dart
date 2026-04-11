import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/feature/reward/presentation/controller/reward_details_controller.dart';
import 'package:coffie/feature/reward/presentation/widget/reward_details_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RewardDetailsScreen extends StatelessWidget {
  const RewardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RewardDetailsController>(
      init: RewardDetailsController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(text: controller.screenName ?? ""),
          body: Padding(
            padding: EdgeInsets.all(16.r),
            child: controller.isLoading.value
                ? RewardDetailsShimmer()
                : Column(
                    spacing: 16.h,
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: AppColors.yellow),
                            ),
                            width: double.infinity,

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 10.w,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(color: AppColors.yellow),
                                  ),
                                  child: AppImageCircular(
                                    borderRadius: 8.r,
                                    url:
                                        "${AppApiEndPoint.domain}${controller.rewardCardDetailsModel.value?.data?.store?.image}",
                                    width: 99.w,
                                    height: 93.h,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 4.h,
                                    children: [
                                      AppText(
                                        data:
                                            controller
                                                .rewardCardDetailsModel
                                                .value
                                                ?.data
                                                ?.store
                                                ?.name ??
                                            "",
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      AppText(
                                        data:
                                            "${controller.rewardCardDetailsModel.value?.data?.store?.address} || ${controller.rewardCardDetailsModel.value?.data?.store?.distanceKm ?? 0} km",
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      AppText(
                                        data:
                                            "Pickup Time: Ready in ${controller.rewardCardDetailsModel.value?.data?.readyTime ?? 0} mins",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  spacing: 8.h,
                                  children: [
                                    // Icon(
                                    //   Icons.favorite_border,
                                    //   size: 22.w,
                                    //   color: AppColors.yellow,
                                    // ),
                                    AppText(
                                      data:
                                          "${controller.rewardCardDetailsModel.value?.data?.pointsEarned ?? 0}p",
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Positioned(
                            bottom: 12,
                            right: 12,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    controller
                                            .rewardCardDetailsModel
                                            .value
                                            ?.data
                                            ?.orderStatus ==
                                        "completed"
                                    ? AppColors.green
                                    : AppColors.yellow,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: AppText(
                                data:
                                    controller
                                            .rewardCardDetailsModel
                                            .value
                                            ?.data
                                            ?.orderStatus ==
                                        "completed"
                                    ? "Order Completed"
                                    : "Order Pending",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      //
                      Container(
                        padding: EdgeInsets.all(12.r),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.yellow),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10.h,
                          children: [
                            AppText(
                              data: "Order Information",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  data: "Order ID",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                AppText(
                                  data:
                                      "#${controller.rewardCardDetailsModel.value?.data?.orderId ?? ""}",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  data: "Location",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                SizedBox(
                                  width: 250.w,
                                  child: AppText(
                                    data:
                                        "${controller.rewardCardDetailsModel.value?.data?.store?.address} • ${controller.rewardCardDetailsModel.value?.data?.store?.distanceKm ?? 0} km",
                                    fontSize: 12.sp,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  data: "Total Product Price",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                AppText(
                                  data:
                                      "+\$${controller.rewardCardDetailsModel.value?.data?.subtotal ?? 0}",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  data: "Tip",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                AppText(
                                  data:
                                      "+\$${controller.rewardCardDetailsModel.value?.data?.tipAmount ?? 0}",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  data: "Rewards & Loyalty",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                AppText(
                                  data:
                                      "+${controller.rewardCardDetailsModel.value?.data?.pointsEarned ?? 0}p",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            Divider(color: AppColors.yellow, height: 1.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  data: "Total Amount",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                AppText(
                                  data:
                                      "\$${controller.rewardCardDetailsModel.value?.data?.totalAmount ?? 0}",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  data: "Payment By",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                AppText(
                                  data:
                                      controller
                                          .rewardCardDetailsModel
                                          .value
                                          ?.data
                                          ?.paymentMethod ??
                                      "",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  data: "Status",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                AppText(
                                  data:
                                      controller
                                              .rewardCardDetailsModel
                                              .value
                                              ?.data
                                              ?.orderStatus ==
                                          "completed"
                                      ? "Completed"
                                      : "Pending",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12.r),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.yellow),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10.h,
                          children: [
                            AppText(
                              data: "Items Purchased",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            if (controller
                                    .rewardCardDetailsModel
                                    .value
                                    ?.data
                                    ?.items
                                    ?.isNotEmpty ??
                                false)
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller
                                    .rewardCardDetailsModel
                                    .value
                                    ?.data
                                    ?.items
                                    ?.length,
                                itemBuilder: (context, index) {
                                  final data = controller
                                      .rewardCardDetailsModel
                                      .value
                                      ?.data
                                      ?.items?[index];
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        data:
                                            "${data?.productName} ×${data?.quantity}",
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      AppText(
                                        data: "\$${data?.totalPrice ?? 0}",
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            Divider(color: AppColors.black, height: 1.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  data: "Total Amount",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                AppText(
                                  data:
                                      "\$${controller.rewardCardDetailsModel.value?.data?.totalAmount ?? 0}",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: AppButton(
                title: "View Receipt",
                onTap: () {
                  Get.toNamed(
                    AppRoutes.instance.receiptScreen,
                    arguments: controller.rewardCardDetailsModel.value?.data,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
