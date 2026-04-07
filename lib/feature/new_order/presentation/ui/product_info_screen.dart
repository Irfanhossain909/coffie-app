import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/feature/new_order/presentation/controller/product_info_controller.dart';
import 'package:coffie/feature/new_order/presentation/widget/category_gride_selector.dart';
import 'package:coffie/feature/new_order/presentation/widget/quantity_selecter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductInfoScreen extends StatelessWidget {
  const ProductInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductInfoController>(
      init: ProductInfoController(),
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return SizedBox(
                      width: double.infinity,
                      child: AppImageCircular(
                        url:
                            "${AppApiEndPoint.domain}${controller.singleProduct.value?.data?.image}",
                        fit: BoxFit.cover,
                        height: 270.h,
                        borderRadius: 10.r,
                      ),
                    );
                  }),
                  SizedBox(height: 12.h),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          data:
                              controller.singleProduct.value?.data?.name ?? "",
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        AppText(
                          data:
                              "${controller.singleProduct.value?.data?.basePrice ?? 0}\$",
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    );
                  }),
                  Obx(() {
                    return AppText(
                      data:
                          controller.singleProduct.value?.data?.description ??
                          "",
                      fontSize: 12.sp,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w400,
                    );
                  }),
                  SizedBox(height: 16.h),

                  Obx(() {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount:
                          controller
                              .singleProduct
                              .value
                              ?.data
                              ?.customizations
                              ?.length ??
                          0,
                      itemBuilder: (context, index) {
                        final customization = controller
                            .singleProduct
                            .value
                            ?.data
                            ?.customizations?[index];

                        if (customization == null) return const SizedBox();

                        switch (customization.type) {
                          case "single":
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CategoryGridSelector(
                                  title: "Select ${customization.name}",
                                  items: List<String>.from(
                                    customization.options
                                            ?.map((e) => e.label ?? '')
                                            .toList() ??
                                        [],
                                  ),
                                  selectedItem: controller.itemCategory,
                                  onTap: controller.selectItemCategory,
                                ),
                                SizedBox(height: 12.h),
                              ],
                            );

                          // case "multi":
                          //   return Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       MultiCategoryGridSelector(
                          //         title: customization.title ?? '',
                          //         items: List<String>.from(
                          //           customization.items ?? [],
                          //         ),
                          //         selectedItems: controller.selectedCategories,
                          //         onChanged: (list) {
                          //           controller.selectedCategories.value = list;
                          //         },
                          //       ),
                          //       SizedBox(height: 12.h),
                          //     ],
                          //   );

                          case "quantity":
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                QuantitySelector(
                                  title: "Select ${customization.name}",
                                  message: "Number of Syrup Pumps",
                                  quantity: controller.syrupPumps,
                                  max: 10,
                                  onChanged: (value) {
                                    controller.syrupPumps.value = value;
                                  },
                                ),
                                SizedBox(height: 12.h),
                              ],
                            );

                          default:
                            return const SizedBox();
                        }
                      },
                    );
                  }),

                  // CategoryGridSelector(
                  //   title: 'Customize Item',
                  //   items: ["Whole", "Oat", "Almond", "Soy"],
                  //   selectedItem: controller.itemCategory,
                  //   onTap: controller.selectItemCategory,
                  // ),
                  // SizedBox(height: 12.h),

                  // MultiCategoryGridSelector(
                  //   items: ["Coffee", "Tea", "Drinks", "Snacks"],
                  //   selectedItems: controller.selectedCategories,
                  //   onChanged: (list) {
                  //     print(list); // 👈 selected items list
                  //   },
                  //   title: 'Categories List',
                  // ),
                  // SizedBox(height: 12.h),
                  // QuantitySelector(
                  //   title: "Customize Item",
                  //   message: "Number of Syrup Pumps",
                  //   quantity: controller.syrupPumps,
                  //   max: 10,
                  //   onChanged: (value) {
                  //     print(value); // 👈 updated quantity
                  //   },
                  // ),
                ],
              ),
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
