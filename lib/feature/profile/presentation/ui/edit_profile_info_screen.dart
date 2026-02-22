import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileInfoScreen extends StatelessWidget {
  const EditProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: "Edit Profile Info"),
      body: SingleChildScrollView(
        child: InkWell(
          onTap: () => FocusScope.of(context).unfocus(),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,

          child: Column(
            children: [
              Stack(
                children: [
                  AppImageCircular(
                    url:
                        "https://i.pinimg.com/736x/89/ad/a2/89ada2494495ff35cbc441195de65193.jpg",
                    width: 162.w,
                    height: 162.h,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 42.w,
                      height: 42.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.black.withValues(alpha: 0.7),
                        ),
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 24.sp,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: AppColors.black.withValues(alpha: 0.1),
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    spacing: 16.h,
                    children: [
                      AppInputWidgetTwo(
                        isOptional: true,

                        title: "Full Name",
                        titleFontSize: 14.sp,
                        titleColor: AppColors.black,
                        titleFontWeight: FontWeight.bold,
                        hintText: "Enter Your Full Name",
                        controller: TextEditingController(text: "Sabbir Ahmad"),
                      ),
                      AppInputWidgetTwo(
                        isOptional: true,

                        title: "Phone Number",
                        titleFontSize: 14.sp,
                        titleColor: AppColors.black,
                        titleFontWeight: FontWeight.bold,
                        hintText: "Enter Your Number",
                        controller: TextEditingController(text: "01717171717"),
                      ),
                      AppInputWidgetTwo(
                        isOptional: true,

                        title: "Email",
                        titleFontSize: 14.sp,
                        titleColor: AppColors.black,
                        titleFontWeight: FontWeight.bold,
                        hintText: "Enter Your Email",
                        controller: TextEditingController(
                          text: "example@gmail.com",
                        ),
                      ),
                      AppInputWidgetTwo(
                        isOptional: true,

                        title: "Address",
                        titleFontSize: 14.sp,
                        titleColor: AppColors.black,
                        titleFontWeight: FontWeight.bold,
                        hintText: "Enter Your Address",
                        controller: TextEditingController(
                          text: "123 Main St, Anytown, USA",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: AppButton(title: "Save", onTap: () {}),
        ),
      ),
    );
  }
}
