import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class RewardDetailsShimmer extends StatelessWidget {
  const RewardDetailsShimmer({super.key});

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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Top Card
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  box(width: 90, height: 90, radius: 8),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        box(width: 120, height: 14),
                        const SizedBox(height: 6),
                        box(width: 160, height: 10),
                        const SizedBox(height: 6),
                        box(width: 140, height: 10),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      box(width: 20, height: 20),
                      const SizedBox(height: 10),
                      box(width: 40, height: 14),
                      const SizedBox(height: 10),
                      box(width: 80, height: 25, radius: 8),
                    ],
                  ),
                ],
              ),
            ),

            // 🔹 Order Info
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: List.generate(6, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        box(width: 100, height: 10),
                        box(width: 80, height: 10),
                      ],
                    ),
                  );
                }),
              ),
            ),

            // 🔹 Items
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  box(width: 140, height: 14),
                  const SizedBox(height: 10),
                  ...List.generate(3, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          box(width: 120, height: 10),
                          box(width: 50, height: 10),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 10),
                  box(width: double.infinity, height: 1),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      box(width: 100, height: 12),
                      box(width: 80, height: 12),
                    ],
                  ),
                ],
              ),
            ),

            // 🔹 Button
            box(width: double.infinity, height: 50, radius: 10),
          ],
        ),
      ),
    );
  }
}