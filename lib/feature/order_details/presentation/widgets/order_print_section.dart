import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';

class OrderPrintSection extends StatelessWidget {
  final VoidCallback? onPressed;

  const OrderPrintSection({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColor.divider.withOpacity(.55),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.025),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 500;

          final content = Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColor.mainColor.withOpacity(.09),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.print_outlined,
                  color: AppColor.mainColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'طباعة الطلب',
                      style: StyleManager.font14Weight600(
                        context,
                      ).copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'طباعة الفاتورة وتفاصيل الطلب',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font11Weight400(
                        context,
                      ).copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              _PrintButton(
                onPressed: onPressed,
              ),
            ],
          );

          if (!compact) {
            return content;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColor.mainColor.withOpacity(.09),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.print_outlined,
                      color: AppColor.mainColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'طباعة الطلب',
                          style: StyleManager.font14Weight600(
                            context,
                          ).copyWith(
                            color: AppColor.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'طباعة الفاتورة وتفاصيل الطلب',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleManager.font11Weight400(
                            context,
                          ).copyWith(
                            color: AppColor.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 13),
              _PrintButton(
                onPressed: onPressed,
                expanded: true,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PrintButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool expanded;

  const _PrintButton({
    required this.onPressed,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: expanded ? double.infinity : null,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(
          Icons.print_rounded,
          size: 17,
        ),
        label: Text(
          'طباعة الطلب',
          style: StyleManager.font13Weight600(
            context,
          ).copyWith(
            color: AppColor.textOnDark,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.mainColor,
          foregroundColor: AppColor.textOnDark,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
