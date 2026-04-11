import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/service/api_service/get_storage_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GeuseScreen extends StatelessWidget {
  final String? title;
  const GeuseScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = AppColors.blue; // deep blue

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? "Guest"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 🔵 Icon / Illustration
            Icon(Icons.lock_outline, size: 160.sp, color: primaryBlue),

            SizedBox(height: 20.h),

            /// 📝 Title
            Text(
              "You're in Guest Mode",
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10.h),

            /// 📄 Subtitle
            Text(
              "Login or create an account to access all features like orders, loyalty points & gifts.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
            SizedBox(height: 34.h),

            /// 🔵 Login Button (Primary)
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
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
                  side: BorderSide(color: primaryBlue),
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
                  style: TextStyle(fontSize: 16.sp, color: primaryBlue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
