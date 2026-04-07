import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_assets.dart';
import 'package:coffie/feature/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EmailSubscrptionScreen extends StatelessWidget {
  EmailSubscrptionScreen({super.key});
  final ProfileController controller = Get.find<ProfileController>();

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
              controller: controller.emailSubscriptionController,
              title: "Email",
              isEmail: true,
              isOptional: true,
              hintText: "Enter your email",
            ),

            Spacer(),

            Obx(() {
              return SafeArea(
                child: AppButton(
                  isLoading: controller.isLoading.value,
                  title: "Subscribe",
                  onTap: () {
                    controller.sendEmailSubscription();
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
