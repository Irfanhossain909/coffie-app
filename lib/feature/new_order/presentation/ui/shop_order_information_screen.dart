import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/feature/gift_card/presentation/widget/category_selector.dart';
import 'package:coffie/feature/new_order/presentation/controller/shop_details_controller.dart';
import 'package:coffie/feature/new_order/presentation/widget/shop_details_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShopOrderInformationScreen extends StatelessWidget {
  const ShopOrderInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: "Shop Order Information"),
      body: GetBuilder<ShopDetailsController>(
        init: ShopDetailsController(),
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShowDetailsInfoCard(),
                  SizedBox(height: 16.h),
                  AppText(
                    data: "Last Order",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 8.h),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    data: "Americano",
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  AppText(
                                    data: "45\$",
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ],
                              ),

                              AppText(
                                data: "Pickup Time: Ready in 6 mins",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(height: 24.h),
                              InkWell(
                                onTap: () {},
                                child: Align(
                                  alignment: Alignment.centerRight,
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),
                  CategorySelector(
                    items: const [
                      "Coffee & Drinks",
                      "Sandwiches",
                      "Iced Drinks",
                      "Bakery",
                      "Hot Drinks",
                      "Hot Food",
                      "Cold Food",
                      "Desserts",
                      "Snacks",
                      "Other",
                    ],
                    selectedItem: controller.selectedCategory,
                    onTap: controller.selectCategory,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        data: "Available Items",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      Icon(
                        Icons.density_medium_rounded,
                        size: 16.w,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.instance.productInfoScreen);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: AppColors.yellow),
                          ),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// 🔹 Image
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
                        
                              SizedBox(width: 10.w),
                        
                              /// 🔹 Right Content
                              Expanded(
                                child: SizedBox(
                                  height: 93.h, // 👈 image height er shoman
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      /// 🔸 Title + Favorite
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AppText(
                                            data: "Americano",
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          Icon(
                                            Icons.favorite_border_rounded,
                                            size: 24.w,
                                            color: AppColors.yellow,
                                          ),
                                        ],
                                      ),
                        
                                      SizedBox(height: 4.h),
                        
                                      /// 🔸 Description
                                      AppText(
                                        data: "Pickup Time: Ready in 6 mins",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                        
                                      /// 🔥 Push price to bottom
                                      const Spacer(),
                        
                                      /// 🔸 Price (bottom right)
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6.w,
                                              vertical: 2.h,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors.yellow,
                                              ),
                                              borderRadius: BorderRadius.circular(
                                                10.r,
                                              ),
                                            ),
                                            child: AppText(
                                              data: "VEGAN",
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6.w,
                                              vertical: 2.h,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors.yellow,
                                              ),
                                              borderRadius: BorderRadius.circular(
                                                10.r,
                                              ),
                                            ),
                                            child: AppText(
                                              data: "DAIRY FREE",
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          Spacer(),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: AppText(
                                              data: "45\$",
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
