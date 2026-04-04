import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/feature/new_order/domain/model/store_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowDetailsInfoCard extends StatelessWidget {
  final StoreDataModel? store;
  const ShowDetailsInfoCard({super.key, this.store});

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
                      url: "${AppApiEndPoint.domain}${store?.image}",
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
                          data: store?.name ?? "",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),

                        AppText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          data: store?.phone ?? "",
                          fontSize: 14.sp,
                        ),
                        AppText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          data: store?.address ?? "",
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
                    data: "About",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  Row(
                    children: [
                      AppText(
                        data: store?.isOpen == true ? "Open" : "Closed",
                        fontSize: 12.sp,
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.circle,
                        color: store?.isOpen == true
                            ? AppColors.green
                            : AppColors.red,
                        size: 6.w,
                      ),
                    ],
                  ),
                ],
              ),
              AppText(
                data: store?.about ?? "",
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
