import 'package:flutter/material.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/app_constants.dart';

class AdminInventoryCard extends StatelessWidget {
  const AdminInventoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 225,
      height: 190,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(
          AppConstants.borderRadius,
        ),
        border: Border.all(
          color: AppColor.border.withOpacity(.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColor.accentColor.withOpacity(.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  color: AppColor.accentColor,
                  size: 20,
                ),
              ),

              const SizedBox(width: 10),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الجرد اليومي',
                      style: TextStyle(
                        color: AppColor.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'جرد المخزون',
                      style: TextStyle(
                        color: AppColor.textSecondary,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

Flexible(child: Center(child: Icon(Icons.bar_chart_outlined,color: AppColor.mainColor,size: 25,))),
          // Description
          const Text(
            'راجع كميات المخزون اليوم.',
            style: TextStyle(
              color: AppColor.textSecondary,
              fontSize: 10,
            ),
          ),

          const SizedBox(height: 10),

          // Button
          SizedBox(
            height: 28,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.mainColor,
                foregroundColor: AppColor.textOnDark,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'فتح الجرد',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward,
                    size: 12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
