import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';

class CustomImagePicker extends StatefulWidget {
  final ValueChanged<File?> onImagePicked;
  final String? initialImage;

  const CustomImagePicker({
    super.key,
    required this.onImagePicked,
    this.initialImage,
  });

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File? imagePath;
  String? networkImage;
  bool imageLoadFailed = false;

  @override
  void initState() {
    super.initState();
    networkImage = widget.initialImage;
  }

  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();

      final image = await picker.pickImage(source: ImageSource.gallery);

      if (image == null) return;

      setState(() {
        imagePath = File(image.path);
        networkImage = null;
        imageLoadFailed = false;
      });

      widget.onImagePicked(imagePath);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void removeImage() {
    setState(() {
      imagePath = null;
      networkImage = null;
      imageLoadFailed = false;
    });

    widget.onImagePicked(null);
  }

  @override
  Widget build(BuildContext context) {
    final bool hasNetworkImage = networkImage != null && !imageLoadFailed;

    return GestureDetector(
      onTap: pickImage,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColor.inputFill,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: imagePath != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * .2,
                width: double.infinity,
                child: Image.file(imagePath!, fit: BoxFit.cover),
              ),
            )
                : hasNetworkImage
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * .2,
                width: double.infinity,
                child: Image.network(
                  networkImage!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted && !imageLoadFailed) {
                        setState(() {
                          imageLoadFailed = true;
                        });
                      }
                    });

                    return _buildMissingImage(context);
                  },
                ),
              ),
            )
                : imageLoadFailed
                ? _buildMissingImage(context)
                : _buildEmptyState(context),
          ),

          if (imagePath != null || hasNetworkImage)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColor.background,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: removeImage,
                  icon: const Icon(
                    Icons.close,
                    color: AppColor.textSecondary,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMissingImage(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .2,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.image_not_supported_outlined,
            color: AppColor.textSecondary,
            size: 45,
          ),
          const SizedBox(height: 10),
          Text(
            'الصورة غير موجودة',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColor.textSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'اضغط لاختيار صورة جديدة',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColor.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const Icon(
          Icons.add_photo_alternate_outlined,
          color: AppColor.mainColor,
          size: 40,
        ),
        const SizedBox(height: 10),
        Text(
          'اضافة صورة',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: AppColor.mainColor),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}