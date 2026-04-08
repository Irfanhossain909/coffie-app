import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_assets.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/new_order/presentation/controller/my_cart_controller.dart';
import 'package:coffie/feature/new_order/presentation/widget/product_cart_with_counter.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyCartController>(
      init: MyCartController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(text: "My Cart"),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              child: Column(
                spacing: 18.h,
                children: [
                  Obx(() {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          controller.cartItem.value?.data?.items?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item =
                            controller.cartItem.value?.data?.items?[index];
                        return ProductCardWithCounter(
                          id: item?.product?.id ?? "",
                          name: item?.productName ?? "",
                          description: "Default Customization",
                          readyTime:
                              "Ready in ${item?.product?.readyTime} mins",
                          price: item?.unitFinalPrice ?? 0,
                          imageUrl:
                              "${AppApiEndPoint.domain}${item?.product?.image}",
                          initialQuantity: item?.quantity ?? 0,
                          onIncrement: (id, qty) {
                            controller.updateItemQuantity(
                              itemId: item?.id ?? "",
                              quantity: qty,
                            );
                          },
                          onDecrement: (id, qty) {
                            controller.updateItemQuantity(
                              itemId: item?.id ?? "",
                              quantity: qty,
                            );
                          },
                          onZero: (id) {
                            AppLogger.info("Item quantity is zero for $id");
                          },
                        );
                      },
                    );
                  }),
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
