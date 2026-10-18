import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_bottom_sheet_container.dart';
import '../../../../core/widgets/custom_bottom_sheet_loading_overlay.dart';
import '../../domain/entities/bundle_offer_entity.dart';
import '../../../../core/helper_function/custom_show_snake_bar.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_image_picker.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../view_model/add_bundle_offer_cubit/add_bundle_offer_cubit.dart';

class AddBundleOfferBottomSheet extends StatefulWidget {
  const AddBundleOfferBottomSheet({super.key});

  @override
  State<AddBundleOfferBottomSheet> createState() =>
      _AddBundleOfferBottomSheetState();
}

class _AddBundleOfferBottomSheetState
    extends State<AddBundleOfferBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController =
  TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  File? selectedImage;

  bool get _isFormComplete {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final price = double.tryParse(_priceController.text.trim());

    return selectedImage != null &&
        title.isNotEmpty &&
        description.isNotEmpty &&
        price != null &&
        price > 0;
  }

  @override
  void initState() {
    super.initState();

    _titleController.addListener(_onFormChanged);
    _descriptionController.addListener(_onFormChanged);
    _priceController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _titleController.removeListener(_onFormChanged);
    _descriptionController.removeListener(_onFormChanged);
    _priceController.removeListener(_onFormChanged);
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();

    super.dispose();
  }

  void _addBundleOffer() {
    FocusScope.of(context).unfocus();

    if (!_isFormComplete) {
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedImage == null) {
      customShowSnakeBar(
        context,
        color: AppColor.red,
        label: 'برجاء إدخال صورة للباكدج',
      );
      return;
    }

    final price = double.tryParse(
      _priceController.text.trim(),
    );

    if (price == null) {
      customShowSnakeBar(
        context,
        color: AppColor.red,
        label: 'برجاء إدخال سعر صحيح',
      );
      return;
    }

    context.read<AddBundleOfferCubit>().addBundleOffer(
      BundleOfferEntity(
        imageUrl: selectedImage!,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        price: price,
        createdAt: DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddBundleOfferCubit, AddBundleOfferState>(
      listener: (context, state) {
        if (state is AddBundleOfferFailure) {
          customShowSnakeBar(
            context,
            color: AppColor.red,
            label: state.errMessage,
          );
        }

        if (state is AddBundleOfferSuccess) {
          _titleController.clear();
          _descriptionController.clear();
          _priceController.clear();

          setState(() {
            selectedImage = null;
          });

          Navigator.pop(context);

          customShowSnakeBar(
            context,
            color: AppColor.green,
            label: 'تم إضافة الباكدج بنجاح',
          );
        }
      },
      builder: (context, state) {
        final isFormComplete = _isFormComplete;
        final isLoading = state is AddBundleOfferLoading;


        return Stack(
          children: [
            CustomBottomSheetContainer(
              title: 'إضافة باكدج جديد',
              subtitle: 'أضف الصورة والاسم والسعر والتفاصيل.',
              icon: Icons.card_giftcard_rounded,
              maxHeightFactor: 0.9,
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 20),
              headerSpacing: 18,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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

                    Text(
                      'بيانات الباكدج',
                      style: StyleManager.font14Weight600(context).copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            keyboardType: TextInputType.text,
                            autoValidateMode: AutovalidateMode.onUserInteraction,
                            label: 'اسم الباكدج',
                            controller: _titleController,
                            hintText: 'مثال: وجبة العيلة',
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'أدخل اسم الباكدج';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextFormField(
                            keyboardType:
                            const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            autoValidateMode: AutovalidateMode.onUserInteraction,
                            label: 'السعر',
                            controller: _priceController,
                            hintText: '0.00',
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'أدخل السعر';
                              }

                              final price = double.tryParse(value.trim());

                              if (price == null || price <= 0) {
                                return 'أدخل سعرًا صحيحًا';
                              }

                              return null;
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    CustomTextFormField(
                      keyboardType: TextInputType.text,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      label: 'وصف الباكدج',
                      controller: _descriptionController,
                      maxLines: 3,
                      hintText: 'اكتب مكونات الباكدج...',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'أدخل وصف الباكدج';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 22),

                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: CustomButton(
                        onPressed: isFormComplete && !isLoading
                            ? _addBundleOffer
                            : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_rounded,
                              color: AppColor.textOnDark,
                              size: 19,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'إضافة الباكدج',
                              style: StyleManager.font14Weight600(context).copyWith(
                                color: AppColor.textOnDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (isLoading)
              CustomBottomSheetLoadingOverlay(),
          ],
        );
      },
    );
  }
}