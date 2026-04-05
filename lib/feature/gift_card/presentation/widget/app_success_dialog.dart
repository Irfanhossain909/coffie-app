import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable success dialog: [icon], [title], optional [message], primary [buttonTitle].
class AppSuccessDialog extends StatelessWidget {
  const AppSuccessDialog({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    required this.buttonTitle,
    required this.onButtonPressed,
  });

  final Widget icon;
  final String title;
  final String? message;
  final String buttonTitle;
  final VoidCallback onButtonPressed;

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget icon,
    required String title,
    String? message,
    required String buttonTitle,
    required VoidCallback onButtonPressed,
    bool barrierDismissible = false,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (ctx) => AppSuccessDialog(
        icon: icon,
        title: title,
        message: message,
        buttonTitle: buttonTitle,
        onButtonPressed: onButtonPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.backgrounColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            SizedBox(height: 16.h),
            AppText(
              data: title,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.black,

              textAlign: TextAlign.center,
              maxLines: 1,
            ),
            if (message != null && message!.isNotEmpty) ...[
              SizedBox(height: 8.h),
              AppText(
                data: message!,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.black.withValues(alpha: 0.7),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            SizedBox(height: 24.h),
            AppButton(
              title: buttonTitle,
              onTap: () {
                Navigator.of(context).pop();
                onButtonPressed();
              },
            ),
          ],
        ),
      ),
    );
  }
}
