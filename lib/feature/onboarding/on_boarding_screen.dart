import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/feature/auth/presentation/widget/app_branding/branding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Column(
        spacing: 4.h,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 140.h),
          Branding(),

          AppText(
            data: "Order Coffee, Skip the Line",
            fontSize: 22.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
          Spacer(),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.backgrounColor,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.9),
                  blurRadius: 20.r,
                  offset: Offset(0, 10.r),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                spacing: 14.h,
                children: [
                  SizedBox(height: 26.h),
                  AppText(
                    data: "Welcome to Coffecito",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: AppText(
                      data:
                          "Order your favorite coffee ahead, customize it your way, and skip the line every time.",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  AppButton(
                    isAuthButton: true,
                    title: "Login",
                    onTap: () {
                      Get.toNamed(AppRoutes.instance.loginScreen);
                    },
                  ),
                  AppButton(
                    isAuthButton: true,
                    title: "Sign Up",
                    onTap: () {
                      Get.toNamed(AppRoutes.instance.registerScreen);
                    },
                    filColor: AppColors.lightBlue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
