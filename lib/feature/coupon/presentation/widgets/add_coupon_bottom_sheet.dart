import 'package:am_adel_dashboard/core/helper_function/custom_show_snake_bar.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import 'package:am_adel_dashboard/core/widgets/custom_button.dart';
import 'package:am_adel_dashboard/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/entities/user_entity.dart';
import '../../../../core/utils/app_color.dart';
import '../../../clients/presentation/view_model/clients_cubit.dart';
import '../../domain/entities/coupon_entity.dart';
import '../view_model/add_coupon_cubit/add_coupon_cubit.dart';

class AddCouponBottomSheet extends StatefulWidget {
  const AddCouponBottomSheet({super.key});

  @override
  State<AddCouponBottomSheet> createState() => _AddCouponBottomSheetState();
}

class _AddCouponBottomSheetState extends State<AddCouponBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _codeController = TextEditingController();

  final TextEditingController _discountValueController =
      TextEditingController();

  final TextEditingController _minimumOrderController = TextEditingController();

 // final TextEditingController _maxDiscountController = TextEditingController();

  String _discountType = 'percentage';

  UserEntity? _selectedUser;

  DateTime? _expiresAt;

  bool get _canAddCoupon {
    return _selectedUser != null &&
        _codeController.text.trim().isNotEmpty &&
        _discountValueController.text.trim().isNotEmpty &&
        _minimumOrderController.text.trim().isNotEmpty &&
        // _maxDiscountController.text.trim().isNotEmpty &&
        _expiresAt != null;
  }

  @override
  void dispose() {
    _codeController.dispose();
    _discountValueController.dispose();
    _minimumOrderController.dispose();
   // _maxDiscountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCouponCubit, AddCouponState>(
      listener: (context, state) {
        if (state is AddCouponSuccess) {
          Navigator.pop(context);

          customShowSnakeBar(
            context,
            color: AppColor.green,
            label: 'تم إضافة الكوبون بنجاح',
          );
        }

        if (state is AddCouponFailure) {
          customShowSnakeBar(
            context,
            color: AppColor.red,
            label: state.message,
          );
        }
      },
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxHeight = MediaQuery.of(context).size.height * 0.85;

            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxHeight),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 24,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 24),
                      _buildUserSection(),
                      const SizedBox(height: 18),
                      _buildCodeField(),
                      const SizedBox(height: 18),
                      _buildDiscountType(),
                      const SizedBox(height: 18),
                      const SizedBox(height: 18),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildDiscountValueField()),
                          const SizedBox(width: 14),
                          Expanded(child: _buildMinimumOrderField()),
                         // Expanded(child: _buildMaxDiscountField()),
                        ],
                      ),
                      const SizedBox(height: 18),
                      _buildExpiryDate(),
                      const SizedBox(height: 28),
                      _buildAddButton(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColor.accentColor.withOpacity(.12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.local_offer_outlined,
            color: AppColor.accentColor,
          ),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'إضافة كوبون',
                style: TextStyle(
                  color: AppColor.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'إنشاء كوبون خصم لعميل محدد',
                style: TextStyle(color: AppColor.textSecondary, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserSection() {
    return BlocBuilder<ClientsCubit, ClientsState>(
      builder: (context, state) {
        final clientsCubit = context.read<ClientsCubit>();

        final clients = clientsCubit.filteredClients.isNotEmpty
            ? clientsCubit.filteredClients
            : clientsCubit.clients;

        final selectedUser = _selectedUser == null
            ? null
            : clients.cast<UserEntity?>().firstWhere(
                (user) => user!.uId == _selectedUser!.uId,
                orElse: () => null,
              );

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'العميل',
              style: TextStyle(
                color: AppColor.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<UserEntity>(
              value: selectedUser,
              isExpanded: true,
              dropdownColor: AppColor.cardLight,
              decoration: InputDecoration(
                hintText: 'اختر العميل',
                hintStyle: const TextStyle(
                  color: AppColor.textSecondary,
                  fontSize: 13,
                ),
                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: AppColor.accentColor,
                  size: 20,
                ),
                filled: true,
                fillColor: AppColor.cardLight,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 4,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColor.accentColor),
                ),
              ),
              items: clients.map((user) {
                return DropdownMenuItem<UserEntity>(
                  value: user,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          user.userName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColor.textPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        user.phone,
                        style: const TextStyle(
                          color: AppColor.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (user) {
                setState(() {
                  _selectedUser = user;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'من فضلك اختر العميل';
                }

                return null;
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCodeField() {
    return CustomTextFormField(
      controller: _codeController,
      label: 'كود الكوبون',
      hintText: 'مثال: AHMED20',
      prefixIcon: Icons.confirmation_number_outlined,
      textCapitalization: TextCapitalization.characters,
      onChanged: (_) {
        setState(() {});
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'من فضلك أدخل كود الكوبون';
        }

        return null;
      },
    );
  }

  Widget _buildDiscountType() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'نوع الخصم',
          style: TextStyle(
            color: AppColor.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildTypeOption(
                title: 'نسبة مئوية',
                value: 'percentage',
                icon: Icons.percent,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTypeOption(
                title: 'قيمة ثابتة',
                value: 'fixed',
                icon: Icons.payments_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeOption({
    required String title,
    required String value,
    required IconData icon,
  }) {
    final selected = _discountType == value;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        setState(() {
          _discountType = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: selected
              ? AppColor.accentColor.withOpacity(.12)
              : AppColor.cardLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColor.accentColor : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: selected ? AppColor.accentColor : AppColor.textSecondary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: selected ? AppColor.accentColor : AppColor.textPrimary,
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle,
                size: 17,
                color: AppColor.accentColor,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscountValueField() {
    return CustomTextFormField(
      controller: _discountValueController,
      label: 'قيمة الخصم',
      hintText: _discountType == 'percentage' ? 'مثال: %20' : 'مثال: 50 ج.م',
      prefixIcon: _discountType == 'percentage'
          ? Icons.percent
          : Icons.payments_outlined,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (_) {
        setState(() {});
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'من فضلك أدخل قيمة الخصم';
        }

        final number = double.tryParse(value);

        if (number == null || number <= 0) {
          return 'أدخل قيمة صحيحة';
        }

        if (_discountType == 'percentage' && number > 100) {
          return 'النسبة يجب ألا تتجاوز 100%';
        }

        return null;
      },
    );
  }

  Widget _buildMinimumOrderField() {
    return CustomTextFormField(
      controller: _minimumOrderController,
      label: 'الحد الأدنى',
      hintText: '150 ج.م',
      prefixIcon: Icons.shopping_cart_outlined,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (_) {
        setState(() {});
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'مطلوب';
        }

        final number = double.tryParse(value);

        if (number == null || number < 0) {
          return 'قيمة غير صحيحة';
        }

        return null;
      },
    );
  }

  // Widget _buildMaxDiscountField() {
  //   return CustomTextFormField(
  //     controller: _maxDiscountController,
  //     label: 'أقصى خصم',
  //     hintText: '50 ج.م',
  //     prefixIcon: Icons.price_check_outlined,
  //     keyboardType: const TextInputType.numberWithOptions(decimal: true),
  //     onChanged: (_) {
  //       setState(() {});
  //     },
  //     validator: (value) {
  //       if (value == null || value.trim().isEmpty) {
  //         return 'مطلوب';
  //       }
  //
  //       final number = double.tryParse(value);
  //
  //       if (number == null || number < 0) {
  //         return 'قيمة غير صحيحة';
  //       }
  //
  //       return null;
  //     },
  //   );
  // }

  Widget _buildExpiryDate() {
    final hasDate = _expiresAt != null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'تاريخ الانتهاء',
          style: TextStyle(
            color: AppColor.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _pickExpiryDate,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
            decoration: BoxDecoration(
              color: AppColor.cardLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  color: AppColor.accentColor,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    hasDate ? _formatDate(_expiresAt!) : 'اختر تاريخ الانتهاء',
                    style: TextStyle(
                      color: hasDate
                          ? AppColor.textPrimary
                          : AppColor.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColor.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    return BlocBuilder<AddCouponCubit, AddCouponState>(
      builder: (context, state) {
        final isLoading = state is AddCouponLoading;

        final enabled = _canAddCoupon && !isLoading;

        return SizedBox(
          width: double.infinity,
          height: 52,
          child: CustomButton(
            onPressed: enabled ? _addCoupon : null,
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColor.white,
                    ),
                  )
                : Text(
                    'إضافة الكوبون',
                    style: StyleManager.font15Weight800(
                      context,
                    ).copyWith(color: AppColor.white),
                  ),
          ),
        );
      },
    );
  }

  Future<void> _pickExpiryDate() async {
    FocusScope.of(context).unfocus();

    final now = DateTime.now();

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _expiresAt ?? now.add(const Duration(days: 7)),
      firstDate: now,
      lastDate: DateTime(now.year + 10),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColor.mainColor,
              secondary: AppColor.accentColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate == null) {
      return;
    }

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: _expiresAt != null
          ? TimeOfDay.fromDateTime(_expiresAt!)
          : const TimeOfDay(hour: 23, minute: 59),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColor.mainColor,
              secondary: AppColor.accentColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime == null) {
      return;
    }

    setState(() {
      _expiresAt = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
    });
  }

  void _addCoupon() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedUser == null || _expiresAt == null) {
      return;
    }

    final now = DateTime.now();

    final coupon = CouponEntity(
      id: 'coupon_${now.microsecondsSinceEpoch}',
      code: _codeController.text.trim().toUpperCase(),
      discountType: _discountType,
      discountValue: double.parse(_discountValueController.text.trim()),
      minimumOrder: double.parse(_minimumOrderController.text.trim()),
      // maxDiscount: double.parse(_maxDiscountController.text.trim()),
      maxDiscount: 0,
      createdAt: now,
      expiresAt: _expiresAt!,
    );

    context.read<AddCouponCubit>().addCoupon(
      userId: _selectedUser!.uId,
      coupon: coupon,
    );
  }

  String _formatDate(DateTime date) {
    final hour = date.hour > 12
        ? date.hour - 12
        : date.hour == 0
        ? 12
        : date.hour;

    final period = date.hour >= 12 ? 'م' : 'ص';

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} - '
        '${hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')} $period';
  }
}
