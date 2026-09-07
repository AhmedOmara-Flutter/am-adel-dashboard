import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';

class BuildCopyRight extends StatelessWidget {
  const BuildCopyRight({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 4,
      ),
      child: Column(
        children: [
          Container(
            width: 35,
            height: 2,
            decoration: BoxDecoration(
              color: AppColor.accentColor.withOpacity(.35),
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            'بيتزا سفيان',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColor.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            '© 2026 جميع الحقوق محفوظة',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColor.textSecondary.withOpacity(.7),
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}