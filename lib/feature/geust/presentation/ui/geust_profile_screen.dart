import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/service/api_service/get_storage_services.dart';
import 'package:coffie/feature/geust/presentation/controller/geust_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GuestProfileScreen extends StatelessWidget {
  GuestProfileScreen({super.key});
  final GeustProfileController controller = Get.put(GeustProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        text: "Profile",
        autoShowLeading: false,
        showLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),

              /// Profile Image
              CircleAvatar(
                radius: 45.r,
                backgroundColor: Colors.grey.shade200,
                child: Icon(Icons.person, size: 50.sp, color: Colors.grey),
              ),

              SizedBox(height: 12.h),

              /// Guest Text
              AppText(
                data:
                    controller
                        .navigationScreenController
                        .guestName
                        .value
                        .isNotEmpty
                    ? controller.navigationScreenController.guestName.value
                    : "Guest",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),

              SizedBox(height: 4.h),

              AppText(
                data: "You're using the app as a guest",
                fontSize: 14.sp,
                color: Colors.grey,
              ),

              SizedBox(height: 20.h),

              /// 🔵 Login Button (Primary)
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    GetStorageServices.instance.setIsGuest(false);
                    Get.offAllNamed(AppRoutes.instance.loginScreen);
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              /// ⚪ Signup Button (Secondary)
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    GetStorageServices.instance.setIsGuest(false);
                    Get.offAllNamed(AppRoutes.instance.registerScreen);
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 16.sp, color: AppColors.blue),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              /// Quick Actions Title
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  data: "Quick Actions",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 16.h),

              /// Quick Actions Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _quickActionCard(
                    icon: Icons.favorite,
                    title: "Favorites",
                    onTap: () {
                      // if guest → maybe show login prompt
                    },
                  ),
                  _quickActionCard(
                    icon: Icons.shopping_bag,
                    title: "Orders",
                    onTap: () {},
                  ),
                  _quickActionCard(
                    icon: Icons.help_outline,
                    title: "Help",
                    onTap: () {
                      Get.toNamed(AppRoutes.instance.contactUsScreen);
                    },
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              /// Terms & Privacy Links
              Column(
                children: [
                  _linkItem(
                    title: "Terms & Conditions",
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.instance.privicyPolicyScreen,
                        arguments: {"title": "Terms & Conditions"},
                      );
                    },
                  ),
                  SizedBox(height: 10.h),
                  _linkItem(
                    title: "Privacy Policy",
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.instance.privicyPolicyScreen,
                        arguments: {"title": "Privacy Policy"},
                      );
                    },
                  ),
                ],
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Quick Action Card
  Widget _quickActionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90.w,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.blue),
            SizedBox(height: 8.h),
            AppText(data: title, fontSize: 12.sp),
          ],
        ),
      ),
    );
  }

  /// Link Item (Terms / Privacy)
  Widget _linkItem({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(data: title, fontSize: 14.sp),
            Icon(Icons.arrow_forward_ios, size: 16.sp),
          ],
        ),
      ),
    );
  }
}

// import 'package:coffie/core/component/app_button/app_button.dart';
// import 'package:coffie/core/component/app_text/app_text.dart';
// import 'package:coffie/core/component/appbar/custom_appbar.dart';
// import 'package:coffie/core/const/app_assets.dart';
// import 'package:coffie/core/const/app_color.dart';
// import 'package:coffie/core/route/app_routes.dart';
// import 'package:coffie/core/service/api_service/get_storage_services.dart';
// import 'package:coffie/feature/geust/presentation/controller/geust_profile_controller.dart';
// import 'package:coffie/feature/profile/presentation/widget/profile_row_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';

// class GeustProfileScreen extends StatelessWidget {
//   GeustProfileScreen({super.key});
//   final GeustProfileController controller = Get.put(GeustProfileController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbar(
//         text: "Profile",
//         showLeading: false,
//         autoShowLeading: false,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.r),
//             child: Row(
//               children: [
//                 Icon(Icons.person, size: 50.sp, color: AppColors.black),
//                 SizedBox(width: 20.w),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   spacing: 14.h,
//                   children: [
//                     AppText(
//                       data:
//                           controller
//                               .navigationScreenController
//                               .guestName
//                               .value
//                               .isNotEmpty
//                           ? controller
//                                 .navigationScreenController
//                                 .guestName
//                                 .value
//                           : "Guest",
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.w700,
//                     ),

//                     AppButton(
//                       onTap: () {
//                         Get.toNamed(AppRoutes.instance.loginScreen);
//                       },
//                       title: "Login",

//                       width: 150.w,
//                       height: 44.h,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(8.r),
//                 topRight: Radius.circular(8.r),
//                 bottomLeft: Radius.circular(8.r),
//                 bottomRight: Radius.circular(8.r),
//               ),
//               border: Border.all(color: AppColors.black.withValues(alpha: 0.3)),
//             ),
//             child: Column(
//               spacing: 25.h,
//               children: [
//                 SizedBox(height: 12.h),
//                 ProfileRowCard(
//                   title: "Terms & Conditions",
//                   icon: AppAssets.terms,
//                   onTap: () {
//                     Get.toNamed(
//                       AppRoutes.instance.privicyPolicyScreen,
//                       arguments: {"title": "Terms & Conditions"},
//                     );
//                   },
//                 ),
//                 ProfileRowCard(
//                   title: "Privacy Policy",
//                   icon: AppAssets.privacy,
//                   onTap: () {
//                     Get.toNamed(
//                       AppRoutes.instance.privicyPolicyScreen,
//                       arguments: {"title": "Privacy Policy"},
//                     );
//                   },
//                 ),

//                 ProfileRowCard(
//                   title: "Log Out",
//                   icon: AppAssets.logout,
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         contentPadding: EdgeInsets.symmetric(
//                           horizontal: 20,
//                           vertical: 24,
//                         ),
//                         content: Column(
//                           mainAxisSize: MainAxisSize.min, // গুরুত্বপূর্ণ
//                           children: [
//                             SvgPicture.asset(
//                               AppAssets.logout,
//                               width: 80.w,
//                               height: 80.h,
//                               color: AppColors.blue,
//                             ),
//                             SizedBox(height: 20),

//                             /// Text
//                             AppText(
//                               data: "Do you want to log out of your profile?",
//                               textAlign: TextAlign.center,
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w600,
//                             ),

//                             SizedBox(height: 24),

//                             /// Buttons Row
//                             Row(
//                               children: [
//                                 /// Cancel Button
//                                 Expanded(
//                                   child: OutlinedButton(
//                                     style: OutlinedButton.styleFrom(
//                                       side: BorderSide(color: AppColors.yellow),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       padding: EdgeInsets.symmetric(
//                                         vertical: 12.r,
//                                       ),
//                                     ),
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                     child: AppText(
//                                       data: "Cancel",
//                                       fontSize: 16.sp,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppColors.black,
//                                       textAlign: TextAlign.center,
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ),

//                                 SizedBox(width: 12),

//                                 /// Logout Button
//                                 Expanded(
//                                   child: ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: AppColors.blue,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       padding: EdgeInsets.symmetric(
//                                         vertical: 12.r,
//                                       ),
//                                     ),
//                                     onPressed: () {
//                                       GetStorageServices.instance
//                                           .completeLogout();
//                                     },
//                                     child: AppText(
//                                       data: "Log Out",
//                                       fontSize: 16.sp,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.white,
//                                       textAlign: TextAlign.center,
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(height: 12.h),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
