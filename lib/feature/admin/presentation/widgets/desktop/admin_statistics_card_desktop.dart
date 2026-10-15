import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/core/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import '../../../../../core/models/statistics_card_model.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/widgets/icon_badge.dart';

class AdminStatisticsCardDesktop extends StatefulWidget {
  final StatisticsCardModel model;

  const AdminStatisticsCardDesktop({super.key, required this.model});

  @override
  State<AdminStatisticsCardDesktop> createState() =>
      _AdminStatisticsCardDesktopState();
}

class _AdminStatisticsCardDesktopState
    extends State<AdminStatisticsCardDesktop> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final model = widget.model;
    final radius = AppConstants.borderRadius;

    return MouseRegion(
      cursor: model.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: SizedBox(
        height: model.height + 8,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            height: model.height + (_isHovered ? 4 : 0),
            transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0),
            child: CustomContainer(
              color: _isHovered ? AppColor.background : AppColor.cardLight,
              borderRadius: radius,
              borderColor: _isHovered
                  ? AppColor.accentColor.withOpacity(.65)
                  : AppColor.divider.withOpacity(.25),
              borderWidth: _isHovered ? 1.3 : 1,
              onTap: model.onTap,
              hoverColor: Colors.transparent,
              splashColor: AppColor.accentColor.withOpacity(.06),
              highlightColor: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconBadge(icon: model.icon, iconColor: model.iconColor),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Text(
                          model.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleManager.font12Weight500(context).copyWith(
                            color: AppColor.textPrimary,
                            fontSize: responsiveFontSize(context, fontSize: 11),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          model.subTitleNumber,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleManager.font18Weight700(context).copyWith(
                            color: AppColor.mainColor,
                            fontSize: responsiveFontSize(context, fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          model.subTitleText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                          style: StyleManager.font11Weight400(context).copyWith(
                            color: AppColor.textSecondary.withOpacity(.80),
                            fontSize: responsiveFontSize(context, fontSize: 9),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
