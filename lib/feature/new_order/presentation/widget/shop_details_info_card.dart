import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowDetailsInfoCard extends StatelessWidget {
  const ShowDetailsInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.yellow),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            spacing: 8.h,
            children: [
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
                      width: 64.w,
                      height: 68.h,
                      borderRadius: 50.r,
                      url:
                          "https://i.pinimg.com/1200x/de/82/43/de824313ab9a1ee67f25dbc73666abc6.jpg",
                    ),
                  ),

                  SizedBox(width: 10.w),

                  /// 🔹 RIGHT SIDE CONTENT
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4.h,
                      children: [
                        AppText(
                          data: "Starbucks",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),

                        AppText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          data: "+1664456285966",
                          fontSize: 14.sp,
                        ),
                        AppText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          data: "17 Motijheel C/A, Dhaka 1000 (2.6km)",
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    data: "About Shop",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  Row(
                    children: [
                      AppText(data: "Open", fontSize: 12.sp),
                      SizedBox(width: 4.w),
                      Icon(Icons.circle, color: AppColors.green, size: 6.w),
                    ],
                  ),
                ],
              ),
              AppText(
                data:
                    "Prepared with 1x single chicken patty, 1x sliced cheddar cheese, secret sauce, sliced onion, tomato & lettuce",
                fontSize: 12.sp,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                height: 1.7,
                letterSpacing: 1,
              ),
            ],
          ),
        ),

        /// 🔹 TOP RIGHT FAVORITE ICON
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_border,
              color: AppColors.yellow,
              size: 22.w,
            ),
          ),
        ),
      ],
    );
  }
}
