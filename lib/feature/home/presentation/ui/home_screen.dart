import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_assets.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/feature/home/presentation/controller/home_controller.dart';
import 'package:coffie/feature/home/presentation/widget/auto_carosel_slider.dart';
import 'package:coffie/feature/home/presentation/widget/last_order_card.dart';
import 'package:coffie/feature/home/presentation/widget/wallet_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 4.w,
                  children: [
                    AppText(
                      data: "Hi",
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    AppText(
                      data: "COFFECITO",
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightBlue,
                    ),
                  ],
                ),
                AppText(
                  data: "What would you like to order today?",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            actionsPadding: EdgeInsets.only(right: 16.w),
            actions: [
              WalletContainer(amount: 320.50),
              SizedBox(width: 8.w),
              InkWell(
                onTap: () => Get.toNamed(AppRoutes.instance.myCartScreen),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColors.blue,
                ),
              ),

              SizedBox(width: 8.w),
              InkWell(
                onTap: () => Get.toNamed(AppRoutes.instance.notificationScreen),
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: AppColors.blue,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return AutoCarouselSlider(
                      imageList: controller.homeSliderList
                          .map(
                            (slider) =>
                                "${AppApiEndPoint.domain}${slider.image}",
                          )
                          .toList(),
                    );
                  }),
                  SizedBox(height: 12.h),
                  AppButton(
                    title: "Start Your Order",
                    onTap: () =>
                        Get.toNamed(AppRoutes.instance.pickupLocationScreen),
                  ),
                  SizedBox(height: 12.h),
                  AppText(
                    data: "Last Order",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 8.h),
                  LastOrderCard(),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.only(top: 16.h, left: 16.w),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.yellow),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          data: "Your Rewards",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        AppText(
                          data: "Total Points Available: 0p",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.deepBlue,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: SvgPicture.asset(
                            AppAssets.rewardPoint,
                            width: 180.w,
                            height: 120.h,
                          ),
                        ),
                      ],
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
