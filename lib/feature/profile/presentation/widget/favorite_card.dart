import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/feature/profile/domain/entity/favorite_card_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteCrad extends StatelessWidget {
  final FavoriteCardEntity favoriteCardEntity;
  final VoidCallback? isFavorite;
  final VoidCallback? orderNow;
  final VoidCallback? viewHours;

  const FavoriteCrad({
    super.key,
    required this.favoriteCardEntity,
    this.isFavorite,
    this.orderNow,
    this.viewHours,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.yellow),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Stack(
        children: [
          /// 🔹 MAIN CONTENT
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(2.r),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.yellow),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: AppImageCircular(
                  width: 100.w,
                  height: 100.h,
                  borderRadius: 50.r,
                  url:
                      favoriteCardEntity.image ??
                      "https://i.pinimg.com/1200x/de/82/43/de824313ab9a1ee67f25dbc73666abc6.jpg",
                ),
              ),

              SizedBox(width: 10.w),

              /// 🔹 RIGHT SIDE CONTENT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// spacing for favorite icon area
                    SizedBox(height: 5.h),

                    AppText(
                      data: favoriteCardEntity.name ?? "Starbucks",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),

                    AppText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      data:
                          favoriteCardEntity.address ??
                          "17 Motijheel C/A, Dhaka 1000",
                      fontSize: 12.sp,
                    ),

                    SizedBox(height: 5.h),

                    Row(
                      children: [
                        AppText(
                          data: favoriteCardEntity.status == true
                              ? "Open"
                              : "Closed",
                          fontSize: 12.sp,
                        ),
                        SizedBox(width: 4.w),
                        Icon(Icons.circle, color: AppColors.red, size: 6.w),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    /// 🔹 BUTTON ROW (Bottom Right)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// View Hours
                          InkWell(
                            onTap: viewHours,
                            child: Container(
                              width: 88.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.yellow),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: AppText(
                                  data: "View Hours",
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 8.w),

                          /// Order Now
                          InkWell(
                            onTap: orderNow,
                            child: Container(
                              width: 88.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: AppColors.blue,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: AppText(
                                  data: "Order Now",
                                  color: Colors.white,
                                  fontSize: 12.sp,
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
            ],
          ),

          /// 🔹 TOP RIGHT FAVORITE ICON
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: isFavorite,
              icon: Icon(
                favoriteCardEntity.isFavorite == true
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: AppColors.yellow,
                size: 22.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
