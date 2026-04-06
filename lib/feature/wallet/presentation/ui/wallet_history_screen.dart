import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/utils/formet_date.dart';
import 'package:coffie/feature/reward/presentation/widget/reward_details_shimmer.dart';
import 'package:coffie/feature/wallet/presentation/controller/wallet_history_controller.dart';
import 'package:coffie/feature/wallet/presentation/ui/my_wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WalletHistoryScreen extends StatelessWidget {
  const WalletHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletHistoryController>(
      init: WalletHistoryController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(text: "Wallet History"),
          body: Padding(
            padding: EdgeInsets.all(16.r),
            child: controller.isLoading.value
                ? RewardDetailsShimmer()
                : Column(
                    spacing: 16.h,
                    children: [
                      WalletCard(
                        name: controller.walletDetailsModel.value?.data?.title,
                        date: formatDate(
                          controller.walletDetailsModel.value?.data?.createdAt,
                        ),
                        status:
                            controller.walletDetailsModel.value?.data?.status,
                        type: controller.walletDetailsModel.value?.data?.type,
                        price: controller.walletDetailsModel.value?.data?.amount
                            .toString(),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.r),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.yellow),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          spacing: 8.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              data: "Transaction Details",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                            SizedBox(height: 2.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  data: "Transaction ID",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black,
                                ),
                                AppText(
                                  data:
                                      controller
                                          .walletDetailsModel
                                          .value
                                          ?.data
                                          ?.id ??
                                      "",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     AppText(
                            //       data: "Location",
                            //       fontSize: 12.sp,
                            //       fontWeight: FontWeight.w400,
                            //       color: AppColors.black,
                            //     ),
                            //     // AppText(
                            //     //   data: controller.walletDetailsModel.value?.data?.relatedOrder?.a ?? "",
                            //     //   fontSize: 12.sp,
                            //     //   fontWeight: FontWeight.w400,
                            //     //   color: AppColors.black,
                            //     // ),
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  data: "Previous Balance",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black,
                                ),
                                AppText(
                                  data:
                                      controller
                                          .walletDetailsModel
                                          .value
                                          ?.data
                                          ?.previousBalance
                                          ?.toString() ??
                                      "",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  data: "Order Price",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black,
                                ),
                                AppText(
                                  data:
                                      "\$${controller.walletDetailsModel.value?.data?.amount?.toString() ?? ""}",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  data: "New Balance",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black,
                                ),
                                AppText(
                                  data:
                                      "\$${controller.walletDetailsModel.value?.data?.balanceAfter?.toString() ?? ""}",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
