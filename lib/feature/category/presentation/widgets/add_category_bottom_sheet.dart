import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper_function/custom_show_snake_bar.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../domain/entities/category_entity.dart';
import '../view_model/category_cubit.dart';

class AddCategoryBottomSheet extends StatefulWidget {
  const AddCategoryBottomSheet({super.key});

  @override
  State<AddCategoryBottomSheet> createState() => _AddCategoryBottomSheetState();
}

class _AddCategoryBottomSheetState extends State<AddCategoryBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();

  final List<String> _sizes = [];

  bool get _canAddSize {
    final size = _sizeController.text.trim();

    if (size.isEmpty) {
      return false;
    }

    final isDuplicate = _sizes.any(
      (item) => item.trim().toLowerCase() == size.toLowerCase(),
    );

    return !isDuplicate;
  }

  bool get _canAddCategory {
    final name = _nameController.text.trim();

    if (name.length < 2) {
      return false;
    }

    if (_sizes.isEmpty) {
      return false;
    }

    final categories = context.read<CategoryCubit>().categories;

    final isDuplicate = categories.any(
      (category) => category.name.trim().toLowerCase() == name.toLowerCase(),
    );

    return !isDuplicate;
  }

  void _addSize() {
    final cubit = context.read<CategoryCubit>();

    if (cubit.state is CategoryAddLoading) {
      return;
    }

    final size = _sizeController.text.trim();

    if (size.isEmpty) {
      customShowSnakeBar(
        context,
        color: AppColor.red,
        label: 'برجاء إدخال المقاس',
      );
      return;
    }

    final isDuplicate = _sizes.any(
      (item) => item.trim().toLowerCase() == size.toLowerCase(),
    );

    if (isDuplicate) {
      customShowSnakeBar(
        context,
        color: AppColor.red,
        label: 'هذا المقاس مضاف بالفعل',
      );
      return;
    }

    setState(() {
      _sizes.add(size);
      _sizeController.clear();
    });
  }

  void _removeSize(String size) {
    final cubit = context.read<CategoryCubit>();

    if (cubit.state is CategoryAddLoading) {
      return;
    }

    setState(() {
      _sizes.remove(size);
    });
  }

  void _addCategory() {
    FocusScope.of(context).unfocus();

    final cubit = context.read<CategoryCubit>();

    if (cubit.state is CategoryAddLoading) {
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_sizes.isEmpty) {
      customShowSnakeBar(
        context,
        color: AppColor.red,
        label: 'برجاء إضافة مقاس واحد على الأقل',
      );
      return;
    }

    final categoryName = _nameController.text.trim();

    final categories = cubit.categories;

    final isDuplicateCategory = categories.any(
      (category) =>
          category.name.trim().toLowerCase() == categoryName.toLowerCase(),
    );

    if (isDuplicateCategory) {
      customShowSnakeBar(
        context,
        color: AppColor.red,
        label: 'هذا التصنيف موجود بالفعل',
      );
      return;
    }

    final category = CategoryEntity(
      id: '',
      name: categoryName,
      sizes: List<String>.from(_sizes),
      createdAt: DateTime.now(),
      sortOrder: 0,
    );

    cubit.addCategory(category);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sizeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoryAddError) {
          customShowSnakeBar(
            context,
            color: AppColor.red,
            label: state.message,
          );

          return;
        }

        if (state is CategoryAddSuccess) {
          Navigator.pop(context, true);
        }
      },
      builder: (context, state) {
        final bool isLoading = state is CategoryAddLoading;

        final bool canAddSize = _canAddSize && !isLoading;
        final bool canAddCategory = _canAddCategory && !isLoading;

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'إضافة تصنيف',
                        style: StyleManager.font23Weight700(
                          context,
                        ).copyWith(color: AppColor.textPrimary),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        'أضف اسم التصنيف والأحجام المتاحة للمنتجات.',
                        style: StyleManager.font14Weight600(
                          context,
                        ).copyWith(color: AppColor.textSecondary),
                      ),

                      const SizedBox(height: 24),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColor.cardLight,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: AppColor.divider),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'بيانات التصنيف',
                              style: StyleManager.font16Weight700(
                                context,
                              ).copyWith(color: AppColor.textPrimary),
                            ),

                            const SizedBox(height: 18),

                            CustomTextFormField(
                              keyboardType: TextInputType.text,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              label: 'اسم التصنيف',
                              controller: _nameController,
                              hintText: 'مثال: بيتزا',
                              onChanged: (_) {
                                setState(() {});
                              },
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'أدخل اسم التصنيف';
                                }

                                final name = value.trim();

                                if (name.length < 2) {
                                  return 'اسم التصنيف قصير جدًا';
                                }

                                final categories = context
                                    .read<CategoryCubit>()
                                    .categories;

                                final isDuplicate = categories.any(
                                  (category) =>
                                      category.name.trim().toLowerCase() ==
                                      name.toLowerCase(),
                                );

                                if (isDuplicate) {
                                  return 'هذا التصنيف موجود بالفعل';
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 24),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'المقاسات',
                                  style: StyleManager.font14Weight600(
                                    context,
                                  ).copyWith(color: AppColor.textPrimary),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  '*',
                                  style: TextStyle(
                                    color: AppColor.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    keyboardType: TextInputType.text,
                                    autoValidateMode: AutovalidateMode.disabled,
                                    controller: _sizeController,
                                    hintText: 'مثال: وسط',
                                    onChanged: (_) {
                                      setState(() {});
                                    },
                                    onFieldSubmitted: (_) {
                                      if (canAddSize) {
                                        _addSize();
                                      }
                                    },
                                  ),
                                ),

                                const SizedBox(width: 10),

                                SizedBox(
                                  width: 52,
                                  height: 52,
                                  child: ElevatedButton(
                                    onPressed: canAddSize ? _addSize : null,
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      backgroundColor: canAddSize
                                          ? AppColor.mainColor
                                          : AppColor.backgroundDark,
                                      foregroundColor: AppColor.white,
                                      disabledBackgroundColor:
                                          AppColor.backgroundDark,
                                      disabledForegroundColor:
                                          AppColor.textSecondary,
                                      elevation: canAddSize ? 2 : 0,
                                      shape: const CircleBorder(),
                                    ),
                                    child: Icon(
                                      Icons.add_rounded,
                                      color: canAddSize
                                          ? AppColor.white
                                          : AppColor.textSecondary,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            if (_sizes.isNotEmpty)
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _sizes.map((size) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 9,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.goldLight.withOpacity(
                                        .22,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: AppColor.accentColor.withOpacity(
                                          .55,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          size,
                                          style: StyleManager.font13Weight600(
                                            context,
                                          ).copyWith(color: AppColor.mainColor),
                                        ),

                                        const SizedBox(width: 6),

                                        InkWell(
                                          onTap: isLoading
                                              ? null
                                              : () {
                                                  _removeSize(size);
                                                },
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          child: const Icon(
                                            Icons.close_rounded,
                                            size: 16,
                                            color: AppColor.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              )
                            else
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.background,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColor.divider),
                                ),
                                child: Text(
                                  'لم تتم إضافة أي مقاسات بعد',
                                  textAlign: TextAlign.center,
                                  style: StyleManager.font12Weight500(
                                    context,
                                  ).copyWith(color: AppColor.textSecondary),
                                ),
                              ),

                            if (_sizes.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              Text(
                                'تم إضافة ${_sizes.length} مقاس',
                                style: StyleManager.font12Weight500(
                                  context,
                                ).copyWith(color: AppColor.textSecondary),
                              ),
                            ],
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      CustomButton(
                        onPressed: canAddCategory ? _addCategory : null,
                        child: Text(
                          'إضافة التصنيف',
                          style: StyleManager.font15Weight800(context).copyWith(
                            color: AppColor.white
                          ),
                        ),
                      ),
                    ],
                  ),
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
