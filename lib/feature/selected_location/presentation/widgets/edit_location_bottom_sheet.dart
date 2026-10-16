
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper_function/custom_show_snake_bar.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../domain/entities/selected_location_entity.dart';
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
    if (mounted) {
      setState(() {});
    }
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

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final cost = double.tryParse(_costController.text.trim());

    if (cost == null || cost < 0) {
      customShowSnakeBar(
        context,
        color: AppColor.red,
        label: 'برجاء إدخال سعر توصيل صحيح',
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
      buildWhen: (previous, current) {
        return previous is SelectedLocationUpdateLoading ||
            current is SelectedLocationUpdateLoading ||
            current is SelectedLocationUpdateSuccess ||
            current is SelectedLocationUpdateError;
      },
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
        final isLoading = state is SelectedLocationUpdateLoading;
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
                  padding: const EdgeInsets.fromLTRB(
                    18,
                    10,
                    18,
                    20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 5,
                            decoration: BoxDecoration(
                              color: AppColor.textSecondary,
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildHeader(context),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              keyboardType: TextInputType.text,
                              autoValidateMode:
                              AutovalidateMode.onUserInteraction,
                              label: 'اسم المكان',
                              controller: _titleController,
                              hintText: 'مثال: القاهرة',
                              prefixIcon: Icons.location_on_outlined,
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
                              prefixIcon: Icons.payments_outlined,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return 'أدخل سعر التوصيل';
                                }

                                final cost =
                                double.tryParse(value.trim());

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
                      const SizedBox(height: 15),
                      CustomTextFormField(
                        keyboardType: TextInputType.text,
                        autoValidateMode:
                        AutovalidateMode.onUserInteraction,
                        label: 'وصف المكان',
                        controller: _subTitleController,
                        maxLines: 3,
                        hintText: 'مثال: التوصيل داخل القاهرة',
                        prefixIcon: Icons.notes_rounded,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'من فضلك أدخل وصف المكان';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildSaveButton(
                        context: context,
                        enabled: isFormComplete && !isLoading,
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColor.mainColor.withOpacity(.10),
            borderRadius: BorderRadius.circular(13),
          ),
          child: const Icon(
            Icons.edit_location_alt_rounded,
            color: AppColor.mainColor,
            size: 23,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تعديل مكان التوصيل',
                style: StyleManager.font18Weight700(context).copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'عدّل بيانات المنطقة وسعر التوصيل',
                style: StyleManager.font12Weight500(context).copyWith(
                  color: AppColor.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton({
    required BuildContext context,
    required bool enabled,
    required bool isLoading,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 47,
      child: CustomButton(
        onPressed: enabled ? _updateLocation : null,
        child: isLoading
            ? const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColor.white,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.save_rounded,
              color: AppColor.textOnDark,
              size: 18,
            ),
            const SizedBox(width: 7),
            Text(
              'حفظ التعديلات',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColor.textOnDark,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
