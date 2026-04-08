import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_assets.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/utils/formet_date.dart';
import 'package:coffie/feature/reward/presentation/widget/loyelty_card_shimmer.dart';
import 'package:coffie/feature/wallet/presentation/controller/my_wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyWalletController>(
      // init: MyWalletController(),
      builder: (controller) {
        Widget buildWalletHistoryTab({required String? type}) {
          return Obx(() {
            final isInitialLoading = controller.isLoadingWalletCardList.value &&
                controller.walletCardList.isEmpty;

            if (isInitialLoading) {
              return ListView.builder(
                padding: EdgeInsets.all(16.r),
                itemCount: 6,
                itemBuilder: (_, __) => const LoyaltyCardShimmer(),
              );
            }

            if (controller.walletCardList.isEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  await controller.reloadWalletCardList(type: type);
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
                await controller.reloadWalletCardList(type: type);
              },
              child: ListView.builder(
                controller: controller.scrollController,
                padding: EdgeInsets.all(6.r),
                itemCount: controller.walletCardList.length + 1,
                itemBuilder: (context, index) {
                  if (index >= controller.walletCardList.length) {
                    if (controller.isLoadingMoreWalletCardList.value) {
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

                    if (!controller.hasMoreWalletCardList.value) {
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

                  final data = controller.walletCardList[index];
                  return WalletCard(
                    type: data.type,
                    name: data.title,
                    date: formatDate(data.createdAt),
                    status: data.status,
                    price: data.amount.toString(),
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.instance.walletHistoryScreen,
                        arguments: data.id,
                      );
                    },
                  );
                },
              ),
            );
          });
        }

        return Scaffold(
          appBar: CustomAppbar(text: "My Wallet"),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return Container(
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
                          data: "Your Wallet",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        Row(
                          children: [
                            AppText(
                              data: "Total Amount Available:",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            AppText(
                              data:
                                  "\$${controller.walletBalanceModel.value?.data?.balance.toString() ?? 0}",
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: 16.h),
                AppText(
                  data: "Wallet History",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 8.h),
                Container(
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
                      Tab(text: "Add Money"),
                      Tab(text: "Spend"),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      // All
                      buildWalletHistoryTab(type: null),
                      // Add Money
                      buildWalletHistoryTab(type: "deposit"),
                      // Spend
                      buildWalletHistoryTab(type: "spend"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.h),
              child: AppButton(
                title: "Add Money",
                onTap: () {
                  Get.toNamed(AppRoutes.instance.walletAddScreen);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class WalletCard extends StatelessWidget {
  final void Function()? onTap;
  final String? type; // plus, minus, normal
  final String? price;
  final String? name;
  final String? date;
  final String? status;
  const WalletCard({
    super.key,
    this.onTap,
    this.type = "minus",
    this.price,
    this.name,
    this.date,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.yellow),
        ),
        width: double.infinity,
        height: 100.h,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(AppAssets.branding, width: 100.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  data: name ?? "Americano",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                AppText(
                  data: date ?? "May 15, 2026 • 9:41 AM",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: AppText(
                    data: status ?? "Success",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                AppText(
                  data: "${type == "deposit" ? "+" : "-"}\$${price ?? "20.00"}",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: type == "deposit" ? AppColors.green : AppColors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
