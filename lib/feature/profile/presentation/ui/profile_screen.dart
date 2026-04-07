import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_assets.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/core/service/api_service/get_storage_services.dart';
import 'package:coffie/feature/profile/presentation/controller/profile_controller.dart';
import 'package:coffie/feature/profile/presentation/widget/profile_row_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(
            text: "Profile Information",
            showLeading: false,
            autoShowLeading: false,
          ),
          body: Column(
            children: [
              Obx(() {
                return Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Row(
                    children: [
                      AppImageCircular(
                        fit: BoxFit.cover,
                        url:
                            "${AppApiEndPoint.domain}${controller.profileModel.value?.data?.profileImage}",
                        width: 150.w,
                        height: 150.h,
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 12.h,
                          children: [
                            AppText(
                              data:
                                  controller.profileModel.value?.data?.name ??
                                  "",
                              fontSize: 18.sp,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w700,
                            ),
                            if (controller.profileModel.value?.data?.phone !=
                                null)
                              AppText(
                                data:
                                    controller
                                        .profileModel
                                        .value
                                        ?.data
                                        ?.phone ??
                                    "",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),

                            AppButton(
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.instance.emailSubscrptionScreen,
                                );
                              },
                              title: "Subscribe",

                              width: 150.w,
                              height: 44.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
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
                  border: Border.all(
                    color: AppColors.black.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  spacing: 25.h,
                  children: [
                    SizedBox(height: 12.h),
                    ProfileRowCard(
                      title: "Edit Profile",
                      icon: AppAssets.edit,
                      onTap: () {
                        Get.toNamed(AppRoutes.instance.editProfileInfoScreen);
                      },
                    ),
                    ProfileRowCard(
                      title: "My Wallet",
                      icon: AppAssets.wallet,
                      onTap: () {
                        Get.toNamed(AppRoutes.instance.myWalletScreen);
                      },
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
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.instance.transectionHistoryScreen,
                        );
                      },
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
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 24,
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min, // গুরুত্বপূর্ণ
                              children: [
                                SvgPicture.asset(
                                  AppAssets.logout,
                                  width: 80.w,
                                  height: 80.h,
                                  // ignore: deprecated_member_use
                                  color: AppColors.blue,
                                ),
                                SizedBox(height: 20),

                                /// Text
                                AppText(
                                  data:
                                      "Do you want to log out of your profile?",
                                  textAlign: TextAlign.center,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),

                                SizedBox(height: 24),

                                /// Buttons Row
                                Row(
                                  children: [
                                    /// Cancel Button
                                    Expanded(
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                            color: AppColors.yellow,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 12.r,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: AppText(
                                          data: "Cancel",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black,
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: 12),

                                    /// Logout Button
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.blue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 12.r,
                                          ),
                                        ),
                                        onPressed: () {
                                          GetStorageServices.instance
                                              .completeLogout();
                                        },
                                        child: AppText(
                                          data: "Log Out",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
