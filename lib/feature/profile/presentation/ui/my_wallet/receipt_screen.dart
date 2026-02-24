import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/feature/auth/presentation/widget/app_branding/branding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: "Receipt"),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.yellow),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.h,
                children: [
                  Branding(),
                  Row(
                    children: [
                      AppText(
                        data: "Transaction ID: ",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                      AppText(
                        data: "TXN-1023498",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  Divider(color: AppColors.black.withValues(alpha: 0.2)),
                  AppText(
                    data: "Items Purchased",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        data: "Americano ×1",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      AppText(
                        data: r"$3.00",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        data: "Croissant ×1",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      AppText(
                        data: r"$1.50",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        data: "Location",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      AppText(
                        data: "New Work • 2.6 km",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        data: "Previous Balance",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      AppText(
                        data: r"+$25.99",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        data: "Order Price",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      AppText(
                        data: r"-$10.09",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        data: "New Balance",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      AppText(
                        data: r"$15.99",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
