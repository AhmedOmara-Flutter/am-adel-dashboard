import 'dart:io';

import 'package:am_adel_dashboard/core/entities/product_entity.dart';
import 'package:am_adel_dashboard/core/helper_function/custom_show_snake_bar.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/core/widgets/custom_button.dart';
import 'package:am_adel_dashboard/core/widgets/custom_image_picker.dart';
import 'package:am_adel_dashboard/core/widgets/custom_text_form_field.dart';
import 'package:am_adel_dashboard/feature/add_product/presentation/widgets/background_card.dart';
import 'package:am_adel_dashboard/feature/add_product/presentation/widgets/custom_is_featured.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_sub_images.dart';
import '../../../category/domain/entities/category_entity.dart';
import '../../../category/presentation/view_model/category_cubit.dart';
import '../../../main/presentation/view_model/main_cubit.dart';
import '../view_model/add_product_cubit.dart';

class AddProductViewBody extends StatefulWidget {
  const AddProductViewBody({super.key});

  @override
  State<AddProductViewBody> createState() => _AddProductViewBodyState();
}

class _AddProductViewBodyState extends State<AddProductViewBody> {
  late String name, code, description;
  late num price, expirationMonth, unitAmount, numberOfCalories;

  File? image;
  List<File>? subImagesFiles;

  bool isFeatured = false;

  AutovalidateMode autoValidateMode =
      AutovalidateMode.disabled;

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? selectedCategory;
  String? selectedSize;

