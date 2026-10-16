
import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import 'package:am_adel_dashboard/core/helper_function/get_date_formate.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/core/widgets/custom_container.dart';
import 'package:flutter/material.dart';

class DailyReportHeader extends StatelessWidget {
  const DailyReportHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final date = getDateFormate(DateTime.now().toString());

    return context.isPhone
        ? _buildPhoneHeader(context, date)
        : _buildDesktopHeader(context, date);
  }

  Widget _buildDesktopHeader(BuildContext context, String date) {
    return CustomContainer(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: AppColor.mainColor.withOpacity(.08),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.assessment_rounded,
                  color: AppColor.mainColor,
                  size: 29,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'جرد اليوم',
                      style: StyleManager.font18Weight700(context).copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'ملخص حركة المبيعات والحسابات اليومية',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font12Weight500(context).copyWith(
                        color: AppColor.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _buildTodayBadge(context),
            ],
          ),
          const SizedBox(height: 20),
          Divider(
            height: 1,
            color: AppColor.divider.withOpacity(.4),
          ),
          const SizedBox(height: 16),
          _buildDateRow(context, date),
        ],
      ),
    );
  }

  Widget _buildPhoneHeader(BuildContext context, String date) {
    return CustomContainer(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColor.mainColor.withOpacity(.09),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.assessment_rounded,
                  color: AppColor.mainColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'جرد اليوم',
                      style: StyleManager.font18Weight700(context).copyWith(
                        color: AppColor.textPrimary,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ملخص المبيعات والحسابات',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font12Weight500(context).copyWith(
                        color: AppColor.textSecondary,
                        fontSize: 11,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _buildTodayBadge(context, compact: true),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
            height: 1,
            color: AppColor.divider.withOpacity(.4),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(
                Icons.calendar_month_rounded,
                color: AppColor.mainColor,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  date,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font12Weight500(context).copyWith(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: AppColor.green.withOpacity(.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: AppColor.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 7),
                  Text(
                    'تقرير يومي',
                    style: StyleManager.font11Weight400(context).copyWith(
                      color: AppColor.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayBadge(
      BuildContext context, {
        bool compact = false,
      })
  {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 9 : 12,
        vertical: compact ? 8 : 9,
      ),
      decoration: BoxDecoration(
        color: AppColor.mainColor.withOpacity(.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.mainColor.withOpacity(.14),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.today_rounded,
            color: AppColor.mainColor,
            size: compact ? 15 : 17,
          ),
          SizedBox(width: compact ? 5 : 7),
          Text(
            'اليوم',
            style: StyleManager.font12Weight500(context).copyWith(
              color: AppColor.mainColor,
              fontWeight: FontWeight.w700,
              fontSize: compact ? 11 : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateRow(BuildContext context, String date) {
    return Row(
      children: [
        Icon(
          Icons.calendar_month_rounded,
          color: AppColor.mainColor,
          size: 18,
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            date,
            style: StyleManager.font12Weight500(context).copyWith(
              color: AppColor.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppColor.green,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 7),
        Text(
          'تقرير يومي',
          style: StyleManager.font11Weight400(context).copyWith(
            color: AppColor.textSecondary,
          ),
        ),
      ],
    );
  }
}
