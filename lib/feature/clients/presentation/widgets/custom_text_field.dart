import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:flutter/material.dart';

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
      height: 48,
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextFormField(
        onChanged: onChanged,
        readOnly: readOnly,
        onTap: onTap,
        cursorColor: AppColor.mainColor,
        style: StyleManager.font13Weight600(
          context,
        ).copyWith(
          color: AppColor.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: 'ابحث عن عميل...',
          hintStyle: StyleManager.font14Weight600(
            context,
          ).copyWith(
            color: AppColor.textSecondary.withOpacity(.55),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 14,
              end: 8,
            ),
            child: Icon(
              Icons.search_rounded,
              size: 20,
              color: AppColor.textSecondary.withOpacity(.7),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 46,
            minHeight: 48,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(
              end: 8,
            ),
            child: Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColor.backgroundDark.withOpacity(.45),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(
                Icons.tune_rounded,
                size: 17,
                color: AppColor.textSecondary,
              ),
            ),
          ),
          filled: true,
          fillColor: AppColor.cardLight,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 13,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: AppColor.mainColor.withOpacity(.25),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}