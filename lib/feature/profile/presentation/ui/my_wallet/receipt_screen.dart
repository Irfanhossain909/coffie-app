import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/feature/auth/presentation/widget/app_branding/branding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;

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
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      AppText(
                        data: "Transaction ID: ",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                      AppText(
                        data: data?.orderId ?? "",
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
                  if (data?.items?.isNotEmpty ?? false)
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data?.items?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = data?.items?[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              data: "${item?.productName} ×${item?.quantity}",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            AppText(
                              data: "\$${item?.totalPrice ?? 0}",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        );
                      },
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
                        data:
                            "${data?.store?.name} • ${data?.store?.distanceKm ?? 0} km",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     AppText(
                  //       data: "Previous Balance",
                  //       fontSize: 12.sp,
                  //       fontWeight: FontWeight.w400,
                  //       color: AppColors.black,
                  //     ),
                  //     AppText(
                  //       data: r"+$25.99",
                  //       fontSize: 12.sp,
                  //       fontWeight: FontWeight.w400,
                  //       color: AppColors.black,
                  //     ),
                  //   ],
                  // ),
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
                        data: "\$${data?.totalAmount ?? 0}",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     AppText(
                  //       data: "New Balance",
                  //       fontSize: 12.sp,
                  //       fontWeight: FontWeight.w400,
                  //       color: AppColors.black,
                  //     ),
                  //     AppText(
                  //       data: r"$15.99",
                  //       fontSize: 12.sp,
                  //       fontWeight: FontWeight.w400,
                  //       color: AppColors.black,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
