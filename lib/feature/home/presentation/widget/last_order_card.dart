import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LastOrderCard extends StatelessWidget {
  const LastOrderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.yellow),
      ),
      width: double.infinity,
    
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.w,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColors.yellow),
            ),
            child: AppImageCircular(
              borderRadius: 8.r,
              url:
                  "https://i.pinimg.com/736x/f0/4e/90/f04e90b671eccbde302107dc0a447135.jpg",
              width: 99.w,
              height: 93.h,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      data: "Americano",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    AppText(
                      data: "\$5.00",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ],
                ),
                AppText(
                  data: "Pickup Time: Ready in 6 mins",
                  fontSize: 12.sp,
                  maxLines: 2,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 16.h),
                InkWell(
                  onTap: () {},
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: AppText(
                        data: "Order Completed",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
