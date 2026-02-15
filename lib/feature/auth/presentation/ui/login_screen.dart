import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_assets.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/feature/auth/presentation/controller/login_controller.dart';
import 'package:coffie/feature/auth/presentation/widget/app_branding/branding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
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
                    vertical: 10.h,
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
                        data: "Welcome back!",
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                      AppText(
                        data:
                            "Sign in to order faster, earn rewards, and track your coffee.",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      SizedBox(height: 12.h),
                      AppInputWidgetTwo(
                        controller: controller.emailController,
                        hintText: "Enter Your Email",
                        borderColor: AppColors.yellow,
                      ),
                      AppInputWidgetTwo(
                        controller: controller.passwordController,
                        hintText: "Enter Your Password",
                        isPassWord: true,
                        borderColor: AppColors.yellow,
                      ),
                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppText(
                          data: "Forgot password?",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blue,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Obx(() {
                        return controller.isLoading.value
                            ? const CircularProgressIndicator()
                            : AppButton(
                                isAuthButton: true,
                                titleSize: 18.sp,
                                title: "Sign In",
                                onTap: () => controller.login(),
                              );
                      }),
                      SizedBox(height: 8.h),

                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.black,
                              thickness: 1.5.h,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: AppText(
                              data: "or",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColors.black,
                              thickness: 1.5.h,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        spacing: 10.w,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.black.withValues(alpha: 0.3),
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              height: 50.h,
                              child: SvgPicture.asset(
                                AppAssets.google,
                                width: 12.w,
                                height: 12.h,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(color: AppColors.black),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              height: 50.h,
                              child: SvgPicture.asset(
                                AppAssets.apple,
                                width: 12.w,
                                height: 12.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      AppText(
                        data: "Continue as Guest",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blue,
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                spacing: 4.w,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    data: "Don't have an account?",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                  AppText(
                    data: "Sign up",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue,
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
