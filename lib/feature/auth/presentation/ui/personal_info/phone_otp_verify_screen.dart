import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/feature/auth/presentation/controller/personal_info/phone_otp_verify_controller.dart';
import 'package:coffie/feature/auth/presentation/widget/app_branding/branding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PhoneOtpVerifyScreen extends StatelessWidget {
  const PhoneOtpVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhoneOtpVerifyController>(
      init: PhoneOtpVerifyController(),
      builder: (controller) {
        return Scaffold(
          body: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 24.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.yellow),
                        borderRadius: BorderRadius.circular(10.sp),
                        color: Colors.white,
                      ),
                      child: Column(
                        spacing: 8.h,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Branding(),
                          SizedBox(height: 12.h),
                          AppText(
                            data: "Verify Your Phone Number",
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                          AppText(
                            data:
                                "We’ve sent a verification code to your Phone Number. Enter the code below to continue and secure your account.",
                            fontSize: 12.sp,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            height: 1.7,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),

                          AppText(
                            data: "We've Sent a Code to ${controller.phone}",
                            fontSize: 12.sp,
                            maxLines: 2,
                            fontWeight: FontWeight.w700,
                          ),

                          Obx(
                            () => KeyedSubtree(
                              key: ValueKey(controller.clearOtpField.value),
                              child: OtpTextField(
                                fieldWidth: 40.w,
                                fieldHeight: 50.h,
                                numberOfFields: 6, // Number of OTP fields
                                borderColor: AppColors
                                    .yellow, // Border color of the OTP field
                                showFieldAsBox:
                                    true, // Show fields as boxes (true for box style)
                                clearText: controller.clearOtpField.value,
                                onCodeChanged: (String code) {
                                  controller.otpTextEditingController.text =
                                      code;
                                },
                                alignment: Alignment.center,
                                contentPadding: EdgeInsets.all(0),
                                onSubmit: (String verificationCode) {
                                  controller.otpTextEditingController.text =
                                      verificationCode;
                                },
                                decoration: InputDecoration(
                                  filled:
                                      true, // Makes the background color of the text field filled
                                  fillColor: Colors
                                      .white, // Background color inside the box
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ), // Padding inside the box
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ), // Rounded corners for the box
                                    borderSide: BorderSide(
                                      color: AppColors.yellow, // Border color
                                      width: 2.0, // Border width
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ), // Rounded corners when focused
                                    borderSide: BorderSide(
                                      color: AppColors
                                          .yellow, // Focused border color
                                      width: 2.0, // Focused border thickness
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ), // Rounded corners for the enabled state
                                    borderSide: BorderSide(
                                      color: AppColors
                                          .yellow, // Border color when not focused
                                      width: 2.0,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ), // Rounded corners for error state
                                    borderSide: BorderSide(
                                      color: Colors.red, // Red border on error
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ), // Rounded corners on error focus
                                    borderSide: BorderSide(
                                      color: Colors
                                          .red, // Red focused error border color
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppText(
                                data: 'If you didn’t receive a code. ',
                                fontSize: 16.sp,
                              ),
                              Obx(
                                () => controller.canResend.value
                                    ? GestureDetector(
                                        onTap: () {
                                          // controller.verifyPhoneOtp();
                                        },
                                        child: Text(
                                          'Resend',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.yellow,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        controller.formatTime(),
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.yellow,
                                        ),
                                      ),
                              ),
                            ],
                          ),

                          Obx(() {
                            return AppButton(
                              isLoading: controller.isLoading.value,
                              isAuthButton: true,
                              titleSize: 18.sp,
                              title: "Verify and Continue",

                              onTap: () {
                                controller.verifyPhoneOtp();
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
