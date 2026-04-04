import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/feature/new_order/presentation/widget/shop_details_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShopDetailsScrenn extends StatelessWidget {
  const ShopDetailsScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Get.arguments;

    return Scaffold(
      appBar: CustomAppbar(text: "Shop Working Information"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            ShowDetailsInfoCard(store: store),

            Container(
              margin: EdgeInsets.only(top: 16.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.yellow),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    data: "Restaurant Working Hours",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),

                  SizedBox(height: 8.h),

                  /// ✅ FIX: Wrap ListView with SizedBox + shrinkWrap
                  SizedBox(
                    height: 200.h, // or adjust dynamically if needed
                    child: ListView.builder(
                      itemCount: store?.hours?.length ?? 0,
                      itemBuilder: (context, index) {
                        final hour = store?.hours?[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: _buildWorkingHours(
                            day: "${hour?.day} - ${hour?.close}",
                            time: "${hour?.open} - ${hour?.close}",
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkingHours({required String day, required String time}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(data: day, fontSize: 12.sp, fontWeight: FontWeight.w400),
        AppText(data: time, fontSize: 12.sp, fontWeight: FontWeight.w400),
      ],
    );
  }
}

// import 'package:coffie/core/component/app_text/app_text.dart';
// import 'package:coffie/core/component/appbar/custom_appbar.dart';
// import 'package:coffie/core/const/app_color.dart';
// import 'package:coffie/feature/new_order/domain/model/store_model.dart';
// import 'package:coffie/feature/new_order/presentation/widget/shop_details_info_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class ShopDetailsScrenn extends StatelessWidget {
//   const ShopDetailsScrenn({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final store = Get.arguments;
//     return Scaffold(
//       appBar: CustomAppbar(text: "Shop Working Information"),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: Column(
//           children: [
//             ShowDetailsInfoCard(store: store),
//             Container(
//               margin: EdgeInsets.only(top: 16.h),
//               padding: EdgeInsets.all(12.w),
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppColors.yellow),
//                 borderRadius: BorderRadius.circular(10.r),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 spacing: 8.h,
//                 children: [
//                   AppText(
//                     data: "Restaurant Working Hours",
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   ListView.builder(
//                     itemCount: store?.hours?.length,
//                     itemBuilder: (context, index) {
//                       final hour = store?.hours?[index];
//                       return _buildWorkingHours(
//                         day: hour?.day ?? "",
//                         time: hour?.open ?? "",
//                       );
//                     },
//                   ),
//                   // _buildWorkingHours(
//                   //   day: "Monday",
//                   //   time: "10:00 AM - 10:00 PM",
//                   // ),
//                   // _buildWorkingHours(
//                   //   day: "Tuesday",
//                   //   time: "10:00 AM - 10:00 PM",
//                   // ),
//                   // _buildWorkingHours(
//                   //   day: "Wednesday",
//                   //   time: "10:00 AM - 10:00 PM",
//                   // ),
//                   // _buildWorkingHours(
//                   //   day: "Thursday",
//                   //   time: "10:00 AM - 10:00 PM",
//                   // ),
//                   // _buildWorkingHours(
//                   //   day: "Friday",
//                   //   time: "10:00 AM - 10:00 PM",
//                   // ),
//                   // _buildWorkingHours(
//                   //   day: "Saturday",
//                   //   time: "10:00 AM - 10:00 PM",
//                   // ),
//                   // _buildWorkingHours(
//                   //   day: "Sunday",
//                   //   time: "10:00 AM - 10:00 PM",
//                   // ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildWorkingHours({required String day, required String time}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         AppText(data: day, fontSize: 12.sp, fontWeight: FontWeight.w400),
//         AppText(data: time, fontSize: 12.sp, fontWeight: FontWeight.w400),
//       ],
//     );
//   }
// }
