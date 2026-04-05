import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/utils/formet_date.dart';
import 'package:coffie/feature/gift_card/domain/model/gift_card_model.dart';
import 'package:coffie/feature/gift_card/presentation/controller/gift_card_controller.dart';
import 'package:coffie/feature/gift_card/presentation/widget/gift_card_shimmer.dart';
import 'package:coffie/feature/home/presentation/widget/gloss_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GiftCardScreen extends StatelessWidget {
  const GiftCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GiftCardController>(
      init: GiftCardController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(showLeading: false, text: "My Gift Card"),
          body: Column(
            children: [
              Obx(() {
                if (controller.isLoading.value) {
                  return GlossShimmer(
                    height: 100.h,
                    width: double.infinity,
                    borderRadius: 12.r,
                  );
                }
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
                        data: "Your Gift Card",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      Row(
                        children: [
                          AppText(
                            data: "Total Gift Card Available: ",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.deepBlue,
                          ),
                          AppText(
                            data:
                                controller
                                    .giftCardBalanceModel
                                    .value
                                    ?.data
                                    ?.totalGiftCards
                                    .toString() ??
                                "0",
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.deepBlue,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AppText(
                            data: "Total Amount: ",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.deepBlue,
                          ),
                          AppText(
                            data:
                                "\$${controller.giftCardBalanceModel.value?.data?.totalBalance.toString() ?? "0"}",
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
              SizedBox(height: 16.h),
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
                    Tab(text: "Available"),
                    Tab(text: "Sent"),
                    Tab(text: "Redeemed"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    // All
                    RefreshIndicator(
                      onRefresh: () async {
                        controller.getGiftCardTransactions(giftCardEndPoint: "available");
                      },
                      child: Obx(() {
                        if (controller.isLoadingGiftCardTransactions.value) {
                          return GiftCardShimmer();
                        }
                        if (controller.giftCardTransactions.isEmpty) {
                          return Center(
                            child: AppText(
                              data: "No data found",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }
                        return ListView.builder(
                          padding: EdgeInsets.all(16.r),
                          itemCount: controller.giftCardTransactions.length,
                          itemBuilder: (context, index) {
                            final giftCard =
                                controller.giftCardTransactions[index];
                            return GiftCard(giftCardDataModel: giftCard);
                          },
                        );
                      }),
                    ),
                    // Add Money
                    RefreshIndicator(
                      onRefresh: () async {
                        controller.getGiftCardTransactions(giftCardEndPoint: "sent");
                      },
                      child: Obx(() {
                        if (controller.isLoadingGiftCardTransactions.value) {
                          return GiftCardShimmer();
                        }
                        if (controller.giftCardTransactions.isEmpty) {
                          return Center(
                            child: AppText(
                              data: "No data found",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }
                        return ListView.builder(
                          padding: EdgeInsets.all(16.r),
                          itemCount: controller.giftCardTransactions.length,
                          itemBuilder: (context, index) {
                            final giftCard =
                                controller.giftCardTransactions[index];
                            return GiftCard(
                              lastColumType: "Sent",
                              giftCardDataModel: giftCard,
                            );
                          },
                        );
                      }),
                    ),
                    // Spend
                    RefreshIndicator(
                      onRefresh: () async {
                        controller.getGiftCardRedeem();
                      },
                      child: Obx(() {
                        if (controller.isLoadingGiftCardTransactions.value) {
                          return GiftCardShimmer();
                        }
                        if (controller.giftCardTransactions.isEmpty) {
                          return Center(
                            child: AppText(
                              data: "No data found",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }
                        return ListView.builder(
                          padding: EdgeInsets.all(16.r),
                          itemCount: controller.giftCardRedeem.length,
                          itemBuilder: (context, index) {
                            final giftCard = controller.giftCardRedeem[index];
                            return GiftCard(
                              lastColumType: "Redeemed",
                              remainingBalance: giftCard.balanceAfter ?? 0,
                              giftCardDataModel: GiftCardDataModel(
                                receiverName:
                                    giftCard.giftCard?.receiverName ?? "",
                                receiverEmail:
                                    giftCard.giftCard?.receiverEmail ?? "",
                                amount: giftCard.giftCard?.amount ?? 0,
                                createdAt:
                                    giftCard.giftCard?.createdAt ??
                                    DateTime.now(),
                                status: giftCard.giftCard?.status ?? "",
                                id: giftCard.giftCard?.id ?? "",
                                cardNumber: giftCard.giftCard?.cardNumber ?? "",
                                currentBalance:
                                    giftCard.giftCard?.currentBalance ?? 0,
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 10.h,
                children: [
                  AppButton(
                    title: "Purchase Gift Card",
                    onTap: () {
                      Get.toNamed(AppRoutes.instance.percheseGiftCardScreen);
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.instance.addExistingGiftCardScreen);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: AppColors.yellow),
                      ),
                      child: Center(
                        child: AppText(
                          data: "Add Existing Gift Card",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class GiftCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String lastColumType;
  final double? remainingBalance;
  final GiftCardDataModel? giftCardDataModel;
  const GiftCard({
    this.onTap,
    super.key,
    this.lastColumType = "Available",
    this.giftCardDataModel,
    this.remainingBalance,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10.w,
        children: [
          AppImageCircular(
            borderRadius: 8.r,
            url:
                "https://i.pinimg.com/736x/e8/54/2a/e8542ae944bdd95cf02c47d68b1c6f89.jpg",
            width: 80.w,
            height: 29.h,
            fit: BoxFit.cover,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                AppText(
                  data: giftCardDataModel?.receiverName ?? "",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                AppText(
                  data: giftCardDataModel?.receiverEmail ?? "",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                AppText(
                  data: formatDate(giftCardDataModel?.createdAt),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          if (lastColumType == "Available")
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 8.h,
              children: [
                AppText(
                  data: "\$${giftCardDataModel?.amount?.toString() ?? "0"}",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blue,
                ),
                AppText(
                  data: "Received",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
                InkWell(
                  onTap: () {},
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
                      data: "Redeem",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          if (lastColumType == "Sent")
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 16.h,
              children: [
                AppText(
                  data: "\$${giftCardDataModel?.amount?.toString() ?? "0"}",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blue,
                ),

                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: AppText(
                      data: "Delivered",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          if (lastColumType == "Redeemed")
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 8.h,
              children: [
                AppText(
                  data: "\$ -${giftCardDataModel?.amount?.toString() ?? "0"}",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.red,
                ),
                AppText(
                  data: "Remaining: \$${remainingBalance?.toString() ?? "0"}",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
