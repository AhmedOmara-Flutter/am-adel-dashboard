import 'package:am_adel_dashboard/core/helper_function/custom_show_snake_bar.dart';
import 'package:am_adel_dashboard/core/helper_function/make_call_function.dart';
import 'package:am_adel_dashboard/core/utils/app_imports.dart';
import 'package:flutter/services.dart';

import '../../../../core/helper_function/custom_show_dialog.dart';
import '../../../../core/helper_function/get_date_formate.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../data/models/order_review_model.dart';
import '../view_model/view_model/order_review_cubit.dart';

class OrderReviewCard extends StatelessWidget {
  const OrderReviewCard({required this.review});

  final OrderReviewModel review;

  @override
  Widget build(BuildContext context) {
    final name = review.customerName?.trim().isNotEmpty == true
        ? review.customerName!.trim()
        : 'عميل غير معروف';

    final phone = review.customerPhone?.trim() ?? '';

    return CustomContainer(
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColor.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.person_outline_rounded,
                        color: AppColor.secondaryColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StyleManager.font14Weight600(context)
                                .copyWith(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          if (phone.isNotEmpty)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    makePhoneCall(phone);
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.phone_outlined,
                                        size: 14,
                                        color: AppColor.textSecondary,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        phone,
                                        style: StyleManager.font12Weight500(
                                          context,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Spacer(),
                                // InkWell(
                                //   onTap: () {
                                //     Clipboard.setData(ClipboardData(text: phone));
                                //     customShowSnakeBar(
                                //       context,
                                //       color: AppColor.card,
                                //       label: 'تم نسخ رقم التليفون',
                                //     );
                                //   },
                                //   child: const Icon(
                                //     Icons.copy_rounded,
                                //     size: 17,
                                //     color: AppColor.secondaryColor,
                                //   ),
                                // ),
                              ],
                            )
                          else
                            const Text(
                              'رقم التليفون غير متاح',
                              style: TextStyle(
                                color: AppColor.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Divider(
                height: 1,
                color: AppColor.divider.withValues(alpha: 0.5),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.receipt_outlined,
                      size: 17,
                      color: AppColor.secondaryColor,
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        'طلب #${review.orderId}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColor.textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: AppColor.textSecondary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      getDateFormate(review.createdAt.toString()),
                      style: const TextStyle(
                        color: AppColor.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final food = _RatingSection(
                      title: 'تقييم الأكل',
                      icon: Icons.restaurant_outlined,
                      rating: review.foodRating,
                      comment: review.foodReview,
                    );

                    final driver = _RatingSection(
                      title: 'تقييم المندوب',
                      icon: Icons.delivery_dining_outlined,
                      rating: review.driverRating,
                      comment: review.driverReview,
                    );

                    if (constraints.maxWidth < 480) {
                      return Column(
                        children: [food, const SizedBox(height: 12), driver],
                      );
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: food),
                        const SizedBox(width: 12),
                        Expanded(child: driver),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 7),
              child: IconButton(
                tooltip: 'حذف التقييم',
                onPressed: () {
                  CustomShowDialog.show(
                    context,
                    title: 'حذف التقييم',
                    content: Text(
                      'هل أنت متأكد من حذف هذا التقييم؟',
                      style: StyleManager.font12Weight500(
                        context,
                      ).copyWith(height: 1.5, color: AppColor.textSecondary),
                    ),
                    cancel: () {
                      Navigator.pop(context);
                    },
                    accept: () async {
                      Navigator.pop(context);

                      await context.read<OrderReviewCubit>().deleteReview(
                        review.id!,
                      );
                    },
                    flag: Icons.delete_outline_rounded,
                    color: AppColor.red,
                  );
                },
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColor.red,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingSection extends StatelessWidget {
  const _RatingSection({
    required this.title,
    required this.icon,
    required this.rating,
    required this.comment,
  });

  final String title;
  final IconData icon;
  final int rating;
  final String comment;

  @override
  Widget build(BuildContext context) {
    final safeRating = rating.clamp(0, 5);
    final cleanComment = comment.trim();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.background.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.divider.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: AppColor.secondaryColor),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColor.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                '$safeRating/5',
                style: const TextStyle(
                  color: AppColor.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Icon(
                  index < safeRating
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                  color: AppColor.accentColor,
                  size: 18,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            cleanComment.isEmpty ? 'لا يوجد تعليق' : cleanComment,
            style: const TextStyle(
              color: AppColor.textSecondary,
              fontSize: 12,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
