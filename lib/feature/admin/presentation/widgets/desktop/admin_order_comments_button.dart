import 'package:flutter/material.dart';
import '../../../../../core/utils/app_color.dart';

class AdminOrderCommentsButton extends StatelessWidget {
  const AdminOrderCommentsButton({
    super.key,
    this.commentCount = 3,
    this.onTap,
  });

  final int commentCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      tooltip: 'تعليقات الطلبات',
      splashRadius: 22,
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(
            Icons.rate_review_outlined,
            color: AppColor.mainColor,
            size: 22,
          ),

          if (commentCount > 0)
            Positioned(
              right: -6,
              top: -6,
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColor.red,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColor.cardLight,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  '$commentCount',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
