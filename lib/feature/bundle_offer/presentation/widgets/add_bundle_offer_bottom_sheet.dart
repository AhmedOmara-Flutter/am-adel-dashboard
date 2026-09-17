import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/entities/bundle_offer_entity.dart';
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

        return AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Stack(
            children: [
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'إنشاء باكدج جديد',
                          style: StyleManager.font23Weight700(
                            context,
                          ).copyWith(
                            color: AppColor.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'أضف تفاصيل الباكدج والصورة والسعر ليظهر العرض للعملاء.',
                          style: StyleManager.font14Weight600(
                            context,
                          ).copyWith(
                            color: AppColor.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
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

                              const SizedBox(height: 24),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'بيانات الباكدج',
                                    style: StyleManager.font16Weight700(
                                      context,
                                    ).copyWith(
                                      color: AppColor.textPrimary,
                                    ),
                                  ),

                                  const SizedBox(height: 18),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextFormField(
                                          keyboardType: TextInputType.text,
                                          autoValidateMode:
                                          AutovalidateMode
                                              .onUserInteraction,
                                          label: 'الاسم',
                                          controller: _titleController,
                                          hintText: 'مثال: وجبة العيلة',
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
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
                                          autoValidateMode:
                                          AutovalidateMode
                                              .onUserInteraction,
                                          label: 'السعر',
                                          controller: _priceController,
                                          hintText: '0.00',
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'أدخل سعر الباكدج';
                                            }

                                            final price = double.tryParse(
                                              value.trim(),
                                            );

                                            if (price == null) {
                                              return 'أدخل سعر صحيح';
                                            }

                                            if (price <= 0) {
                                              return 'السعر يجب أن يكون أكبر من صفر';
                                            }

                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 18),

                                  CustomTextFormField(
                                    keyboardType: TextInputType.text,
                                    autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                    label: 'الوصف',
                                    controller: _descriptionController,
                                    maxLines: 4,
                                    hintText:
                                    'اكتب مكونات العرض والتفاصيل الخاصة به...',
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'من فضلك أدخل وصف الباكدج';
                                      }

                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 18),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        CustomButton(
                          onPressed: isFormComplete && !isLoading
                              ? _addBundleOffer
                              : null,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: isFormComplete && !isLoading
                                ? 1
                                : .45,
                            child: Text(
                              'إضافة باكدج',
                              style: Theme
                                  .of(context)
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
                ),
              ),

              if (state is AddBundleOfferLoading)
                Positioned.fill(
                  child: AbsorbPointer(
                    absorbing: true,
                    child: Container(
                      color: AppColor.black.withOpacity(0.25),
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