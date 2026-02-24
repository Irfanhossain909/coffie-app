import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GiftCardScreen extends StatelessWidget {
  const GiftCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CustomAppbar(showLeading: false, text: "My Gift Card"),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
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
                        data: "2",
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
                        data: r"$50.00",
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepBlue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
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
                  Tab(text: "Available"),
                  Tab(text: "Sent"),
                  Tab(text: "Redeemed"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // All
                  ListView.builder(
                    padding: EdgeInsets.all(16.r),
                    itemBuilder: (context, index) {
                      return GiftCard();
                    },
                  ),
                  // Add Money
                  ListView.builder(
                    padding: EdgeInsets.all(16.r),
                    itemBuilder: (context, index) {
                      return GiftCard(lastColumType: "Sent");
                    },
                  ),
                  // Spend
                  ListView.builder(
                    padding: EdgeInsets.all(16.r),
                    itemBuilder: (context, index) {
                      return GiftCard(lastColumType: "Redeemed");
                    },
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
      ),
    );
  }
}

class GiftCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String lastColumType;
  const GiftCard({this.onTap, super.key, this.lastColumType = "Available"});

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              AppText(
                data: "Mr. Sabbir",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              AppText(
                data: "New Work",
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              AppText(
                data: "May 15, 2026",
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          Spacer(),
          if (lastColumType == "Available")
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 8.h,
              children: [
                AppText(
                  data: r"$20.00",
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
                  data: r"$20.00",
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
                  data: r"-$20.00",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.red,
                ),
                AppText(
                  data: r"Remaining: $9.49",
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
