import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/feature/auth/presentation/controller/forget_password/new_password_controller.dart';
import 'package:coffie/feature/auth/presentation/widget/app_branding/branding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewPasswordController>(
      init: NewPasswordController(),
      builder: (controller) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () => FocusScope.of(context).unfocus(),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 24.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.yellow),
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Column(
                          spacing: 4.h,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Branding(),
                            SizedBox(height: 12.h),
                            AppText(
                              data: "Verify Your Account",
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                            AppText(
                              data:
                                  "Create a new password for your account. Make sure it’s strong and secure.",
                              fontSize: 12.sp,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              height: 1.7,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                            AppInputWidgetTwo(
                              controller: controller.passwordController,
                              hintText: "New Password",
                              isPassWord: true,
                              borderColor: AppColors.yellow,
                            ),
                            AppInputWidgetTwo(
                              isPassWord: true,
                              controller: controller.confirmPasswordController,
                              hintText: "Confirm New Password",
                              isPassWordSecondValidation: true,
                              isPassWordSecondValidationController:
                                  controller.passwordController,
                              borderColor: AppColors.yellow,
                            ),

                            SizedBox(height: 8.h),

                            Obx(() {
                              return controller.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : AppButton(
                                      isAuthButton: true,
                                      titleSize: 18.sp,
                                      title: "Save New Password",
                                      onTap: () => controller.newPassword(),
                                    );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
