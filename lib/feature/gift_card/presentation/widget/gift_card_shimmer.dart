import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class GiftCardShimmer extends StatelessWidget {
  const GiftCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.white,
          ),
          child: Row(
            children: [
              _buildShimmerBox(width: 80, height: 29),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildShimmerBox(width: 120, height: 14),
                    const SizedBox(height: 6),
                    _buildShimmerBox(width: 150, height: 10),
                    const SizedBox(height: 6),
                    _buildShimmerBox(width: 100, height: 10),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildShimmerBox(width: 50, height: 14),
                  const SizedBox(height: 8),
                  _buildShimmerBox(width: 60, height: 10),
                  const SizedBox(height: 8),
                  _buildShimmerBox(width: 70, height: 24),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// Reusable shimmer box with smooth animation
  Widget _buildShimmerBox({
    required double width,
    required double height,
  }) {
    return Shimmer(
      duration: const Duration(milliseconds: 200), // ✅ fast smooth cycle
      interval: const Duration(milliseconds: 200),
      color: Colors.grey.shade200,
      colorOpacity: 0.3,
      enabled: true,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}