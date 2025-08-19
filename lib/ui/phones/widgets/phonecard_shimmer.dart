import 'package:flutter/material.dart';
import 'package:mobi_store/config/constants/shimmer_box.dart';

class PhoneCardShimmer extends StatelessWidget {
  const PhoneCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image placeholder
          Center(
            child: ShimmerBox(height: 100, width: double.infinity),
          ),
          const SizedBox(height: 8.0),

          // title placeholder
          ShimmerBox(radius: 4.0),
          const SizedBox(height: 6),

          // row placeholders
          ShimmerBox(radius: 4.0),

          const SizedBox(height: 6),
                   ShimmerBox(radius: 4.0,width: 100.0),

          const SizedBox(height: 6),
                   ShimmerBox(radius: 4.0,width: 80.0),


          const SizedBox(height: 12),
                    ShimmerBox(radius: 8.0,height: 36.0),
         
        ],
      ),
    );
  }
}
