import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/feature/new_order/presentation/widget/product_card.dart';
import 'package:coffie/feature/profile/domain/entity/favorite_card_entity.dart';
import 'package:coffie/feature/favorite/presentation/controller/favorate_controller.dart';
import 'package:coffie/feature/profile/presentation/widget/favorite_card.dart';
import 'package:coffie/feature/profile/presentation/widget/favorite_item.dart';
import 'package:coffie/feature/reward/presentation/widget/loyelty_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class FavorateScreen extends StatelessWidget {
  const FavorateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavorateController>(
      init: FavorateController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(text: 'My Favorite'),
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200, // background color
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: TabBar(
                      controller: controller.tabController,
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        color: Color(0xFF1E4DB7), // blue selected color
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black87,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                      tabs: const [
                        Tab(text: "Shop"),
                        Tab(text: "Item"),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      /// 🔹 Shop Content
                      Obx(() {
                        if (controller.isLoading.value) {
                          return ListView.builder(
                            padding: EdgeInsets.all(16.r),
                            itemCount: 6,
                            itemBuilder: (_, __) => const LoyaltyCardShimmer(),
                          );
                        }

                        if (controller.favoriteStoreList.isEmpty) {
                          return Center(
                            child: AppText(
                              data: "No favorite store found",
                              fontSize: 16.sp,
                              color: Colors.grey,
                            ),
                          );
                        }
                        return RefreshIndicator(
                          onRefresh: () async {
                            await controller.getFavoriteStoreList();
                          },
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            itemCount: controller.favoriteStoreList.length,
                            itemBuilder: (context, index) {
                              final favoriteCardEntity =
                                  favoriteCardEntityList[index];
                              return FavoriteCrad(
                                orderNow: () => Get.toNamed(
                                  AppRoutes.instance.shopOrderInformationScreen,
                                  arguments: favoriteCardEntity,
                                ),
                                viewHours: () {
                                  Get.toNamed(
                                    AppRoutes.instance.shopDetailsScreen,
                                    arguments: favoriteCardEntity,
                                  );
                                },

                                isFavorite: () {},
                                favoriteCardEntity: FavoriteCardEntity(
                                  image:
                                      "${AppApiEndPoint.domain}${favoriteCardEntity.image}",
                                  name: favoriteCardEntity.name ?? "",
                                  address: favoriteCardEntity.address ?? "",
                                  status: favoriteCardEntity.status,
                                  isFavorite: favoriteCardEntity.isFavorite,
                                ),
                              );
                            },
                          ),
                        );
                      }),

                      /// 🔹 Item Content
                      Obx(() {
                        if (controller.isLoading.value) {
                          return ListView.builder(
                            padding: EdgeInsets.all(16.r),
                            itemCount: 6,
                            itemBuilder: (_, __) => const LoyaltyCardShimmer(),
                          );
                        }

                        if (controller.favoriteStoreList.isEmpty) {
                          return Center(
                            child: AppText(
                              data: "No favorite product found",
                              fontSize: 16.sp,
                              color: Colors.grey,
                            ),
                          );
                        }
                        return RefreshIndicator(
                          onRefresh: () async {
                            await controller.getFavoriteProductList();
                          },
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            itemCount: controller.favoriteProductList.length,
                            itemBuilder: (context, index) {
                              final product =
                                  controller.favoriteProductList[index];
                              return ProductCard(
                                image:
                                    "${AppApiEndPoint.domain}${product.product?.image}",
                                name: product.product?.name ?? "",
                                readyTime: product.product?.readyTime ?? 0,
                                price: "\$${product.product?.basePrice}",

                                tags: product.product?.dietaryLabels ?? [],
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.instance.productInfoScreen,
                                  );
                                },
                              );
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
