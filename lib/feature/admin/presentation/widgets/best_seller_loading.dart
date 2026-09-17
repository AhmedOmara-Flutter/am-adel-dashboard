import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';

class BestSellerLoading extends StatelessWidget {
  const BestSellerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),

            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Image.asset(Assets.assets.images.img.path),
            ),
          ),

          const SizedBox(width: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),

            child: Container(
              width: 47,
              height: 47,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(Assets.assets.images.img.path),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 12,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 6),
                Container(height: 10, width: 80, color: Colors.grey.shade200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

