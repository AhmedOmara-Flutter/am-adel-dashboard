import 'package:am_adel_dashboard/core/helper_function/custom_show_snake_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper_function/custom_show_dialog.dart';
import '../../../../core/utils/app_color.dart';
import '../../domain/entities/user_coupon_entity.dart';
import '../view_model/delete_coupon_cubit/delete_coupon_cubit.dart';
import '../view_model/get_coupon_cubit/get_coupon_cubit.dart';
import 'coupon_header.dart';
import 'coupon_statistics.dart';
import 'coupon_table.dart';
import 'coupon_toolbar.dart';

class CouponViewBody extends StatefulWidget {
  const CouponViewBody({super.key});

  @override
  State<CouponViewBody> createState() => _CouponViewBodyState();
}

class _CouponViewBodyState extends State<CouponViewBody> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedFilter = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<UserCouponEntity> _filteredCoupons(List<UserCouponEntity> userCoupons) {
    final search = _searchController.text.trim().toLowerCase();

    return userCoupons.where((userCoupon) {
      final coupon = userCoupon.coupon;
      final user = userCoupon.user;

      final matchesSearch =
          user.userName.toLowerCase().contains(search) ||
          coupon.code.toLowerCase().contains(search);

      final isExpired = DateTime.now().isAfter(coupon.expiresAt);

      final status = isExpired ? 'Expired' : 'Active';

      final matchesFilter =
          _selectedFilter == 'All' || status == _selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<DeleteCouponCubit, DeleteCouponState>(
        listener: (context, state) {
          if (state is DeleteCouponSuccess) {
            customShowSnakeBar(
              context,
              color: AppColor.green,
              label: 'تم حذف الكوبون بنجاح',
            );
          }

          if (state is DeleteCouponFailure) {
            customShowSnakeBar(
              context,
              color: AppColor.red,
              label: state.message,
            );
          }
        },
        child: BlocBuilder<GetCouponCubit, GetCouponState>(
          builder: (context, state) {
            if (state is GetCouponLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetCouponFailure) {
              return Center(child: Text(state.message));
            }

            if (state is GetCouponSuccess) {
              final userCoupons = state.userCoupons;

              final filteredCoupons = _filteredCoupons(userCoupons);

              return LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = constraints.maxWidth.isFinite
                      ? constraints.maxWidth
                      : MediaQuery.of(context).size.width;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(15),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: maxWidth - 48),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CouponHeader(),
                          const SizedBox(height: 15),
                          CouponStatistics(
                            coupons: userCoupons
                                .map((item) => item.coupon)
                                .toList(),
                          ),
                          const SizedBox(height: 15),
                          CouponToolbar(
                            searchController: _searchController,
                            selectedFilter: _selectedFilter,
                            onSearchChanged: (_) {
                              setState(() {});
                            },
                            onFilterChanged: (value) {
                              setState(() {
                                _selectedFilter = value;
                              });
                            },
                          ),
                          const SizedBox(height: 15),
                          CouponTable(
                            coupons: filteredCoupons,
                            onDelete: _showDeleteDialog,
                            getDateFormate: _formatDate,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _showDeleteDialog(UserCouponEntity userCoupon) {
    final coupon = userCoupon.coupon;
    final user = userCoupon.user;

    CustomShowDialog.show(
      context,
      title: 'حذف الكوبون',
      flag: Icons.delete_outline_rounded,
      color: AppColor.red,
      acceptText: 'حذف',
      content: Text(
        'هل أنت متأكد من حذف الكوبون ${coupon.code} من حساب ${user.userName}؟',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColor.textSecondary,
          fontSize: 13,
          height: 1.6,
        ),
      ),
      accept: () {
        Navigator.pop(context);

        context.read<DeleteCouponCubit>().deleteCoupon(
          userId: user.uId,
          couponCode: coupon.code,
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final hour = date.hour == 0
        ? 12
        : date.hour > 12
        ? date.hour - 12
        : date.hour;

    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} - '
        '${hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')} '
        '$period';
  }
}
