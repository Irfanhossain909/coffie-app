import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final int readyTime;
  final String price;
  final List<String> tags; // 🔥 dynamic list
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? isFavoriteTap;
  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.readyTime,
    required this.price,
    required this.tags,
    this.onTap,
    this.isFavorite = false,
    this.isFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.yellow),
        ),
        width: double.infinity,

        /// ❌ REMOVE height
        // height: 140.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColors.yellow),
              ),
              child: AppImageCircular(
                borderRadius: 8.r,
                url: image,
                width: 99.w,
                height: 93.h,
              ),
            ),

            SizedBox(width: 10.w),

            /// Right Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max, // ✅ important
                children: [
                  AppText(
                    data: name,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 4.h),

                  AppText(
                    data: "Pickup Time: Ready in $readyTime mins",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),

                  SizedBox(height: 8.h),

                  /// Tags (dynamic wrap)
                  Wrap(
                    spacing: 6.w,
                    runSpacing: 4.h,
                    children: tags.map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.yellow),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: AppText(
                          data: tag.toUpperCase(),
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            SizedBox(width: 8.w),

            /// Right side
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: isFavoriteTap,
                  child: Icon(
                    isFavorite == true
                        ? Icons.favorite
                        : Icons.favorite_border_rounded,
                    size: 24.w,
                    color: AppColors.yellow,
                  ),
                ),

                SizedBox(height: 20.h),

                AppText(
                  data: price,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
