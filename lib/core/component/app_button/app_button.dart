import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onTap,
    required this.title,
    this.isLoading = false,
    this.margin,
    this.circularHeight,
    this.height,
    this.width,
    this.borderRadius,
    this.decoration,
    this.titleColor,
    this.titleSize,
    this.filColor,
    this.isAuthButton = false,
  });

  final void Function()? onTap;
  final double? height;
  final double? circularHeight;
  final double? width;
  final String title;
  final bool isLoading;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final BoxDecoration? decoration;
  final Color? titleColor;
  final double? titleSize;
  final Color? filColor;
  final bool? isAuthButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width ?? Get.width,
        height: height ?? 50.0.h,
        alignment: Alignment.center,
        margin: margin,
        decoration:
            decoration ??
            BoxDecoration(
              color: filColor ?? AppColors.blue,
              borderRadius: borderRadius ?? BorderRadius.circular(8.r),
            ),

        child: isLoading
            ? SizedBox(
                height: circularHeight ?? 30.0.h,
                width: circularHeight ?? 30.0.w,
                child: const CircularProgressIndicator(
                  // color: AppColors.white50,
                  strokeWidth: 2,
                ),
              )
            : isAuthButton == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4.w,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText(
                    data: title,
                    color: titleColor ?? Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: titleSize ?? 16.sp,
                  ),
                  Icon(
                    Icons.arrow_right_alt_rounded,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ],
              )
            : AppText(
                data: title,
                color: titleColor ?? Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: titleSize ?? 16.sp,
              ),
      ),
    );
  }
}
