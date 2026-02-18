import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_assets.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/feature/profile/presentation/widget/profile_row_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        text: "Profile Information",
        showLeading: false,
        autoShowLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                AppImageCircular(
                  fit: BoxFit.cover,
                  url:
                      "https://i.pinimg.com/736x/82/98/77/82987705bbecf6e374569f280228d7ac.jpg",
                  width: 150.w,
                  height: 150.h,
                ),
                SizedBox(width: 20.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 14.h,
                  children: [
                    AppText(
                      data: "IRFAN HOSSAIN",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    AppText(
                      data: "+8801742222222",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),

                    AppButton(
                      onTap: () {
                        // Get.toNamed(AppRoutes.instance.changeProfileScreen);
                      },
                      title: "Subscribe",

                      width: 170.w,
                      height: 54.h,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 22.h),
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
              spacing: 25.h,
              children: [
                SizedBox(height: 12.h),
                ProfileRowCard(
                  title: "Edit Profile",
                  icon: AppAssets.edit,
                  onTap: () {},
                ),
                ProfileRowCard(
                  title: "My Wallet",
                  icon: AppAssets.wallet,
                  onTap: () {},
                ),
                ProfileRowCard(
                  title: "Favorite",
                  icon: AppAssets.favorate,
                  onTap: () {
                    Get.toNamed(AppRoutes.instance.favorateScreen);
                  },
                ),
                ProfileRowCard(
                  title: "Transaction History",
                  icon: AppAssets.transection,
                  onTap: () {},
                ),
                ProfileRowCard(
                  title: "Settings",
                  icon: AppAssets.setting,
                  onTap: () {
                    Get.toNamed(AppRoutes.instance.settingScreen);
                  },
                ),
                ProfileRowCard(
                  title: "Log Out",
                  icon: AppAssets.logout,
                  onTap: () {},
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
