import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/feature/auth/presentation/widget/app_branding/branding.dart';
import 'package:coffie/feature/wallet/presentation/controller/wallet_add_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WalletAddScreen extends StatelessWidget {
  const WalletAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletAddController>(
      init: WalletAddController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(text: "Add Money"),
          body: Container(
            height: 370.h,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.yellow),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Branding(),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: AppText(
                    data:
                        "Add funds to your wallet to enable seamless app transactions.",
                    fontSize: 12.sp,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12.h),
                AppInputWidgetTwo(
                  controller: controller.amountController,
                  hintText: "Amount",
                  title: "Enter Amount",
                  isOptional: true,
                ),
                SizedBox(height: 12.h),
                Obx(() {
                  return AppButton(
                    isLoading: controller.isLoading.value,
                    title: "Add Money",
                    onTap: () {
                      controller.addWalletMoney();
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
