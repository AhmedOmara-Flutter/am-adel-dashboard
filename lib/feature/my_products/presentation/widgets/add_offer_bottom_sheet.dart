import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:am_adel_dashboard/core/helper_function/custom_show_snake_bar.dart';
import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/feature/my_products/presentation/widgets/build_date_picker_tile.dart';
import 'package:am_adel_dashboard/core/entities/offer_entity.dart';
import '../../../../core/cubit/offers_cubit/offers_cubit.dart';
import '../../../../core/entities/product_entity.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class AddOfferBottomSheet extends StatefulWidget {
  final ProductEntity product;

  const AddOfferBottomSheet({
    super.key,
    required this.product,
  });

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

    final result = widget.product.price -
        (widget.product.price * discount / 100);

    priceAfterDiscount.text = result.toStringAsFixed(2);
  }

  bool get canSave =>
      discountController.text.isNotEmpty &&
          startDate != null &&
          endDate != null &&
          !endDate!.isBefore(startDate!);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 11,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'إضافة عرض جديد',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
              SizedBox(height: 15),
              CustomTextFormField(
                controller: discountController,
                keyboardType: TextInputType.number,
                hintText: 'ادخل نسبة الخصم (%)',
                label: 'نسبة الخصم (%)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ادخل نسبة الخصم';
                  }

                  final discount = double.tryParse(value);

                  if (discount == null) return 'قيمة غير صحيحة';
                  if (discount <= 0 || discount > 100) {
                    return 'يجب أن تكون بين 1 و 100';
                  }

                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      readOnly: true,
                      controller: priceBeforeDiscount,
                      keyboardType: TextInputType.number,
                      hintText: 'السعر قبل الخصم',
                      label: 'السعر قبل الخصم',
                    ),
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: CustomTextFormField(
                      readOnly: true,
                      controller: priceAfterDiscount,
                      keyboardType: TextInputType.number,
                      hintText: 'السعر بعد الخصم',
                      label: 'السعر بعد الخصم',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              BuildDatePickerTile(
                title: 'تاريخ بداية العرض',
                date: startDate,
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.dark(
                            primary: AppColor.mainColor,
                            surface: AppColor.card,
                            onSurface: AppColor.textPrimary,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (pickedDate != null) {
                    setState(() => startDate = pickedDate);
                  }
                },
              ),
              SizedBox(height: 12),
              BuildDatePickerTile(
                title: 'تاريخ انتهاء العرض',
                date: endDate,
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.dark(
                            primary: AppColor.mainColor,
                            surface: AppColor.card,
                            onSurface: AppColor.textPrimary,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (pickedDate != null) {
                    setState(() => endDate = pickedDate);
                  }
                },
              ),
              SizedBox(height: 20),
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
                      color: AppColor.mainColor,
                      label: 'تم حفظ العرض بنجاح',
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading = state is OffersLoading;

                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.mainColor,
                        disabledBackgroundColor: AppColor.border,
                        foregroundColor: AppColor.white,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: (!canSave || isLoading)
                          ? null
                          : () async {
                        if (_formKey.currentState!.validate()) {
                          final offer = OfferEntity(
                            id: '',
                            productId: widget.product.id!,
                            discountPercentage:
                            double.parse(discountController.text),
                            startDate: startDate!,
                            endDate: endDate!,
                            image: widget.product.image ?? "",
                            name: widget.product.name,
                            priceBeforeDiscount:
                            double.parse(priceBeforeDiscount.text),
                            priceAfterDiscount:
                            double.parse(priceAfterDiscount.text),
                          );

                          Navigator.pop(context);

                          await context
                              .read<OffersCubit>()
                              .addOffer(offer);
                        }
                      },
                      child: isLoading
                          ? SizedBox(
                        height: 18,
                        width: 18,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColor.white,
                        ),
                      )
                          : Text(
                        'حفظ العرض',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: AppColor.white),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
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