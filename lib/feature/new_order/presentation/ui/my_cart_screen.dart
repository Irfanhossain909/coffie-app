import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_assets.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/feature/new_order/presentation/controller/shop_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopDetailsController>(
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(text: "My Cart"),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              child: Column(
                spacing: 18.h,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.yellow),
                    ),
                    width: double.infinity,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10.w,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: AppColors.yellow),
                          ),
                          child: AppImageCircular(
                            borderRadius: 8.r,
                            url:
                                "https://i.pinimg.com/736x/f0/4e/90/f04e90b671eccbde302107dc0a447135.jpg",
                            width: 99.w,
                            height: 93.h,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4.h,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    data: "Americano",
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  AppText(
                                    data: "45\$",
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ],
                              ),

                              AppText(
                                data: "Default Customization",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),

                              AppText(
                                data: "Pickup Time: Ready in 6 mins",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(height: 4.h),
                              Obx(() {
                                final bool isEnabled =
                                    controller.numberOfSyrupPumps.value > 0;
                                final bool maxEnabled =
                                    controller.numberOfSyrupPumps.value < 10;
                                return Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: 88.w,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: Colors
                                          .white, // shadow visible korar jonno background thaka better
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(
                                            0.08,
                                          ), // light shadow
                                          blurRadius: 8.r,
                                          spreadRadius: 1.r,
                                          offset: Offset(
                                            0,
                                            2,
                                          ), // soft bottom depth
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        isEnabled
                                            ? InkWell(
                                                onTap: controller
                                                    .decrementNumberOfSyrupPumps,
                                                child: Icon(
                                                  Icons.remove_rounded,
                                                  size: 14.w,
                                                  color: AppColors.black,
                                                ),
                                              )
                                            : Icon(
                                                Icons.remove_rounded,
                                                size: 14.w,
                                                color: AppColors.black
                                                    .withValues(alpha: 0.5),
                                              ),
                                        AppText(
                                          data: controller.numberOfSyrupPumps
                                              .toString(),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxEnabled
                                            ? InkWell(
                                                onTap: controller
                                                    .incrementNumberOfSyrupPumps,
                                                child: Icon(
                                                  Icons.add_rounded,
                                                  size: 14.w,
                                                  color: AppColors.black,
                                                ),
                                              )
                                            : Icon(
                                                Icons.add_rounded,
                                                size: 14.w,
                                                color: AppColors.black
                                                    .withValues(alpha: 0.5),
                                              ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.yellow),
                    ),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              data: "Support the Baristas",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            SvgPicture.asset(AppAssets.editNote),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          spacing: 8.w,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 18.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: AppColors.yellow),
                              ),
                              child: Center(
                                child: AppText(
                                  data: "40%",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 18.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: AppColors.yellow),
                              ),
                              child: Center(
                                child: AppText(
                                  data: "60%",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 18.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: AppColors.yellow),
                              ),
                              child: Center(
                                child: AppText(
                                  data: "80%",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 18.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: AppColors.yellow),
                              ),
                              child: Center(
                                child: AppText(
                                  data: "100%",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.yellow),
                    ),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              data: "Rewards & Loyalty",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            SvgPicture.asset(AppAssets.editNote),
                          ],
                        ),
                        SizedBox(height: 16.h),

                        AppInputWidgetTwo(
                          borderColor: AppColors.yellow,
                          prefix: SvgPicture.asset(AppAssets.rewardBox),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: AppText(
                              data: "100p",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hintText: "Reward Point ",
                        ),
                      ],
                    ),
                  ),
                  SummaryCard(),
                  PaymentCard(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: AppButton(title: "Place Order"),
            ),
          ),
        );
      },
    );
  }
}

class PaymentCard extends StatelessWidget {
  const PaymentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.yellow),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          AppText(
            data: "Select Payment Method",
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          _buildPaymentItem(
            icon: AppAssets.wallet,
            title: "COFFECITO Wallet Balance",
            value: "-\$25.00",
          ),
          _buildPaymentItem(
            icon: AppAssets.giftBox,
            title: "Digital Gift Card",
            value: "-\$10.00",
          ),
          _buildPaymentItem(
            proceShow: false,
            icon: AppAssets.stripe,
            title: "Continue With Stripe",
            value: "-\$10.00",
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentItem({
    required String icon,
    required String title,
    required String value,
    bool proceShow = true,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.yellow),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(icon, width: 20.w, height: 20.h),
          SizedBox(width: 8.w),
          AppText(data: title, fontSize: 14.sp, fontWeight: FontWeight.w400),
          Spacer(),
          if (proceShow)
            AppText(data: value, fontSize: 14.sp, fontWeight: FontWeight.w400),
        ],
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.yellow),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          AppText(
            data: "Order Summary",
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 16.h),
          _buildSummaryItem(title: "Total Product Price", value: "+\$10.99"),
          _buildSummaryItem(title: "Tip", value: "+\$05.99"),
          _buildSummaryItem(title: "Rewards & Loyalty", value: "-100p"),
          Divider(color: AppColors.black),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                data: "Total Amount",
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
              AppText(
                data: "\$5.99",
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(data: title, fontSize: 14.sp, fontWeight: FontWeight.w400),
        AppText(data: value, fontSize: 14.sp, fontWeight: FontWeight.w400),
      ],
    );
  }
}
