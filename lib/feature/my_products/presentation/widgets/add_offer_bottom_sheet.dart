import 'package:am_adel_dashboard/feature/offers/domain/entities/offer_entity.dart';
import 'package:am_adel_dashboard/core/helper_function/custom_show_snake_bar.dart';
import 'package:am_adel_dashboard/core/utils/app_imports.dart';
import 'package:am_adel_dashboard/core/widgets/custom_button.dart';
import 'package:am_adel_dashboard/feature/my_products/presentation/widgets/build_date_picker_tile.dart';

import '../../../../core/widgets/custom_text_form_field.dart';

class AddOfferBottomSheet extends StatefulWidget {
  final ProductEntity product;

  const AddOfferBottomSheet({super.key, required this.product});

  @override
  State<AddOfferBottomSheet> createState() => _AddOfferBottomSheetState();
}

class _AddOfferBottomSheetState extends State<AddOfferBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController discountController = TextEditingController();
  final TextEditingController priceBeforeDiscount = TextEditingController();
  final TextEditingController priceAfterDiscount = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();

    priceBeforeDiscount.text = widget.product.price.toString();
    priceAfterDiscount.text = widget.product.price.toString();

    discountController.addListener(_calculatePrice);
  }

  void _calculatePrice() {
    final discount = double.tryParse(discountController.text) ?? 0;

    final result =
        widget.product.price - (widget.product.price * discount / 100);

    priceAfterDiscount.text = result.toStringAsFixed(2);
  }

  bool get canSave =>
      discountController.text.isNotEmpty &&
      startDate != null &&
      endDate != null &&
      !endDate!.isBefore(startDate!);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 18,
          right: 18,
          top: 8,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColor.textSecondary,
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              const SizedBox(height: 20),
              _buildHeader(theme),

              const SizedBox(height: 20),

              CustomTextFormField(
                controller: discountController,
                keyboardType: TextInputType.number,
                hintText: 'مثال: 20',
                label: 'نسبة الخصم',
                prefixIcon: Icons.percent_rounded,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ادخل نسبة الخصم';
                  }

                  final discount = double.tryParse(value);

                  if (discount == null) {
                    return 'قيمة غير صحيحة';
                  }

                  if (discount <= 0 || discount > 100) {
                    return 'يجب أن تكون بين 1 و 100';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 14),

              _buildPrices(),

              const SizedBox(height: 20),

              _buildDatePicker(
                title: 'بداية العرض',
                date: startDate,
                onTap: () => _pickDate(isStartDate: true),
              ),

              const SizedBox(height: 9),

              _buildDatePicker(
                title: 'نهاية العرض',
                date: endDate,
                onTap: () => _pickDate(isStartDate: false),
              ),

              const SizedBox(height: 20),

              BlocConsumer<OffersCubit, OfferState>(
                listener: (context, state) {
                  if (state is OffersFailure) {
                    customShowSnakeBar(
                      context,
                      color: AppColor.red,
                      label: state.errMessage,
                    );
                  }

                  if (state is OffersSuccess) {
                    customShowSnakeBar(
                      context,
                      color: AppColor.green,
                      label: 'تم حفظ العرض بنجاح',
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading = state is OffersLoading;

                  return _buildSaveButton(
                    theme: theme,
                    isLoading: isLoading,
                    onPressed: (!canSave || isLoading)
                        ? null
                        : () async {
                      if (_formKey.currentState!.validate()) {
                        final offer = OfferEntity(
                          id: '',
                          productId: widget.product.id!,
                          discountPercentage: double.parse(
                            discountController.text,
                          ),
                          startDate: startDate!,
                          endDate: endDate!,
                          image: widget.product.image ?? "",
                          name: widget.product.name,
                          priceBeforeDiscount: double.parse(
                            priceBeforeDiscount.text,
                          ),
                          priceAfterDiscount: double.parse(
                            priceAfterDiscount.text,
                          ),
                        );

                        Navigator.pop(context);

                        await context.read<OffersCubit>().addOffer(offer);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
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
            Icons.local_offer_rounded,
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
                'إضافة عرض',
                style: StyleManager.font18Weight700(context).copyWith(
                    fontWeight: FontWeight.w800
                ),
              ),
              const SizedBox(height: 3),
              Text(
                widget.product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.font12Weight500(context).copyWith(
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: AppColor.accentColor.withOpacity(.10),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'خصم',
            style: StyleManager.font13Weight400(context).copyWith(
                color: AppColor.accentColor
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrices() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        color: AppColor.background.withOpacity(.35),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildPrice(
              title: 'السعر الأصلي',
              controller: priceBeforeDiscount,
              color: AppColor.textSecondary,
              crossed: true,
            ),
          ),
          Container(
            width: 1,
            height: 35,
            color: AppColor.divider.withOpacity(.55),
          ),
          Expanded(
            child: _buildPrice(
              title: 'السعر بعد الخصم',
              controller: priceAfterDiscount,
              color: AppColor.accentColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrice({
    required String title,
    required TextEditingController controller,
    required Color color,
    bool crossed = false,
  }) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (_, value, __) {
        return Column(
          children: [
            Text(
              title,
              style: StyleManager.font11Weight400(context).copyWith(
                  color: AppColor.textSecondary,
                  fontWeight: FontWeight.bold),

            ),
            const SizedBox(height: 4),
            Text(
              '${value.text} ج.م',
              style: StyleManager.font14Weight600(context).copyWith(
                color: color,
                fontWeight: FontWeight.w800,
                decoration: crossed ? TextDecoration.lineThrough : null,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDatePicker({
    required String title,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppColor.divider.withOpacity(.55)),
      ),
      child: BuildDatePickerTile(title: title, date: date, onTap: onTap),
    );
  }

  Future<void> _pickDate({required bool isStartDate}) async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColor.mainColor,
              onPrimary: AppColor.white,
              surface: AppColor.cardLight,
              onSurface: AppColor.textPrimary,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: AppColor.cardLight,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          startDate = pickedDate;
        } else {
          endDate = pickedDate;
        }
      });
    }
  }

  Widget _buildSaveButton({
    required ThemeData theme,
    required bool isLoading,
    required VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 47,
      child: CustomButton(
        onPressed: onPressed,
        child: isLoading
            ? const SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColor.white,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_rounded,
              color: AppColor.white,
              size: 19,
            ),
            const SizedBox(width: 7),
            Text(
              'حفظ العرض',
              style: theme.textTheme.labelLarge?.copyWith(
                color: AppColor.white,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    discountController.removeListener(_calculatePrice);
    discountController.dispose();
    priceBeforeDiscount.dispose();
    priceAfterDiscount.dispose();
    super.dispose();
  }
}
