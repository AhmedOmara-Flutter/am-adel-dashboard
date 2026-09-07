import 'dart:io';
import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/widgets/custom_image_picker.dart';
import 'package:am_adel_dashboard/feature/add_product/presentation/widgets/background_card.dart';

class ProductMainImageSection extends StatelessWidget {
  const ProductMainImageSection({
    super.key,
    required this.onImagePicked,
    this.initialImage,

  });

  final ValueChanged<File?> onImagePicked;
  final String? initialImage;

  @override
  Widget build(BuildContext context) {
    return BackgroundCard(
      label: 'الصوره الرئيسيه',
      icon: Icons.image_outlined,
      subLabel: 'اختر صوره واحده فقط لتكون الصوره الرئيسيه للمنتج',
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomImagePicker(
          initialImage: initialImage,
          onImagePicked: onImagePicked,
        ),
      ),
    );
  }
}