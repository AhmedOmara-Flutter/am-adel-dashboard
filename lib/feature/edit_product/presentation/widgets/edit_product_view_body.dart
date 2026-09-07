import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/core/entities/product_entity.dart';
import 'package:am_adel_dashboard/core/helper_function/custom_show_snake_bar.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/core/widgets/custom_button.dart';
import 'package:am_adel_dashboard/core/widgets/custom_image_picker.dart';
import 'package:am_adel_dashboard/core/widgets/custom_sub_images.dart';
import 'package:am_adel_dashboard/feature/add_product/presentation/widgets/background_card.dart';
import 'package:am_adel_dashboard/feature/add_product/presentation/widgets/custom_is_featured.dart';
import 'package:am_adel_dashboard/feature/category/domain/entities/category_entity.dart';
import 'package:am_adel_dashboard/feature/category/presentation/view_model/category_cubit.dart';
import '../../../../core/cubit/offers_cubit/offers_cubit.dart';
import '../../../../core/cubit/products_cubit/update_product/update_product_cubit.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class EditProductViewBody extends StatefulWidget {
  final ProductEntity product;

  const EditProductViewBody({super.key, required this.product});

  @override
  State<EditProductViewBody> createState() => _EditProductViewBodyState();
}

class _EditProductViewBodyState extends State<EditProductViewBody> {
  File? image;
  List<File>? subImagesFiles;

  bool isFeatured = false;

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? selectedCategory;
  String? selectedSize;

  CategoryEntity? get currentCategory {
    final categoryCubit = context.read<CategoryCubit>();
    final categories = categoryCubit.categories;

    if (categories.isEmpty) {
      return null;
    }

    if (selectedCategory != null) {
      try {
        return categories.firstWhere(
          (category) => category.id == selectedCategory,
        );
      } catch (_) {}
    }

    try {
      return categories.firstWhere(
        (category) => category.name == widget.product.category,
      );
    } catch (_) {
      return null;
    }
  }

  String? get selectedCategoryId {
    if (selectedCategory != null) {
      return selectedCategory;
    }

    final categoryCubit = context.read<CategoryCubit>();

    try {
      return categoryCubit.categories
          .firstWhere((category) => category.name == widget.product.category)
          .id;
    } catch (_) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    final product = widget.product;

    nameController.text = product.name;
    priceController.text = product.price.toString();
    descriptionController.text = product.description;

    selectedSize = product.size;
    isFeatured = product.isFeatured;

    image = null;
    subImagesFiles = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateProductCubit, UpdateProductState>(
      listener: (context, state) {
        if (state is UpdateProductError) {
          customShowSnakeBar(
            context,
            color: Colors.red,
            label: state.errMessage,
          );
        }

        if (state is UpdateProductSuccess) {
          customShowSnakeBar(
            context,
            color: Colors.green,
            label: 'تم التعديل بنجاح',
          );

          Future.delayed(const Duration(milliseconds: 300), () {
            if (context.mounted) {
              Navigator.pop(context);
            }
          });
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
                child: CustomScrollView(slivers: [buildMobileWidget(context)]),
              ),
            ),
            if (state is UpdateProductLoading)
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
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomBackButton(),
                Row(
                  children: [
                    const Icon(Icons.edit, color: AppColor.mainColor),
                    const SizedBox(width: 8),
                    Text(
                      'تعديل المنتج',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 40, height: 40),
              ],
            ),
          ),
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
                        style: Theme.of(context).textTheme.titleMedium!
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
                            color: AppColor.card,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColor.border),
                          ),
                          child: const Center(
                            child: SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColor.mainColor,
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
                            color: AppColor.card,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColor.border),
                          ),
                          child: Text(
                            'لا توجد تصنيفات متاحة',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(color: AppColor.textSecondary),
                          ),
                        );
                      }

                      final initialCategoryId =
                          selectedCategory ??
                          (() {
                            try {
                              return categories
                                  .firstWhere(
                                    (category) =>
                                        category.name ==
                                        widget.product.category,
                                  )
                                  .id;
                            } catch (_) {
                              return null;
                            }
                          })();

                      return DropdownButtonFormField<String>(
                        initialValue:
                            categories.any(
                              (category) => category.id == initialCategoryId,
                            )
                            ? initialCategoryId
                            : null,
                        hint: Text(
                          'اختر التصنيف',
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(color: AppColor.textSecondary),
                        ),
                        items: categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category.id,
                            child: Text(category.name),
                          );
                        }).toList(),
                        dropdownColor: AppColor.card,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColor.textPrimary,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor.card,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColor.border,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColor.mainColor,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColor.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColor.red),
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
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  if (currentCategory != null &&
                      currentCategory!.sizes.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          'الحجم',
                          style: Theme.of(context).textTheme.titleMedium!
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
                      initialValue:
                          currentCategory!.sizes.contains(selectedSize)
                          ? selectedSize
                          : null,
                      hint: Text(
                        'اختر الحجم',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                      items: currentCategory!.sizes.map((size) {
                        return DropdownMenuItem<String>(
                          value: size,
                          child: Text(size),
                        );
                      }).toList(),
                      dropdownColor: AppColor.card,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColor.textPrimary,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.card,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColor.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColor.mainColor,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColor.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColor.red),
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
            subLabel: 'اختر صوره واحده فقط لتكون الصوره الرئيسيه للمنتج',
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: CustomImagePicker(
                initialImage: widget.product.image,
                onImagePicked: (pickedImage) {
                  image = pickedImage;
                },
              ),
            ),
          ),
          BackgroundCard(
            icon: Icons.photo_library_outlined,
            label: 'صور المنتج',
            subLabel: 'يمكنك اضافه اكثر من صوره للمنتج (4 صور فقط)',
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: CustomSubImages(
                initialImages: widget.product.subImages,
                onImagesPicked: (images) {
                  subImagesFiles = images;
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

              final category = currentCategory;

              if (category == null) {
                customShowSnakeBar(
                  context,
                  color: Colors.red,
                  label: 'برجاء اختيار التصنيف',
                );
                return;
              }

              if (category.sizes.isNotEmpty && selectedSize == null) {
                customShowSnakeBar(
                  context,
                  color: Colors.red,
                  label: 'برجاء اختيار الحجم',
                );
                return;
              }

              if (category.sizes.isEmpty) {
                selectedSize = null;
              }

              if (context.read<OffersCubit>().offers.isNotEmpty) {
                customShowSnakeBar(
                  context,
                  color: Colors.red,
                  label: 'لا يمكن تعديل المنتج قبل حذف العروض و السله',
                );
                return;
              }

              final updatedProduct = widget.product.copyWith(
                name: nameController.text.trim(),
                price: num.tryParse(priceController.text) ?? 0,
                description: descriptionController.text.trim(),
                category: category.name,
                size: selectedSize,
                isFeatured: isFeatured,
                imageFile: image,
                subImagesFiles: subImagesFiles,
              );

              context.read<UpdateProductCubit>().updateProduct(updatedProduct);
            },
            child: Text(
              'تعديل المنتج',
              style: Theme.of(context).textTheme.labelSmall,
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
