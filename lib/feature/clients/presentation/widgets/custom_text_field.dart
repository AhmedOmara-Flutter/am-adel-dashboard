
import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';

import '../../../../core/utils/app_color.dart';

class CustomTextField extends StatelessWidget {
  final bool readOnly;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  const CustomTextField({super.key,  this.readOnly=false, this.onTap, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        onChanged: onChanged,
        readOnly: readOnly,
        onTap: onTap,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: 'ابحث عن...',
          hintStyle: StyleManager.font13Weight600(context),
          prefixIcon: Icon(
            Icons.search,
            color: AppColor.mainColor,
          ),
          filled: true,
          fillColor: AppColor.card,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color:  AppColor.mainColor
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:  BorderSide(
                color:  AppColor.background
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:  BorderSide(
                color:   AppColor.mainColor
            ),
          ),
        ),
      ),
    );
  }
}
