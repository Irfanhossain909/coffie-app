import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/feature/new_order/presentation/controller/pickup_location_controller.dart';
import 'package:coffie/feature/new_order/presentation/widget/home_map_preview.dart';
import 'package:coffie/feature/profile/domain/entity/favorite_card_entity.dart';
import 'package:coffie/feature/profile/presentation/widget/favorite_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PickupLocationScreen extends StatelessWidget {
  const PickupLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PickupLocationWithGetShopController>(
      init: PickupLocationWithGetShopController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(text: "Choose Pickup Location"),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              spacing: 16.h,
              children: [
                AppInputWidgetTwo(
                  hintText: "Search Location",
                  prefix: Icon(
                    Icons.search,
                    size: 20.w,
                    color: AppColors.black,
                  ),
                  borderColor: AppColors.yellow,
                  suffixIcon: Container(
                    margin: EdgeInsets.only(right: 8.w),
                    padding: EdgeInsets.all(7.w),
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.send, size: 18.w, color: Colors.white),
                  ),
                ),
                Obx(() {
                  if (controller.storeLocationList.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return SizedBox(
                    height: 180.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: HomeMapPreview(
                        merchantList: controller.storeLocationList,
                      ),
                    ),
                  );
                }),

                Obx(() {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: controller.stores.length,
                      itemBuilder: (context, index) {
                        final store = controller.stores[index];
                        return FavoriteCrad(
                          orderNow: () => Get.toNamed(
                            AppRoutes.instance.shopOrderInformationScreen,
                          ),
                          viewHours: () =>
                              Get.toNamed(AppRoutes.instance.shopDetailsScreen),
                          isFavorite: () {},
                          favoriteCardEntity: FavoriteCardEntity(
                            image: "${AppApiEndPoint.domain}${store.image}",
                            name: store.name ?? "",
                            address: store.address ?? "",
                            status: store.isOpen,
                            isFavorite: store.isFavorite ?? false,
                          ),
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