  CategoryEntity? get currentCategory {
    if (selectedCategory == null) return null;

    final categoryCubit = context.read<CategoryCubit>();

    try {
      return categoryCubit.categories.firstWhere(
            (category) => category.id == selectedCategory,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductCubit, AddProductState>(
      listener: (context, state) {
        if (state is AddProductFailure) {
          customShowSnakeBar(
            context,
            color: Colors.red,
            label: state.errMessage,
          );
        }

        if (state is AddProductSuccess) {
          context.read<MainCubit>().changeIndex(0);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Form(
              key: _formKey,
              autovalidateMode: autoValidateMode,
              child: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: CustomScrollView(
                  slivers: [
                    buildMobileWidget(context),
                  ],
                ),
              ),
            ),
            if (state is AddProductLoading)
              Positioned.fill(
                child: AbsorbPointer(
                  absorbing: true,
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
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

  SliverToBoxAdapter buildMobileWidget(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BackgroundCard(
            label: 'معلومات المنتج',
            subLabel: 'البيانات الاساسيه للمنتج',
            icon: Icons.local_offer_outlined,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          label: 'اسم المنتج',
                          controller: nameController,
                          hintText: 'اكتب اسم المنتج',
                          onSaved: (value) {
                            name = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الحقل مطلوب';
                            }

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextFormField(
                          label: 'سعر المنتج',
                          controller: priceController,
                          hintText: 'اكتب سعر المنتج',
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            price = num.parse(value!);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الحقل مطلوب';
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'التصنيف',
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                          color: AppColor.mainColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const CircleAvatar(
                        backgroundColor: AppColor.red,
                        radius: 2,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  BlocBuilder<CategoryCubit, CategoryState>(
                    builder: (context, categoryState) {
                      final categoryCubit = context.watch<CategoryCubit>();
                      final categories = categoryCubit.categories;

                      if (categoryState is CategoryGetLoading &&
                          categories.isEmpty) {
                        return Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: AppColor.cardLight,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColor.divider,
                            ),
                          ),
                          child: const Center(
                            child: SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColor.accentColor,
                              ),
                            ),
                          ),
                        );
                      }

                      if (categories.isEmpty) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColor.cardLight,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColor.divider,
                            ),
                          ),
                          child: Text(
                            'لا توجد تصنيفات متاحة',
                            textAlign: TextAlign.center,
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                              color: AppColor.textSecondary,
                            ),
                          ),
                        );
                      }

                      return DropdownButtonFormField<String>(
                        initialValue: categories.any(
                              (category) => category.id == selectedCategory,
                        )
                            ? selectedCategory
                            : null,
                        hint: Text(
                          'اختر التصنيف',
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                            color: AppColor.textSecondary,
                          ),
                        ),
                        items: categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category.id,
                            child: Text(
                              category.name,
                              style: const TextStyle(
                                color: AppColor.textPrimary,
                              ),
                            ),
                          );
                        }).toList(),
                        dropdownColor: AppColor.cardLight,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(
                          color: AppColor.textPrimary,
                        ),
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColor.textSecondary,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor.cardLight,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColor.divider,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColor.accentColor,
                              width: 1.5,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColor.red,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColor.red,
                              width: 1.5,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value;
                            selectedSize = null;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'برجاء اختيار التصنيف';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          selectedCategory = value;
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 10),

                  if (currentCategory != null &&
                      currentCategory!.sizes.isNotEmpty) ...[
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Text(
                          'الحجم',
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const CircleAvatar(
                          backgroundColor: AppColor.red,
                          radius: 2,
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    DropdownButtonFormField<String>(
                      initialValue: currentCategory!.sizes.contains(
                          selectedSize)
                          ? selectedSize
                          : null,
                      hint: Text(
                        'اختر الحجم',
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                      items: currentCategory!.sizes.map((size) {
                        return DropdownMenuItem<String>(
                          value: size,
                          child: Text(
                            size,
                            style: const TextStyle(
                              color: AppColor.textPrimary,
                            ),
                          ),
                        );
                      }).toList(),
                      dropdownColor: AppColor.cardLight,
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(
                        color: AppColor.textPrimary,
                      ),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColor.textSecondary,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.cardLight,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColor.divider,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColor.accentColor,
                            width: 1.5,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColor.red,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColor.red,
                            width: 1.5,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedSize = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'برجاء اختيار الحجم';
                        }

                        return null;
                      },
                    ),
                  ],

                ],
              ),
            ),
          ),
          BackgroundCard(
            icon: Icons.settings_outlined,
            label: 'اعدادات اضافيه',
            subLabel: 'خصائص ومميزات المنتج',
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: descriptionController,
                    label: 'وصف المنتج',
                    hintText: 'اكتب وصف المنتج',
                    onSaved: (value) {
                      description = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الحقل مطلوب';
                      }

                      return null;
                    },
                    maxLines: 4,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomIsFeatured(
                          isFeatured: isFeatured,
                          onTap: () {
                            setState(() {
                              isFeatured = !isFeatured;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          BackgroundCard(
            label: 'الصوره الرئيسيه',
            icon: Icons.image_outlined,
            subLabel:
            'اختر صوره واحده فقط لتكون الصوره الرئيسيه للمنتج',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomImagePicker(
                    onImagePicked: (image) {
                      this.image = image;
                    },
                  ),
                ),
              ],
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
                onImagesPicked: (images) {
                  subImagesFiles = images;
                  debugPrint(
                    'Sub Images: ${subImagesFiles!.length}',
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          CustomButton(
            onPressed: () {
              setState(() {
                autoValidateMode = AutovalidateMode.always;
              });

              if (!_formKey.currentState!.validate()) {
                return;
              }

              _formKey.currentState!.save();

              if (image == null) {
                customShowSnakeBar(
                  context,
                  color: Colors.red,
                  label: 'برجاء ادخال صوره للمنتج',
                );
                return;
              }

              if (subImagesFiles == null) {
                customShowSnakeBar(
                  context,
                  color: Colors.red,
                  label: 'برجاء ادخال صور المنتج',
                );
                return;
              }

              if (selectedCategory == null) {
                customShowSnakeBar(
                  context,
                  color: Colors.red,
                  label: 'برجاء اختيار الصنف',
                );
                return;
              }

              final category = currentCategory;

              if (category == null) {
                customShowSnakeBar(
                  context,
                  color: Colors.red,
                  label: 'التصنيف المحدد غير موجود',
                );
                return;
              }

              final ProductEntity addProductEntity =
              ProductEntity(
                name: name,
                code: DateTime
                    .now()
                    .millisecondsSinceEpoch
                    .toString(),
                price: price,
                description: description,
                imageFile: image!,
                isFeatured: isFeatured,
                expirationMonth: 2,
                unitAmount: 100,
                numberOfCalories: 100,
                isOrganic: true,
                subImagesFiles: subImagesFiles!,
                category: category.name,
                size: selectedSize,
                createdAt: DateTime.now().toString(),
              );

              context
                  .read<AddProductCubit>()
                  .addProduct(addProductEntity);
            },
            child: Text(
              'اضافه المنتج',
              style: StyleManager.font15Weight800(context).copyWith(
                  color: AppColor.white),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
