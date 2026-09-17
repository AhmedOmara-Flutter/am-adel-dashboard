import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helper_function/custom_show_snake_bar.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../domain/entities/category_entity.dart';
import '../view_model/category_cubit.dart';

class EditCategoryBottomSheet extends StatefulWidget {
  const EditCategoryBottomSheet({super.key, required this.category});

  final CategoryEntity category;

  @override
  State<EditCategoryBottomSheet> createState() =>
      _EditCategoryBottomSheetState();
}

class _EditCategoryBottomSheetState extends State<EditCategoryBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _sizeController;
  late List<String> _sizes;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.category.name);

    _sizeController = TextEditingController();

    _sizeController.addListener(_onSizeChanged);

    _sizes = List<String>.from(widget.category.sizes);
  }

  void _onSizeChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _sizeController.removeListener(_onSizeChanged);

    _nameController.dispose();
    _sizeController.dispose();

    super.dispose();
  }

  bool get _canAddSize {
    final size = _sizeController.text.trim();

    if (size.isEmpty) {
      return false;
    }

    final normalizedSize = size.toLowerCase();

    final isDuplicate = _sizes.any(
      (item) => item.trim().toLowerCase() == normalizedSize,
    );

    return !isDuplicate;
  }

  void _addSize() {
    final cubit = context.read<CategoryCubit>();

    if (cubit.state is CategoryUpdateLoading) {
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

    final normalizedSize = size.toLowerCase();

    final isDuplicate = _sizes.any(
      (item) => item.trim().toLowerCase() == normalizedSize,
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

    if (cubit.state is CategoryUpdateLoading) {
      return;
    }

    setState(() {
      _sizes.remove(size);
    });
  }

  String? _validateCategoryName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'أدخل اسم التصنيف';
    }

    final name = value.trim();

    if (name.length < 2) {
      return 'اسم التصنيف قصير جدًا';
    }

    return null;
  }

  void _updateCategory() {
    FocusScope.of(context).unfocus();

    final cubit = context.read<CategoryCubit>();

    if (cubit.state is CategoryUpdateLoading) {
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

    final name = _nameController.text.trim();

    final updatedCategory = CategoryEntity(
      id: widget.category.id,
      name: name,
      sizes: List<String>.from(_sizes),
      createdAt: widget.category.createdAt,
      sortOrder: widget.category.sortOrder,
    );

    cubit.updateCategory(updatedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoryUpdateSuccess) {
          Navigator.pop(context);

          customShowSnakeBar(
            context,
            color: AppColor.green,
            label: 'تم تعديل التصنيف بنجاح',
          );
        }

        if (state is CategoryUpdateError) {
          customShowSnakeBar(
            context,
            color: AppColor.red,
            label: state.message,
          );
        }
      },
      builder: (context, state) {
        final bool isLoading = state is CategoryUpdateLoading;
        final bool canAddSize = _canAddSize && !isLoading;

        return AbsorbPointer(
          absorbing: isLoading,
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: AppColor.goldLight.withOpacity(.25),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.edit_rounded,
                              color: AppColor.mainColor,
                              size: 20,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'تعديل التصنيف',
                                  style: StyleManager.font19Weight700(
                                    context,
                                  ).copyWith(color: AppColor.textPrimary),
                                ),

                                const SizedBox(height: 3),

                                Text(
                                  'عدّل الاسم والمقاسات',
                                  style: StyleManager.font12Weight500(
                                    context,
                                  ).copyWith(color: AppColor.textSecondary),
                                ),
                              ],
                            ),
                          ),

                          Material(
                            color: AppColor.background,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: isLoading
                                  ? null
                                  : () {
                                      Navigator.pop(context);
                                    },
                              borderRadius: BorderRadius.circular(10),
                              child: const SizedBox(
                                width: 36,
                                height: 36,
                                child: Icon(
                                  Icons.close_rounded,
                                  color: AppColor.textSecondary,
                                  size: 19,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColor.cardLight,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColor.divider),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'اسم التصنيف',
                              style: StyleManager.font13Weight600(
                                context,
                              ).copyWith(color: AppColor.textPrimary),
                            ),

                            const SizedBox(height: 8),

                            CustomTextFormField(
                              controller: _nameController,
                              keyboardType: TextInputType.text,
                              hintText: 'مثال: بيتزا',
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: _validateCategoryName,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).unfocus();
                              },
                            ),

                            const SizedBox(height: 20),

                            Row(
                              children: [
                                Text(
                                  'المقاسات',
                                  style: StyleManager.font13Weight600(
                                    context,
                                  ).copyWith(color: AppColor.textPrimary),
                                ),

                                const SizedBox(width: 5),

                                const Text(
                                  '*',
                                  style: TextStyle(
                                    color: AppColor.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const Spacer(),

                                if (_sizes.isNotEmpty)
                                  Text(
                                    '${_sizes.length} مقاس',
                                    style: StyleManager.font12Weight500(
                                      context,
                                    ).copyWith(color: AppColor.textSecondary),
                                  ),
                              ],
                            ),

                            const SizedBox(height: 9),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    controller: _sizeController,
                                    keyboardType: TextInputType.text,
                                    hintText: 'مثال: وسط',
                                    autoValidateMode: AutovalidateMode.disabled,
                                    onFieldSubmitted: (_) {
                                      if (canAddSize) {
                                        _addSize();
                                      }
                                    },
                                  ),
                                ),

                                const SizedBox(width: 8),

                                SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: ElevatedButton(
                                    onPressed: canAddSize ? _addSize : null,
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      backgroundColor: AppColor.mainColor,
                                      disabledBackgroundColor:
                                          AppColor.backgroundDark,
                                      disabledForegroundColor:
                                          AppColor.textSecondary,
                                      foregroundColor: AppColor.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.add_rounded,
                                      size: 21,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 14),

                            if (_sizes.isNotEmpty)
                              Wrap(
                                spacing: 7,
                                runSpacing: 7,
                                children: _sizes.map((size) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 7,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.goldLight.withOpacity(
                                        .22,
                                      ),
                                      borderRadius: BorderRadius.circular(9),
                                      border: Border.all(
                                        color: AppColor.accentColor.withOpacity(
                                          .45,
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

                                        const SizedBox(width: 5),

                                        GestureDetector(
                                          onTap: isLoading
                                              ? null
                                              : () {
                                                  _removeSize(size);
                                                },
                                          child: const Icon(
                                            Icons.close_rounded,
                                            color: AppColor.red,
                                            size: 15,
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
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.background,
                                  borderRadius: BorderRadius.circular(9),
                                  border: Border.all(color: AppColor.divider),
                                ),
                                child: Text(
                                  'لم تتم إضافة أي مقاسات',
                                  textAlign: TextAlign.center,
                                  style: StyleManager.font12Weight500(
                                    context,
                                  ).copyWith(color: AppColor.textSecondary),
                                ),
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          onPressed: isLoading ? null : _updateCategory,
                          child: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColor.white,
                                  ),
                                )
                              : Text(
                                  'حفظ التعديلات',
                            style: StyleManager.font15Weight800(context).copyWith(
                                color: AppColor.white
                            ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
