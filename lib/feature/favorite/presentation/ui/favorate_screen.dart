import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/feature/favorite/domain/model/favorite_store_model.dart';
import 'package:coffie/feature/new_order/domain/model/store_model.dart'
    as store_model;
import 'package:coffie/feature/new_order/presentation/widget/product_card.dart';
import 'package:coffie/feature/profile/domain/entity/favorite_card_entity.dart';
import 'package:coffie/feature/favorite/presentation/controller/favorate_controller.dart';
import 'package:coffie/feature/profile/presentation/widget/favorite_card.dart';
import 'package:coffie/feature/reward/presentation/widget/loyelty_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
                              final favoriteStore =
                                  controller.favoriteStoreList[index];
                              final storeId = favoriteStore.store?.id ?? "";
                              final storeForNav = _storeDataModelFromFavorite(
                                favoriteStore,
                              );
                              return FavoriteCrad(
                                orderNow: () => Get.toNamed(
                                  AppRoutes.instance.shopOrderInformationScreen,
                                  arguments: storeForNav,
                                ),
                                viewHours: () {
                                  Get.toNamed(
                                    AppRoutes.instance.shopDetailsScreen,
                                    arguments: storeForNav,
                                  );
                                },

                                isFavorite: () {
                                  if (!controller.isGuest) {
                                    if (favoriteStore.isFavorite ?? false) {
                                      controller.removeFavorite(storeId);
                                    } else {
                                      controller.addStoreFavorite(storeId);
                                    }
                                  }
                                },
                                favoriteCardEntity: FavoriteCardEntity(
                                  image:
                                      "${AppApiEndPoint.domain}${favoriteStore.store?.image}",
                                  name: favoriteStore.store?.name ?? "",
                                  address: favoriteStore.store?.address ?? "",
                                  status: false,
                                  isFavorite: favoriteStore.isFavorite,
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

                        if (controller.favoriteProductList.isEmpty) {
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
                              final row = controller.favoriteProductList[index];
                              final product = row.product;
                              final productId = product?.id ?? "";
                              return ProductCard(
                                isFavorite: row.isFavorite ?? false,
                                isFavoriteTap: () {
                                  if (controller.isGuest || productId.isEmpty) {
                                    return;
                                  }
                                  if (row.isFavorite ?? false) {
                                    controller.removeProductFavorite(productId);
                                  } else {
                                    controller.addProductFavorite(productId);
                                  }
                                },
                                image:
                                    "${AppApiEndPoint.domain}${product?.image}",
                                name: product?.name ?? "",
                                readyTime: product?.readyTime ?? 0,
                                price: "\$${product?.basePrice}",

                                tags: product?.dietaryLabels ?? [],
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.instance.productInfoScreen,
                                    arguments: productId,
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

/// Maps favorite API row to [store_model.StoreDataModel] for screens that expect it (e.g. shop order flow).
store_model.StoreDataModel _storeDataModelFromFavorite(
  FavorireStoreDataModel f,
) {
  final s = f.store;
  return store_model.StoreDataModel(
    id: s?.id,
    name: s?.name,
    image: s?.image,
    address: s?.address,
    hours: (s?.hours ?? [])
        .map((h) => store_model.Hour(day: h.day, open: h.open, close: h.close))
        .toList(),
    isFavorite: f.isFavorite ?? true,
  );
}
