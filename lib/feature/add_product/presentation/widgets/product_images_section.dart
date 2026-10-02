import 'dart:io';

import 'package:am_adel_dashboard/core/widgets/custom_image_picker.dart';
import 'package:am_adel_dashboard/core/widgets/custom_sub_images.dart';
import 'package:am_adel_dashboard/feature/add_product/presentation/widgets/background_card.dart';
import 'package:flutter/material.dart';

class ProductImagesSection extends StatelessWidget {
  const ProductImagesSection({
    super.key,
    required this.onImagePicked,
    required this.onImagesPicked,
  });

  final ValueChanged<File?> onImagePicked;
  final ValueChanged<List<File>> onImagesPicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BackgroundCard(
          label: 'الصوره الرئيسيه',
          icon: Icons.image_outlined,
          subLabel:
          'اختر صوره واحده فقط لتكون الصوره الرئيسيه للمنتج',
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: CustomImagePicker(
              onImagePicked: onImagePicked,
            ),
          ),
        ),
        BackgroundCard(
          icon: Icons.photo_library_outlined,
          label: 'صور المنتج',
          subLabel:
          'يمكنك اضافه اكثر من صوره للمنتج (4 صور فقط)',
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: CustomSubImages(
              onImagesPicked: onImagesPicked,
            ),
          ),
        ),
      ],
    );
  }
}