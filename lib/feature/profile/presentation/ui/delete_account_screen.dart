import 'dart:math';

import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_assets.dart';
import 'package:coffie/feature/profile/presentation/controller/delete_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeleteAccountController>(
      init: DeleteAccountController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(text: "Delete Account"),
          body: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              spacing: 12.h,
              children: [
                SvgPicture.asset(
                  AppAssets.deleteAccountImg,
                  width: 220.w,
                  height: 158.h,
                ),
                SizedBox(height: 24.h),
                AppText(
                  data: "Want to delete account !",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 34.w),
                  child: AppText(
                    data:
                        "Please confirm your password to remove your account.",
                    fontSize: 16.sp,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                AppInputWidgetTwo(
                  isOptional: true,
                  title: "Password",
                  hintText: "Enter your password",
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Obx(() {
              return controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: AppButton(
                        title: "Delete Account",
                        onTap: () => controller.deleteAccount(),
                      ),
                    );
            }),
          ),
        );
      },
    );
  }
}
