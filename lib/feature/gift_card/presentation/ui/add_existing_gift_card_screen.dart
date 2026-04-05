import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/feature/gift_card/presentation/controller/add_exising_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddExistingGiftCard extends StatelessWidget {
  const AddExistingGiftCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddExisingCardController>(
      init: AddExisingCardController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(
            showLeading: true,
            text: "Add Existing Gift Card",
          ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.black.withValues(alpha: 0.1)),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppInputWidgetTwo(
                  controller: controller.giftCardNumberController,
                  title: "Gift Card Number",
                  hintText: "Enter gift card number",
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Obx(() {
              return controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      child: AppButton(
                        title: "Add Existing Gift Card",
                        onTap: () => controller.addExistingGiftCard(),
                      ),
                    );
            }),
          ),
        );
      },
    );
  }
}
