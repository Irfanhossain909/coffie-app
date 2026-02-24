import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_assets.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: "My Wallet"),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.yellow),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
                          data: "\$25.99",
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
                  children: [
                    // All
                    ListView.builder(
                      padding: EdgeInsets.all(6.r),
                      itemBuilder: (context, index) {
                        return WalletCard(
                          onTap: () {
                            Get.toNamed(AppRoutes.instance.walletHistoryScreen);
                          },
                        );
                      },
                    ),
                    // Add Money
                    ListView.builder(
                      padding: EdgeInsets.all(6.r),
                      itemBuilder: (context, index) {
                        return WalletCard();
                      },
                    ),
                    // Spend
                    ListView.builder(
                      padding: EdgeInsets.all(6.r),
                      itemBuilder: (context, index) {
                        return WalletCard();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WalletCard extends StatelessWidget {
  final void Function()? onTap;
  final String? type; // plus, minus, normal
  final String? price;
  const WalletCard({super.key, this.onTap, this.type = "minus", this.price});

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
              children: [
                AppText(
                  data: "Americano",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                AppText(
                  data: "May 15, 2026 • 9:41 AM",
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
                    data: "Success",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                AppText(
                  data: price ?? r"-$20.00",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: type == "normal"
                      ? AppColors.black
                      : type == "plus"
                      ? AppColors.green
                      : AppColors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
