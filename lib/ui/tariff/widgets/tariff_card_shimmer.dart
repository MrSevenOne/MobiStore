import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TariffCardShimmer extends StatelessWidget {
  const TariffCardShimmer({super.key});

  Widget shimmerBox({double height = 16, double width = double.infinity, double radius = 8}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title shimmer
          shimmerBox(height: 20, width: 100),
          const SizedBox(height: 8),
          shimmerBox(height: 16, width: 80),

          const SizedBox(height: 28.0),

          /// Price shimmer
          Center(
            child: shimmerBox(height: 28, width: 150, radius: 12),
          ),

          const SizedBox(height: 24.0),

          /// Button shimmer
          shimmerBox(height: 48, radius: 15),

          const SizedBox(height: 18.0),

          /// Features shimmer
          Row(
            children: [
              shimmerBox(height: 20, width: 20, radius: 4),
              const SizedBox(width: 8),
              shimmerBox(height: 16, width: 180),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              shimmerBox(height: 20, width: 20, radius: 4),
              const SizedBox(width: 8),
              shimmerBox(height: 16, width: 160),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              shimmerBox(height: 20, width: 20, radius: 4),
              const SizedBox(width: 8),
              shimmerBox(height: 16, width: 140),
            ],
          ),
        ],
      ),
    );
  }
}
