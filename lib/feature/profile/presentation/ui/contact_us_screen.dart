import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:coffie/feature/profile/presentation/controller/contact_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsController>(
      init: ContactUsController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(text: 'Contact Us'),
          body: Padding(
            padding: EdgeInsets.all(16.r),
            child: SingleChildScrollView(
              child: InkWell(
                onTap: () => FocusScope.of(context).unfocus(),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                child: Column(
                  spacing: 12.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      data: "Contact Us",
                      fontSize: 18.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 12.h),
                    AppText(
                      data: "Full Name",
                      style: GoogleFonts.jost().copyWith(
                        fontSize: 18.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        AppSnackBar.message("Full Name can't be changed");
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.black.withValues(alpha: 0.1),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(12.r),

                        child: AppText(
                          data: "Irfan Khan",
                          style: GoogleFonts.jost().copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black.withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                    ),
                    AppText(
                      data: "Email",
                      style: GoogleFonts.jost().copyWith(
                        fontSize: 18.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        AppSnackBar.message("Email can't be changed");
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.black.withValues(alpha: 0.1),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(12.r),

                        child: AppText(
                          data: "test@example.com",
                          style: GoogleFonts.jost().copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black.withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                    ),
                    AppInputWidgetTwo(
                      controller: controller.subjectController,
                      isOptional: true,
                      title: "Subject",
                      hintText: "Enter Subject",
                    ),
                    AppInputWidgetTwo(
                      controller: controller.messageController,
                      height: 200.h,
                      isDescription: true,
                      isOptional: true,
                      title: "Subject",
                      hintText: "Enter Subject",
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Obx(() {
              return controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: AppButton(
                        title: "Send",
                        onTap: () => controller.contactUs(),
                      ),
                    );
            }),
          ),
        );
      },
    );
  }
}
