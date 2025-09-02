import 'package:flutter/material.dart';
import 'package:mobi_store/config/constants/shimmer_box.dart';
import 'package:shimmer/shimmer.dart';

class TariffCardShimmer extends StatelessWidget {
  const TariffCardShimmer({super.key});



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
          ShimmerBox(height: 20, width: 100),
          const SizedBox(height: 8),
          ShimmerBox(height: 16, width: 80),

          const SizedBox(height: 28.0),

          /// Price shimmer
          Center(
            child: ShimmerBox(height: 28, width: 150, radius: 12),
          ),

          const SizedBox(height: 24.0),

          /// Button shimmer
          ShimmerBox(height: 48, radius: 15),

          const SizedBox(height: 18.0),

          /// Features shimmer
          Row(
            children: [
              ShimmerBox(height: 20, width: 20, radius: 4),
              const SizedBox(width: 8),
              ShimmerBox(height: 16, width: 180),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ShimmerBox(height: 20, width: 20, radius: 4),
              const SizedBox(width: 8),
              ShimmerBox(height: 16, width: 160),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ShimmerBox(height: 20, width: 20, radius: 4),
              const SizedBox(width: 8),
              ShimmerBox(height: 16, width: 140),
            ],
          ),
        ],
      ),
    );
  }
}
