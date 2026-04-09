import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/new_order/domain/model/cart_summary_model.dart';
import 'package:coffie/feature/new_order/presentation/controller/my_cart_controller.dart';
import 'package:coffie/feature/new_order/presentation/widget/payment_card.dart';
import 'package:coffie/feature/new_order/presentation/widget/product_cart_with_counter.dart.dart';
import 'package:coffie/feature/new_order/presentation/widget/reward_point_input.dart';
import 'package:coffie/feature/new_order/presentation/widget/support_baristas_widget.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyCartController>(
      init: MyCartController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(
            text: "My Cart",
            action: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.remove_shopping_cart_outlined,
                  color: AppColors.red.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
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
                  Obx(() {
                    return SupportBaristaWidget(
                      defaultValues: [5, 10, 15, 20],
                      totalAmount:
                          controller.cartSummary.value?.data?.totalPrice ?? 0,

                      /// optional
                      initialAmount:
                          controller.cartSummary.value?.data?.tipAmount
                              ?.toDouble() ??
                          0.0,
                      onApply: (percent, amount) {
                        controller.updateTipAndPoints(tipAmount: amount);
                      },
                    );
                  }),

                  Obx(() {
                    return RewardPointWidget(
                      minimumPoint:
                          controller
                              .cartSummary
                              .value
                              ?.data
                              ?.minimumLoyaltyPointsNeededToUse
                              ?.toInt() ??
                          0,
                      pointGiven:
                          (controller
                                      .cartSummary
                                      .value
                                      ?.data
                                      ?.redeemLoyaltyPoints ??
                                  0)
                              .toInt(),
                      points:
                          controller
                              .rewardController
                              .rewardPointModel
                              .value
                              ?.data
                              ?.loyaltyPoints ??
                          0,
                      onApply: (value) {
                        controller.updateTipAndPoints(
                          redeemLoyaltyPoints: value,
                        );
                      },
                    );
                  }),
                  Obx(() {
                    return SummaryCard(
                      cartSummary:
                          controller.cartSummary.value ?? CartSummaryModel(),
                    );
                  }),
                  Obx(() {
                    return PaymentCard(
                      walletAmount:
                          controller
                              .walletController
                              .walletBalanceModel
                              .value
                              ?.data
                              ?.balance ??
                          0,
                      giftCardAmount:
                          controller
                              .giftCardController
                              .giftCardBalanceModel
                              .value
                              ?.data
                              ?.totalBalance
                              ?.toDouble() ??
                          0,
                      totalPrice:
                          controller
                              .cartSummary
                              .value
                              ?.data
                              ?.totalPayableAmount ??
                          0,
                      onSelected: (value) {
                        // wallet / gift_card / stripe
                        controller.paymentMethod = value;
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Obx(() {
                return AppButton(
                  isLoading: controller.isPaymentProcessing.value,
                  onTap: () {
                    controller.placeOrder(
                      paymentMethod: controller.paymentMethod ?? "",
                      tipAmount: controller.cartSummary.value?.data?.tipAmount,
                      loyaltyPointsToUse: controller
                          .cartSummary
                          .value
                          ?.data
                          ?.redeemLoyaltyPoints
                          ?.toDouble(),
                    );
                  },
                  title: "Place Order",
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

class SummaryCard extends StatelessWidget {
  final CartSummaryModel cartSummary;
  const SummaryCard({super.key, required this.cartSummary});

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
          _buildSummaryItem(
            title: "Total Product Price",
            value: "+\$${cartSummary.data?.totalPrice ?? 0}",
          ),
          _buildSummaryItem(
            title: "Tip",
            value: "+\$${cartSummary.data?.tipAmount ?? 0}",
          ),
          _buildSummaryItem(
            title: "Rewards & Loyalty",
            value: "-${cartSummary.data?.redeemLoyaltyPoints ?? 0}p",
          ),
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
                data: "\$${cartSummary.data?.totalPayableAmount ?? 0}",
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
