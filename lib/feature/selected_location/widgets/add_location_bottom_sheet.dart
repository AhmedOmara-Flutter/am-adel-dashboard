import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/entities/selected_location_entity.dart';
import '../../../../core/helper_function/custom_show_snake_bar.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../view_model/selected_location_cubit.dart';

class AddLocationBottomSheet extends StatefulWidget {
  const AddLocationBottomSheet({super.key});

  @override
  State<AddLocationBottomSheet> createState() => _AddLocationBottomSheetState();
}

class _AddLocationBottomSheetState extends State<AddLocationBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _subTitleController = TextEditingController();

  final TextEditingController _costController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _subTitleController.dispose();
    _costController.dispose();
    super.dispose();
  }

  void _addLocation() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final cost = double.tryParse(_costController.text.trim());

    if (cost == null) {
      customShowSnakeBar(
        context,
        color: AppColor.red,
        label: 'برجاء إدخال سعر توصيل صحيح',
      );
      return;
    }

    context.read<SelectedLocationCubit>().addLocation(
      SelectedLocationEntity(
        id: '',
        title: _titleController.text.trim(),
        subTitle: _subTitleController.text.trim(),
        cost: cost,
        createdAt: DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectedLocationCubit, SelectedLocationState>(
      listener: (context, state) {
        if (state is SelectedLocationAddError) {
          customShowSnakeBar(
            context,
            color: AppColor.red,
            label: state.message,
          );
        }

        if (state is SelectedLocationAddSuccess) {
          _titleController.clear();
          _subTitleController.clear();
          _costController.clear();

          Navigator.pop(context);

          customShowSnakeBar(
            context,
            color: AppColor.green,
            label: 'تم إضافة مكان التوصيل بنجاح',
          );
        }
      },
      builder: (context, state) {
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
                          'إضافة مكان توصيل',
                          style: StyleManager.font23Weight700(
                            context,
                          ).copyWith(color: AppColor.white),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'أضف اسم المنطقة ووصفها وسعر التوصيل.',
                          style: StyleManager.font14Weight600(
                            context,
                          ).copyWith(color: AppColor.white.withOpacity(.55)),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: AppColor.card,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(color: AppColor.border),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'بيانات المكان',
                                style: StyleManager.font16Weight700(context),
                              ),
                              const SizedBox(height: 18),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextFormField(
                                      keyboardType: TextInputType.text,
                                      autoValidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      label: 'اسم المكان',
                                      controller: _titleController,
                                      hintText: 'مثال: القاهره',
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'أدخل اسم المكان';
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
                                          AutovalidateMode.onUserInteraction,
                                      label: 'سعر التوصيل',
                                      controller: _costController,
                                      hintText: '0.00',
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
                                          return 'السعر لا يمكن أن يكون سالبًا';
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
                                controller: _subTitleController,
                                maxLines: 4,
                                hintText: 'مثال: اختر عنوانك داخل القاهره',
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'من فضلك أدخل وصف المكان';
                                  }

                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        CustomButton(
                          onPressed: _addLocation,
                          child: Text(
                            'إضافة المكان',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (state is SelectedLocationAddLoading)
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
          ),
        );
      },
    );
  }
}
