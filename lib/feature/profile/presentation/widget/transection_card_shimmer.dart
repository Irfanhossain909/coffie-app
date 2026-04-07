import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TransactionCardShimmer extends StatelessWidget {
  const TransactionCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(seconds: 2),
      interval: const Duration(milliseconds: 300),
      color: Colors.white.withValues(alpha: 0.6), // glossy effect
      enabled: true,
      direction: const ShimmerDirection.fromLTRB(),
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _box(height: 16.h, width: 180.w),
            SizedBox(height: 8.h),
            Divider(color: Colors.white.withValues(alpha: 0.3)),

            SizedBox(height: 6.h),
            _row(),
            SizedBox(height: 6.h),
            _row(),
            SizedBox(height: 6.h),
            _row(),

            SizedBox(height: 8.h),
            Divider(color: Colors.white.withValues(alpha: 0.5)),

            SizedBox(height: 6.h),
            _row(isBold: true),
            SizedBox(height: 6.h),
            _row(),
            SizedBox(height: 6.h),
            _row(),
          ],
        ),
      ),
    );
  }

  Widget _row({bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _box(
          height: isBold ? 14.h : 12.h,
          width: isBold ? 120.w : 100.w,
        ),
        _box(
          height: isBold ? 14.h : 12.h,
          width: isBold ? 60.w : 50.w,
        ),
      ],
    );
  }

  Widget _box({required double height, required double width}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(6.r),
      ),
    );
  }
}