import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/feature/profile/presentation/ui/my_wallet/my_wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WalletHistoryScreen extends StatelessWidget {
  const WalletHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: "Wallet History"),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          spacing: 16.h,
          children: [
            WalletCard(type: "normal", price: r"$20.00"),
            Container(
              padding: EdgeInsets.all(16.r),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.yellow),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                spacing: 8.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    data: "Transaction Details",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        data: "Transaction ID",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      AppText(
                        data: "TXN-1023498",
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
                        data: r"$25.99",
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
                        data: r"-$10.00",
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
                        data: r"-$10.00",
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
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.h),
          child: AppButton(
            title: "View Receipt",
            onTap: () {
              Get.toNamed(AppRoutes.instance.receiptScreen);
            },
          ),
        ),
      ),
    );
  }
}
