import 'dart:io';
import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:image_picker/image_picker.dart';

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

  @override
  void initState() {
    super.initState();
    networkImage = widget.initialImage;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          final picker = ImagePicker();
          final image = await picker.pickImage(
            source: ImageSource.gallery,
          );

          if (image != null) {
            setState(() {
              imagePath = File(image.path);
              widget.onImagePicked(imagePath);
            });
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColor.cardLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColor.divider,
              ),
            ),
            alignment: Alignment.center,
            child: imagePath != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * .2,
                child: Image.file(
                  imagePath!,
                  fit: BoxFit.cover,
                ),
              ),
            )
                : networkImage != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * .2,
                child: Image.network(
                  networkImage!,
                  fit: BoxFit.cover,
                ),
              ),
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Icon(
                  Icons.add_photo_alternate_outlined,
                  color: AppColor.mainColor,
                  size: 40,
                ),
                SizedBox(height: 10),
                Text(
                  'اضافة صورة',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                    color: AppColor.mainColor,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          if (imagePath != null || networkImage != null)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColor.background,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      imagePath = null;
                      networkImage = null;
                      widget.onImagePicked(null);
                    });
                  },
                  icon: Icon(
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
}