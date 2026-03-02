import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/feature/new_order/presentation/controller/shop_details_controller.dart';
import 'package:coffie/feature/new_order/presentation/widget/category_gride_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductInfoScreen extends StatelessWidget {
  const ProductInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopDetailsController>(
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(
            text: "Product Information",
            action: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border_rounded,
                  size: 24.w,
                  color: AppColors.yellow,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppImageCircular(
                  url:
                      "https://i.pinimg.com/1200x/de/82/43/de824313ab9a1ee67f25dbc73666abc6.jpg",
                  width: double.infinity,
                  height: 270.h,
                  borderRadius: 10.r,
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      data: "Americano",
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    AppText(
                      data: "45\$",
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                AppText(
                  data:
                      "Deep, dark roast with notes of molasses and dark chocolate.",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 16.h),
                AppText(
                  data: "Customize Item",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),

                SizedBox(height: 8.h),
                CategoryGridSelector(
                  items: ["Whole", "Oat", "Almond", "Soy"],
                  selectedItem: controller.itemCategory,
                  onTap: controller.selectItemCategory,
                ),
                SizedBox(height: 12.h),
                AppText(
                  data: "Customize Item",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.yellow),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        data: "Number of Syrup Pumps",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),

                      Obx(() {
                        final bool isEnabled =
                            controller.numberOfSyrupPumps.value > 0;
                        final bool maxEnabled =
                            controller.numberOfSyrupPumps.value < 10;
                        return Container(
                          width: 100.w,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors
                                .white, // shadow visible korar jonno background thaka better
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  0.2,
                                ), // light shadow
                                blurRadius: 8.r,
                                spreadRadius: 1.r,
                                offset: Offset(0, 2), // soft bottom depth
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              isEnabled
                                  ? InkWell(
                                      onTap: controller
                                          .decrementNumberOfSyrupPumps,
                                      child: Icon(
                                        Icons.remove_rounded,
                                        size: 20.w,
                                        color: AppColors.black,
                                      ),
                                    )
                                  : Icon(
                                      Icons.remove_rounded,
                                      size: 20.w,
                                      color: AppColors.black.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                              AppText(
                                data: controller.numberOfSyrupPumps.toString(),
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              maxEnabled
                                  ? InkWell(
                                      onTap: controller
                                          .incrementNumberOfSyrupPumps,
                                      child: Icon(
                                        Icons.add_rounded,
                                        size: 20.w,
                                        color: AppColors.black,
                                      ),
                                    )
                                  : Icon(
                                      Icons.add_rounded,
                                      size: 20.w,
                                      color: AppColors.black.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                spacing: 16.w,
                children: [
                  Expanded(
                    child: Container(
                      height: 50.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.yellow),
                      ),
                      child: Center(
                        child: AppText(
                          data: "Add To Cart",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: AppButton(
                      title: "Order Now",
                      onTap: () {
                        Get.toNamed(AppRoutes.instance.myCartScreen);
                      },
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
