import 'dart:io';

import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/widgets/custom_sub_images.dart';
import 'package:am_adel_dashboard/feature/add_product/presentation/widgets/background_card.dart';

class ProductSubImagesSection extends StatelessWidget {
  final Function(List<File>) onImagesPicked;
  final List<String>? initialImages;

  const ProductSubImagesSection({
    super.key,
    required this.onImagesPicked, this.initialImages,
  });

  @override
  Widget build(BuildContext context) {
    return BackgroundCard(
      icon: Icons.photo_library_outlined,
      label: 'صور المنتج',
      subLabel: 'يمكنك اضافه اكثر من صوره للمنتج (4 صور فقط)',
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomSubImages(
          initialImages: initialImages,
          onImagesPicked: onImagesPicked,
        ),
      ),
    );
  }
}