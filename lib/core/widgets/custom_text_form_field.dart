import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  final int? maxLines;
  final String? label;
  final bool readOnly;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.validator,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.onSaved,
    this.onChanged,
    this.onFieldSubmitted,
    this.maxLines,
    this.labelText,
    this.label,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (label != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                  label!,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColor.mainColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const CircleAvatar(
                backgroundColor: AppColor.red,
                radius: 2,
              ),
            ],
          ),

        if (label != null) const SizedBox(height: 8),

        TextFormField(
          readOnly: readOnly,
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          onSaved: onSaved,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          autovalidateMode: autoValidateMode,
          validator: validator,

          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColor.textPrimary,
          ),

          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,

            hintStyle: const TextStyle(
              color: AppColor.textSecondary,
              fontSize: 14,
            ),

            labelStyle: const TextStyle(
              color: AppColor.textSecondary,
              fontSize: 14,
            ),

            filled: true,
            fillColor: AppColor.card,

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColor.border,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColor.mainColor,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColor.red,
              ),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColor.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}