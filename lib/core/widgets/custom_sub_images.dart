import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/app_color.dart';

class CustomSubImages extends StatefulWidget {
  final ValueChanged<List<File>> onImagesPicked;
  final List<String>? initialImages;

  const CustomSubImages({
    super.key,
    required this.onImagesPicked,
    this.initialImages,
  });

  @override
  State<CustomSubImages> createState() => _CustomSubImagesState();
}

class _CustomSubImagesState extends State<CustomSubImages> {
  final List<File> newImages = [];
  late List<String> oldImages;
  @override
  void initState() {
    super.initState();
    oldImages = widget.initialImages ?? [];
  }
  int get totalCount => oldImages.length + newImages.length;

  Future<void> pickImages() async {
    try {
      final ImagePicker picker = ImagePicker();

      final List<XFile> pickedImages =
      await picker.pickMultiImage();

      if (pickedImages.isEmpty) return;

      final int remaining = 4 - totalCount;
      if (remaining <= 0) return;

      final selectedImages = pickedImages.take(remaining);

      newImages.addAll(
        selectedImages.map((e) => File(e.path)),
      );

      widget.onImagesPicked(newImages);
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void removeImage(int index) {
    if (index < oldImages.length) {
      oldImages.removeAt(index);
    } else {
      newImages.removeAt(index - oldImages.length);
    }

    widget.onImagesPicked(newImages);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final bool hasImage = index < totalCount;

        if (!hasImage) {
          return GestureDetector(
            onTap: pickImages,
            child: DottedBorder(
              color: AppColor.border,
              strokeWidth: 2,
              dashPattern: const [8, 4],
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.card ,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      color: AppColor.mainColor,
                      size: 35,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'اضافه صورة',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(
                        color: AppColor.mainColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final bool isOldImage = index < oldImages.length;

        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: isOldImage
                    ? Image.network(
                  oldImages[index],
                  fit: BoxFit.cover,
                )
                    : Image.file(
                  newImages[index - oldImages.length],
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned(
              top: 6,
              right: 6,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.white,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => removeImage(index),
                  icon: const Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}