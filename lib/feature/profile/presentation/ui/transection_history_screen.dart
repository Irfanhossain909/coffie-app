import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransectionHistoryScreen extends StatelessWidget {
  const TransectionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: "Transaction History"),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: TransectionCard(),
          );
        },
      ),
    );
  }
}

class TransectionCard extends StatelessWidget {
  const TransectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.yellow),
        borderRadius: BorderRadius.circular(10.r),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4.h,
        children: [
          AppText(
            data: "Transaction ID: #INV-00123",
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                data: "Total Product Price",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              AppText(
                data: r"+$10.99",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                data: "Tip",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              AppText(
                data: r"+$5.00",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                data: "Rewards & Loyalty",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              AppText(
                data: r"-100p",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          Divider(color: AppColors.black.withValues(alpha: 0.7)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                data: "Total Amount",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              AppText(
                data: r"$5.99",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                data: "Payment By",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              AppText(
                data: "Wallet",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                data: "Status",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              AppText(
                data: "Pending",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
