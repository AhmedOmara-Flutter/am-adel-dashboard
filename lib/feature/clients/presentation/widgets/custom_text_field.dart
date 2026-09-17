import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';

import '../../../../core/utils/app_color.dart';

class CustomTextField extends StatelessWidget {
  final bool readOnly;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        onChanged: onChanged,
        readOnly: readOnly,
        onTap: onTap,
        cursorColor: AppColor.mainColor,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: AppColor.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: 'ابحث عن...',
          hintStyle: StyleManager.font13Weight600(context).copyWith(
            color: AppColor.textSecondary.withOpacity(.75),
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: AppColor.backgroundDark,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.search_rounded,
              color: AppColor.mainColor,
              size: 20,
            ),
          ),
          filled: true,
          fillColor: AppColor.cardLight,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColor.divider,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColor.divider,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColor.mainColor,
              width: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}