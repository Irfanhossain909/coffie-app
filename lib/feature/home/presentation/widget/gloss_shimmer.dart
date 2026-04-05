import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class GlossShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  const GlossShimmer({
    super.key,
    this.height,
    this.width,
    this.borderRadius = 12,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height ?? 230.h, // ✅ default height
      width: width ?? double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius.r),
        child: Shimmer(
          duration: const Duration(seconds: 2),
          interval: const Duration(milliseconds: 300),
          color: Colors.white,
          colorOpacity: 0.4,
          enabled: true,
          direction: const ShimmerDirection.fromLTRB(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.grey.shade100,
                  Colors.white,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}