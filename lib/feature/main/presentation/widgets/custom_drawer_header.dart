import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import '../../../../core/extension/responsive_extension.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../generated/assets.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return context.isDesktop
        ? const CustomDrawerHeaderDesktop()
        : const CustomDrawerHeaderMobile();
  }
}

class CustomDrawerHeaderDesktop extends StatelessWidget {
  const CustomDrawerHeaderDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.cardLight,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              child: Image.asset(
                Assets.assets.images.amAdelPerson.path,
                fit: BoxFit.cover,
              ),
            ),
            Image.asset(
              Assets.assets.images.amAdel.path,
              color: AppColor.mainColor,
              height: 95,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDrawerHeaderMobile extends StatelessWidget {
  const CustomDrawerHeaderMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        border: Border(
          bottom: BorderSide(
            color: AppColor.divider.withOpacity(.65),
          ),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColor.backgroundDark,
            backgroundImage: AssetImage(
              Assets.assets.images.amAdelLogo.path,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'صباح الخير 👋',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppColor.textSecondary,
                    fontSize: responsiveFontSize(
                      context,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'مهندس احمد عماره',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: responsiveFontSize(
                      context,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}