import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class _AddFlashOfferBottomSheetState
    extends State<AddFlashOfferBottomSheet> {
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
      FlashOfferEntity(
        imageUrl: selectedImage!,
        createdAt: DateTime.now(),
      ),
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

        return AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'إضافة Flash Offer',
                      style: StyleManager.font23Weight700(
                        context,
                      ).copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'اختر بانر العرض ليظهر في قسم العروض السريعة للعملاء.',
                      style: StyleManager.font14Weight600(
                        context,
                      ).copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColor.cardLight,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: AppColor.divider,
                        ),
                      ),
                      child: Column(
                        children: [
                          CustomImagePicker(
                            onImagePicked: (value) {
                              setState(() {
                                selectedImage = value;
                              });
                            },
                          ),

                          const SizedBox(height: 18),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.backgroundDark
                                  .withOpacity(.55),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 34,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    color: AppColor.mainColor
                                        .withOpacity(.10),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.flash_on_rounded,
                                    size: 19,
                                    color: AppColor.mainColor,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'يفضل استخدام صورة Banner أفقية قصيرة لتظهر بشكل احترافي داخل التطبيق.',
                                    style:
                                    StyleManager.font11Weight400(
                                      context,
                                    ).copyWith(
                                      color:
                                      AppColor.textSecondary,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    CustomButton(
                      onPressed:
                      isFormComplete && !isLoading
                          ? _addFlashOffer
                          : null,
                      child: AnimatedOpacity(
                        duration:
                        const Duration(milliseconds: 200),
                        opacity:
                        isFormComplete && !isLoading
                            ? 1
                            : .45,
                        child: Text(
                          'إضافة العرض',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                            color: AppColor.textOnDark,
                          ),
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
          ),
        );
      },
    );
  }
}