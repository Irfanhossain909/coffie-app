import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/feature/gift_card/presentation/controller/gift_card_controller.dart';
import 'package:coffie/feature/gift_card/presentation/widget/category_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PercheseGiftCardScreen extends StatelessWidget {
  const PercheseGiftCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GiftCardController>(
      init: GiftCardController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(showLeading: true, text: "Purchase Gift Card"),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.black.withValues(alpha: 0.1)),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12.h,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  data: "Gift Card Amount",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
                CategorySelector(
                  items: const [
                    "\$20.00",
                    "\$50.00",
                    "\$100.00",
                    "\$200.00",
                    "\$500.00",
                    "\$1000.00",
                  ],
                  selectedItem: controller.selectedCategory,
                  onTap: controller.selectCategory,
                ),
                AppInputWidgetTwo(
                  isOptional: true,
                  isDescription: true,
                  title: "Message",
                  hintText: "Add a message (optional)",
                ),
                AppInputWidgetTwo(
                  isOptional: true,
                  title: "To",
                  hintText: "Enter Receiver Name",
                ),
                AppInputWidgetTwo(
                  isOptional: true,
                  title: "Email Address",
                  hintText: "Enter Email Address",
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 10.h,
                children: [
                  AppButton(title: "Continue", onTap: () {}),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.yellow),
                      borderRadius: BorderRadius.circular(10.r),
                    ),

                    child: Center(
                      child: AppText(
                        data: "Cancel",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
