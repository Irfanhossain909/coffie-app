import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/feature/profile/domain/entity/favorite_card_entity.dart';
import 'package:coffie/feature/profile/presentation/controller/favorate_controller.dart';
import 'package:coffie/feature/profile/presentation/widget/favorite_card.dart';
import 'package:coffie/feature/profile/presentation/widget/favorite_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';

class FavorateScreen extends StatelessWidget {
  const FavorateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return GetBuilder<FavorateController>(
          init: FavorateController(),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppbar(text: 'My Favorite'),
              body: SafeArea(
                child: DefaultTabController(
                  length: 2,
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: TabBarView(
                            children: [
                              /// 🔹 Shop Content
                              ListView.builder(
                                itemCount: favoriteCardEntityList.length,
                                itemBuilder: (context, index) {
                                  final favoriteCardEntity =
                                      favoriteCardEntityList[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: FavoriteCrad(
                                      isFavorite: () =>
                                          controller.toggleFavorite(index),
                                      favoriteCardEntity: favoriteCardEntity,
                                    ),
                                  );
                                },
                              ),

                              /// 🔹 Item Content
                              ListView.builder(
                                itemCount: favoriteCardEntityList.length,
                                itemBuilder: (context, index) {
                                  final favoriteCardEntity =
                                      favoriteCardEntityList[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: FavoriteItem(
                                      isFavorite: () =>
                                          controller.toggleFavorite(index),
                                      favoriteCardEntity: favoriteCardEntity,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
