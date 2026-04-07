import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/feature/profile/domain/model/transection_history_model.dart';
import 'package:coffie/feature/profile/presentation/controller/transection_controller.dart';
import 'package:coffie/feature/profile/presentation/widget/transection_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TransectionHistoryScreen extends StatelessWidget {
  const TransectionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransectionController>(
      init: TransectionController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(text: "Transaction History"),
          body: Obx(() {
            if (controller.isLoading.value) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return TransactionCardShimmer();
                },
              );
            }
            if (controller.transectionHistoryList.isEmpty) {
              return Center(
                child: AppText(data: "No transaction history found"),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: controller.transectionHistoryList.length,
              itemBuilder: (context, index) {
                final transection = controller.transectionHistoryList[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: TransectionCard(transection: transection),
                );
              },
            );
          }),
        );
      },
    );
  }
}

class TransectionCard extends StatelessWidget {
  final TtrancestionHistoryDataModel transection;
  const TransectionCard({super.key, required this.transection});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(10.r),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4.h,
        children: [
          AppText(
            data: "Transaction ID: #${transection.id}",
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
                data: "+\$${transection.totalAmount}",
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
                data: "+\$${transection.tipAmount}",
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
                data: "-${transection.pointsEarned}p",
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
                data: "\$${transection.totalAmount}",
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
                data: "${transection.paymentMethod}",
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
                data: "${transection.paymentStatus}",
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
