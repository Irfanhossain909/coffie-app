import 'package:coffie/core/component/app_location_field/places_suggation.dart';
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
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: PlaceAutocompleteWidget(
                          prefixIcon: Icon(
                            Icons.search,
                            size: 20.w,
                            color: AppColors.black,
                          ),

                          controller: controller.searchController,
                          hintText: 'Enter location',
                          hintColor: AppColors.black,
                          borderWidth: 0.9,
                          borderRadius: 12,
                          borderColor: AppColors.yellow,
                          textColor: AppColors.black,
                          showCurrentLocation: controller.hasLocationData,
                          currentLocationAddress:
                              controller.selectedAddress.value.isNotEmpty
                              ? controller.selectedAddress.value
                              : null,
                          currentLocationLat:
                              controller.selectedLatitude.value != 0.0
                              ? controller.selectedLatitude.value
                              : null,
                          currentLocationLng:
                              controller.selectedLongitude.value != 0.0
                              ? controller.selectedLongitude.value
                              : null,
                          onPlaceSelected:
                              (
                                placeId,
                                description, {
                                isCurrentLocation = false,
                                lat,
                                lng,
                              }) {
                                controller.onPlaceSelected(
                                  placeId,
                                  description,
                                  isCurrentLocation: isCurrentLocation,
                                  lat: lat,
                                  lng: lng,
                                );
                              },
                        ),
                      ),
                      InkWell(
                        onTap: controller.isLoading.value
                            ? null
                            : () {
                                // controller.onLocationTap();
                                controller.searchLocation();
                              },
                        borderRadius: BorderRadius.circular(8.r),
                        child: Container(
                          width: 46.w,
                          height: 46.h,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 8.w),
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: controller.isLoading.value
                              ? SizedBox(
                                  width: 20.w,
                                  height: 20.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Icon(
                                  Icons.send,
                                  size: 20.w,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ],
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
                        isReload: controller.isSearchLoading.value,
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
                          isFavoriteVisible: controller.isGuest ? false : true,
                          orderNow: () => Get.toNamed(
                            AppRoutes.instance.shopOrderInformationScreen,
                            arguments: store,
                          ),
                          viewHours: () {
                            Get.toNamed(
                              AppRoutes.instance.shopDetailsScreen,
                              arguments: store,
                            );
                          },

                          isFavorite: () async {
                            if (store.isFavorite ?? false) {
                              await controller.removeFavorite(store.id ?? "");
                            } else {
                              await controller.addFavorite(store.id ?? "");
                            }
                          },
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
