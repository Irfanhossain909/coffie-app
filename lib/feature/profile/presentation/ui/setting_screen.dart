import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_assets.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/feature/profile/presentation/widget/profile_row_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: "Settings", autoShowLeading: false),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
              border: Border.all(color: AppColors.black.withValues(alpha: 0.3)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 25.h,
              children: [
                SizedBox(height: 12.h),
                ProfileRowCard(
                  title: "Change Password",
                  icon: AppAssets.changePassword,
                  onTap: () {
                    Get.toNamed(AppRoutes.instance.changePasswordScreen);
                  },
                ),
                ProfileRowCard(
                  title: "Contact Us",
                  icon: AppAssets.contactUs,
                  onTap: () {
                    Get.toNamed(AppRoutes.instance.contactUsScreen);
                  },
                ),
                ProfileRowCard(
                  title: "Terms & Conditions",
                  icon: AppAssets.terms,
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.instance.privicyPolicyScreen,
                      arguments: {"title": "Terms & Conditions"},
                    );
                  },
                ),
                ProfileRowCard(
                  title: "Privacy Policy",
                  icon: AppAssets.privacy,
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.instance.privicyPolicyScreen,
                      arguments: {"title": "Privacy Policy"},
                    );
                  },
                ),
                ProfileRowCard(
                  title: "Delete Account",
                  icon: AppAssets.delete,
                  onTap: () {
                    Get.toNamed(AppRoutes.instance.deleteAccountScreen);
                  },
                ),

                SizedBox(height: 12.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
