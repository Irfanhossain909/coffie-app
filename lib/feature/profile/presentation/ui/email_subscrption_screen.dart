import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmailSubscrptionScreen extends StatelessWidget {
  const EmailSubscrptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: "Email Subscription"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SvgPicture.asset(
              AppAssets.emailSubscription,
              width: 220.w,
              height: 166.h,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 34.h),
            AppText(
              data: "Subscribe Now",
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 16.h),
              child: AppText(
                data:
                    "Get updates on daily specials, new drinks, and exclusive offers straight to your inbox.",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                height: 1.4.h,
                textAlign: TextAlign.center,
              ),
            ),
            AppInputWidgetTwo(
              title: "Email",
              isEmail: true,
              isOptional: true,
              hintText: "Enter your email",
            ),

            Spacer(),

            SafeArea(
              child: AppButton(title: "Subscribe", onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
