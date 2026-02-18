import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_assets.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: 'Change Password'),
      body: SingleChildScrollView(
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Column(
            children: [
              SvgPicture.asset(
                AppAssets.changePasswordImg,
                width: 220.w,
                height: 220.h,
              ),
              SizedBox(height: 20.h),

              Container(
                margin: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.backgrounColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 12, // shadow soft করবে
                      spreadRadius: 1, // চারদিকে ছড়াবে
                      offset: Offset(0, 0), // 👈 all side shadow
                    ),
                  ],
                ),

                padding: EdgeInsets.all(20.r),
                child: Column(
                  spacing: 8.h,
                  children: [
                    AppInputWidgetTwo(
                      isOptional: true,
                      isPassWord: true,
                      title: "Current Password",
                      hintText: "Current Password",
                    ),
                    AppInputWidgetTwo(
                      isOptional: true,
                      isPassWord: true,
                      title: "New Password",
                      hintText: "New Password",
                    ),
                    AppInputWidgetTwo(
                      isOptional: true,
                      isPassWord: true,
                      title: "Confirm New Password",
                      hintText: "Confirm Password",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AppButton(title: "Update Password"),
        ),
      ),
    );
  }
}
