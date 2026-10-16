
import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';

enum AppBarButtonType {
  back,
  menu,
  none,
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final Color? titleColor;
  final AppBarButtonType buttonType;
  final VoidCallback? onMenuPressed;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor,
    this.titleColor,
    this.buttonType = AppBarButtonType.back,
    this.onMenuPressed,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColor.background,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: buttonType == AppBarButtonType.none
          ? null
          : CustomAppBarLeadingButton(
        icon: buttonType == AppBarButtonType.menu
            ? Icons.menu_rounded
            : Icons.arrow_back_ios_new_outlined,
        onTap: () {
          if (buttonType == AppBarButtonType.menu) {
            onMenuPressed?.call();
          } else if (buttonType == AppBarButtonType.back &&
              Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
          color: titleColor ?? AppColor.mainColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
    );
  }
}

class CustomAppBarLeadingButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;

  const CustomAppBarLeadingButton({
    super.key,
    this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        color: AppColor.mainColor,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Center(
            child: Icon(
              icon,
              color: AppColor.white,
              size: 17,
            ),
          ),
        ),
      ),
    );
  }
}
