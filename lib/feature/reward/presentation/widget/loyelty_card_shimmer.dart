import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class LoyaltyCardShimmer extends StatelessWidget {
  const LoyaltyCardShimmer({super.key});

  Widget box({double? width, double? height, double radius = 6}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(milliseconds: 800),
      interval: const Duration(milliseconds: 200),
      color: Colors.white,
      colorOpacity: 0.3,
      enabled: true,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            // Image
            box(width: 40, height: 40, radius: 20),

            const SizedBox(width: 10),

            // Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  box(width: 120, height: 14),
                  const SizedBox(height: 6),
                  box(width: 160, height: 10),
                  const SizedBox(height: 6),
                  box(width: 100, height: 10),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // Right side
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                box(width: 40, height: 14),
                const SizedBox(height: 10),
                box(width: 80, height: 25, radius: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}