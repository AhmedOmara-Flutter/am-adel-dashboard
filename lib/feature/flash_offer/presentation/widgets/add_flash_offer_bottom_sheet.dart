import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_bottom_sheet_container.dart';
import '../../domain/entities/flash_offer_entity.dart';
import '../../../../core/helper_function/custom_show_snake_bar.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_image_picker.dart';
import '../view_model/add_flash_offer_cubit/add_flash_offer_cubit.dart';

class AddFlashOfferBottomSheet extends StatefulWidget {
  const AddFlashOfferBottomSheet({super.key});

  @override
  State<AddFlashOfferBottomSheet> createState() =>
      _AddFlashOfferBottomSheetState();
}

class _AddFlashOfferBottomSheetState extends State<AddFlashOfferBottomSheet> {
  File? selectedImage;
  bool get _isFormComplete => selectedImage != null;

  void _addFlashOffer() {
    FocusScope.of(context).unfocus();

    if (selectedImage == null) {
      customShowSnakeBar(
        context,
        color: AppColor.red,
        label: 'برجاء اختيار صورة للعرض',
      );
      return;
    }

    context.read<AddFlashOfferCubit>().addFlashOffer(
      FlashOfferEntity(imageUrl: selectedImage!, createdAt: DateTime.now()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddFlashOfferCubit, AddFlashOfferState>(
      listener: (context, state) {
        if (state is AddFlashOfferFailure) {
          customShowSnakeBar(
            context,
            color: AppColor.red,
            label: state.errMessage,
          );
        }

        if (state is AddFlashOfferSuccess) {
          setState(() {
            selectedImage = null;
          });

          Navigator.pop(context);

          customShowSnakeBar(
            context,
            color: AppColor.green,
            label: 'تم إضافة العرض بنجاح',
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AddFlashOfferLoading;
        final isFormComplete = _isFormComplete;
        return Stack(
          children: [
            CustomBottomSheetContainer(
              title: 'إضافة Flash Offer',
              subtitle: 'اختر بانر العرض ليظهر في قسم العروض السريعة للعملاء.',
              icon: Icons.flash_on_rounded,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImagePicker(
                    onImagePicked: (value) {
                      setState(() {
                        selectedImage = value;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: CustomButton(
                      onPressed: isFormComplete && !isLoading
                          ? _addFlashOffer
                          : null,
                      child: Text(
                        'إضافة العرض',
                        style: StyleManager.font14Weight600(
                          context,
                        ).copyWith(color: AppColor.textOnDark),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (isLoading)
              Positioned.fill(
                child: AbsorbPointer(
                  absorbing: true,
                  child: Container(
                    color: AppColor.black.withOpacity(.25),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.mainColor,
                      ),
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
