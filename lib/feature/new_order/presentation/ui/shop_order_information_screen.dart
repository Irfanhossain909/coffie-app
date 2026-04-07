import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/gift_card/presentation/widget/category_selector.dart';
import 'package:coffie/feature/home/presentation/widget/gloss_shimmer.dart';
import 'package:coffie/feature/home/presentation/widget/last_order_card.dart';
import 'package:coffie/feature/new_order/presentation/controller/shop_order_information_controller.dart';
import 'package:coffie/feature/new_order/presentation/widget/product_card.dart';
import 'package:coffie/feature/new_order/presentation/widget/shop_details_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShopOrderInformationScreen extends StatelessWidget {
  const ShopOrderInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final store = Get.arguments;
    return Scaffold(
      appBar: CustomAppbar(text: "Shop Order Information"),
      body: GetBuilder<ShopOrderInformationController>(
        init: ShopOrderInformationController(),
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShowDetailsInfoCard(store: controller.store),
                  SizedBox(height: 16.h),

                  if (!controller.isGuest) ...[
                    SizedBox(height: 12.h),
                    AppText(
                      data: "Last Order",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 8.h),
                    Obx(() {
                      if (controller.lastOrder.value == null) {
                        return GlossShimmer(
                          height: 120.h,
                          width: double.infinity,
                          borderRadius: 12.r,
                        );
                      }
                      return LastOrderCard(
                        lastOrder: controller.lastOrder.value,
                      );
                    }),
                  ],

                  SizedBox(height: 16.h),
                  Obx(() {
                    if (controller.storeCategories.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return CategorySelector(
                      items: controller.storeCategories
                          .map((category) => category.name ?? '')
                          .toList(),
                      selectedItem: controller.itemCategory,
                      onTap: (categoryName) {
                        controller.selectItemCategory(categoryName);

                        final selectedCategory = controller.storeCategories
                            .firstWhere((cat) => cat.name == categoryName);
                        controller.getStoreProductById(
                          categoryId: selectedCategory.id,
                        );
                      },
                    );
                  }),
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
                  Obx(() {
                    if (controller.storeProducts.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: Center(
                          child: AppText(data: "No products found"),
                        ),
                      );
                    }
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.storeProducts.length,
                      // itemCount: controller.storeProducts.length,
                      itemBuilder: (context, index) {
                        final product = controller.storeProducts[index];
                        return ProductCard(
                          image: "${AppApiEndPoint.domain}${product.image}",
                          name: product.name ?? "",
                          readyTime: product.readyTime ?? 0,
                          price: "\$${product.basePrice}",

                          tags: product.dietaryLabels ?? [],
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.instance.productInfoScreen,
                              arguments: product.id,
                            );
                          },
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
