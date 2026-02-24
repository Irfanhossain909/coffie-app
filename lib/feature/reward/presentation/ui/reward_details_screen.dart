import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RewardDetailsScreen extends StatelessWidget {
  const RewardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenName = Get.arguments["screen_name"];
    return Scaffold(
      appBar: CustomAppbar(text: screenName),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          spacing: 16.h,
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
                          "https://i.pinimg.com/736x/f0/4e/90/f04e90b671eccbde302107dc0a447135.jpg",
                      width: 99.w,
                      height: 93.h,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4.h,
                      children: [
                        AppText(
                          data: "Americano",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        AppText(
                          data: "New Work | 2.6 km",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        AppText(
                          data: "Pickup Time: Ready in 6 mins",
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 8.h,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 22.w,
                        color: AppColors.yellow,
                      ),
                      AppText(
                        data: "+45p",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
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
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: AppText(
                            data: "Order Completed",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
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
                        data: "#10234",
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
                      AppText(
                        data: "Sonargaon Road • 2.6 km",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
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
                        data: r"+$10.99",
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
                        data: r"+$5.00",
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
                        data: r"+45p",
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
                        data: r"$5.99",
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
                        data: "Wallet",
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
                        data: "Pending",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        data: "Americano ×1",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      AppText(
                        data: r"$3.00",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        data: "Croissant ×1",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      AppText(
                        data: r"$1.50",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
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
                        data: r"$5.99",
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
              Get.toNamed(AppRoutes.instance.receiptScreen);
            },
          ),
        ),
      ),
    );
  }
}
