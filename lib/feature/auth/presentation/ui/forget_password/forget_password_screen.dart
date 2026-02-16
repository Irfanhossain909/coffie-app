import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/feature/auth/presentation/controller/forget_password/forget_password_controller.dart';
import 'package:coffie/feature/auth/presentation/widget/app_branding/branding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      init: ForgetPasswordController(),
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          body: Padding(
            padding: EdgeInsets.all(17.w),
            child: Center(
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
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
                        data: "Forgot Your Password?",
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                      AppText(
                        data:
                            "No worries! Enter the email address associated with your account, and we’ll send you instructions to reset your password.",
                        fontSize: 12.sp,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        height: 1.7,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      SizedBox(height: 12.h),
                      AppInputWidgetTwo(
                        controller: controller.emailController,
                        hintText: "Enter Your Email",
                        borderColor: AppColors.yellow,
                      ),

                      SizedBox(height: 8.h),

                      Obx(() {
                        return controller.isLoading.value
                            ? const CircularProgressIndicator()
                            : AppButton(
                                isAuthButton: true,
                                titleSize: 18.sp,
                                title: "Get Verification Code",
                                onTap: () => controller.forgetPassword(),
                              );
                      }),
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
