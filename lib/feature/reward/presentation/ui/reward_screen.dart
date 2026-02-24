import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        showLeading: false,
        text: "Rewards & Loyalty Program",
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          spacing: 12.h,
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
                        data: "100p",
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepBlue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
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
                  Tab(text: "All"),
                  Tab(text: "Earned"),
                  Tab(text: "Used"),
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
                      return LoyaltyCard(
                        onTap: () {
                          Get.toNamed(AppRoutes.instance.rewardDetailsScreen);
                        },
                      );
                    },
                  ),
                  // Add Money
                  ListView.builder(
                    padding: EdgeInsets.all(16.r),
                    itemBuilder: (context, index) {
                      return LoyaltyCard();
                    },
                  ),
                  // Spend
                  ListView.builder(
                    padding: EdgeInsets.all(16.r),
                    itemBuilder: (context, index) {
                      return LoyaltyCard();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoyaltyCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String? type;
  final String? price;
  const LoyaltyCard({super.key, this.onTap, this.type = "plus", this.price});

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
                "https://i.pinimg.com/736x/f0/4e/90/f04e90b671eccbde302107dc0a447135.jpg",
            width: 40.w,
            height: 40.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              AppText(
                data: "McDonald",
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
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8.h,
            children: [
              AppText(
                data: price ?? "+45p",
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
