import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(showLeading: false, text: "My Order"),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16.r),
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
                  Tab(text: "Upcoming"),
                  Tab(text: "Completed"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Add Money
                  ListView.builder(
                    padding: EdgeInsets.all(16.r),
                    itemBuilder: (context, index) {
                      return OrderCard(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.instance.rewardDetailsScreen,
                            arguments: {"screen_name": "Order Details"},
                          );
                        },
                      );
                    },
                  ),
                  // Spend
                  ListView.builder(
                    padding: EdgeInsets.all(16.r),
                    itemBuilder: (context, index) {
                      return OrderCard(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.instance.rewardDetailsScreen,
                            arguments: {"screen_name": "Order Details"},
                          );
                        },
                      );
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

class OrderCard extends StatelessWidget {
  final VoidCallback? onTap;
  const OrderCard({super.key, this.onTap});

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
              url:
                  "https://i.pinimg.com/736x/f0/4e/90/f04e90b671eccbde302107dc0a447135.jpg",
              width: 99.w,
              height: 93.h,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              AppText(
                data: "Order #10234 . 3 items",
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
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
              AppText(
                data: r"$5.99",
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 4.h,
            children: [
              Icon(Icons.favorite_border, size: 22.sp, color: AppColors.yellow),
              AppText(
                data: "Pending",
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
