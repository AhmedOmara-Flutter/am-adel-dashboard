import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/entities/selected_location_entity.dart';
import '../../../../core/helper_function/custom_show_snake_bar.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../view_model/selected_location_cubit.dart';

class EditLocationBottomSheet extends StatefulWidget {
  const EditLocationBottomSheet({
    super.key,
    required this.location,
  });

  final SelectedLocationEntity location;

  @override
  State<EditLocationBottomSheet> createState() =>
      _EditLocationBottomSheetState();
}

class _EditLocationBottomSheetState
    extends State<EditLocationBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _subTitleController;
  late final TextEditingController _costController;

  bool get _isFormComplete {
    final title = _titleController.text.trim();
    final subTitle = _subTitleController.text.trim();
    final cost = double.tryParse(_costController.text.trim());

    return title.isNotEmpty &&
        subTitle.isNotEmpty &&
        cost != null &&
        cost >= 0;
  }

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(
      text: widget.location.title,
    );

    _subTitleController = TextEditingController(
      text: widget.location.subTitle,
    );

    _costController = TextEditingController(
      text: widget.location.cost.toStringAsFixed(0),
    );

    _titleController.addListener(_onFormChanged);
    _subTitleController.addListener(_onFormChanged);
    _costController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _titleController.removeListener(_onFormChanged);
    _subTitleController.removeListener(_onFormChanged);
    _costController.removeListener(_onFormChanged);

    _titleController.dispose();
    _subTitleController.dispose();
    _costController.dispose();

    super.dispose();
  }

  void _updateLocation() {
    FocusScope.of(context).unfocus();

    if (!_isFormComplete) {
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final cost = double.tryParse(
      _costController.text.trim(),
    );

    if (cost == null) {
      customShowSnakeBar(
        context,
        color: AppColor.red,
        label: 'برجاء إدخال سعر صحيح',
      );
      return;
    }

    final updatedLocation = SelectedLocationEntity(
      id: widget.location.id,
      title: _titleController.text.trim(),
      subTitle: _subTitleController.text.trim(),
      cost: cost,
      createdAt: widget.location.createdAt,
    );

    context.read<SelectedLocationCubit>().updateLocation(
      updatedLocation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectedLocationCubit, SelectedLocationState>(
      listener: (context, state) {
        if (state is SelectedLocationUpdateSuccess) {
          Navigator.pop(context);

          customShowSnakeBar(
            context,
            color: AppColor.green,
            label: 'تم تعديل منطقة التوصيل بنجاح',
          );
        }

        if (state is SelectedLocationUpdateError) {
          customShowSnakeBar(
            context,
            color: AppColor.red,
            label: state.message,
          );
        }
      },
      builder: (context, state) {
        final isLoading =
        state is SelectedLocationUpdateLoading;

        final isFormComplete = _isFormComplete;

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
                        'تعديل منطقة التوصيل',
                        style: StyleManager.font23Weight700(
                          context,
                        ).copyWith(
                          color: AppColor.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'قم بتعديل بيانات منطقة التوصيل ثم احفظ التغييرات.',
                        style: StyleManager.font14Weight600(
                          context,
                        ).copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColor.cardLight,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColor.divider,
                          ),
                        ),
                        child: Column(
                          children: [
                            CustomTextFormField(
                              keyboardType: TextInputType.text,
                              autoValidateMode:
                              AutovalidateMode.onUserInteraction,
                              label: 'اسم المكان',
                              controller: _titleController,
                              hintText: 'مثال: مدينة نصر',
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return 'أدخل اسم المكان';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 18),
                            CustomTextFormField(
                              keyboardType:
                              const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              autoValidateMode:
                              AutovalidateMode.onUserInteraction,
                              label: 'سعر التوصيل',
                              controller: _costController,
                              hintText: 'مثال: 20',
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return 'أدخل سعر التوصيل';
                                }

                                final cost = double.tryParse(
                                  value.trim(),
                                );

                                if (cost == null) {
                                  return 'أدخل سعر صحيح';
                                }

                                if (cost < 0) {
                                  return 'السعر لا يمكن أن يكون أقل من صفر';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 18),
                            CustomTextFormField(
                              keyboardType: TextInputType.text,
                              autoValidateMode:
                              AutovalidateMode.onUserInteraction,
                              label: 'الوصف',
                              controller: _subTitleController,
                              maxLines: 3,
                              hintText:
                              'مثال: اختر عنوانك داخل مدينة نصر',
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return 'أدخل وصف المكان';
                                }

                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        onPressed: isFormComplete && !isLoading
                            ? _updateLocation
                            : null,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: isFormComplete && !isLoading
                              ? 1
                              : .45,
                          child: Text(
                            'حفظ التعديلات',
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