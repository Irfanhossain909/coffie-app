import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_assets.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/feature/profile/domain/entity/favorite_card_entity.dart';
import 'package:coffie/feature/profile/presentation/widget/favorite_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

class PickupLocationScreen extends StatelessWidget {
  const PickupLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: "Choose Pickup Location"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            spacing: 16.h,
            children: [
              AppInputWidgetTwo(
                hintText: "Search Location",
                prefix: Icon(Icons.search, size: 20.w, color: AppColors.black),
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
              AppImageCircular(
                path: AppAssets.mapImg,
                height: 250.h,
                borderRadius: 8,
              ),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: favoriteCardEntityList.length,
                itemBuilder: (context, index) {
                  final favoriteCardEntity = favoriteCardEntityList[index];
                  return FavoriteCrad(
                    orderNow: () => Get.toNamed(
                      AppRoutes.instance.shopOrderInformationScreen,
                    ),
                    viewHours: () =>
                        Get.toNamed(AppRoutes.instance.shopDetailsScreen),
                    isFavorite: () {},
                    favoriteCardEntity: favoriteCardEntity,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
