import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class QuantitySelector extends StatelessWidget {
  final String title;
  final String message;
  final RxInt quantity;
  final int min;
  final int max;
  final ValueChanged<int>? onChanged;

  const QuantitySelector({
    super.key,
    required this.title,
    required this.message,
    required this.quantity,
    this.min = 0,
    this.max = 10,
    this.onChanged,
  });

  void _increment() {
    if (quantity.value < max) {
      quantity.value++;
      onChanged?.call(quantity.value);
    }
  }

  void _decrement() {
    if (quantity.value > min) {
      quantity.value--;
      onChanged?.call(quantity.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 Title
        AppText(
          data: title,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),

        SizedBox(height: 8.h),

        /// 🔹 Container
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.yellow),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 🔸 Message
              AppText(
                data: message,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),

              /// 🔸 Counter
              Obx(() {
                final bool canDecrement = quantity.value > min;
                final bool canIncrement = quantity.value < max;

                return Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8.r,
                        spreadRadius: 1.r,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// ➖ Decrement
                      InkWell(
                        onTap: canDecrement ? _decrement : null,
                        child: Icon(
                          Icons.remove_rounded,
                          size: 20.w,
                          color: canDecrement
                              ? AppColors.black
                              : AppColors.black.withValues(alpha: 0.5),
                        ),
                      ),

                      /// 🔢 Value
                      AppText(
                        data: quantity.value.toString(),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                      ),

                      /// ➕ Increment
                      InkWell(
                        onTap: canIncrement ? _increment : null,
                        child: Icon(
                          Icons.add_rounded,
                          size: 20.w,
                          color: canIncrement
                              ? AppColors.black
                              : AppColors.black.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}