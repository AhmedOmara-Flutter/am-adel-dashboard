import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:flutter/material.dart';

class CouponToolbar extends StatelessWidget {
  final TextEditingController searchController;
  final String selectedFilter;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onFilterChanged;

  const CouponToolbar({
    super.key,
    required this.searchController,
    required this.selectedFilter,
    required this.onSearchChanged,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColor.divider.withOpacity(.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColor.mainColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.manage_search_rounded,
                  color: AppColor.mainColor,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'البحث عن كوبون',
                    style: TextStyle(
                      color: AppColor.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'ابحث باستخدام اسم المستخدم أو كود الكوبون',
                    style: TextStyle(
                      color: AppColor.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSearchField(),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'الحالة',
                style: TextStyle(
                  color: AppColor.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip(
                        label: 'الكل',
                        value: 'All',
                        icon: Icons.apps_rounded,
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        label: 'نشط',
                        value: 'Active',
                        icon: Icons.check_circle_outline_rounded,
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        label: 'منتهي',
                        value: 'Expired',
                        icon: Icons.timer_off_outlined,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      onChanged: onSearchChanged,
      style: const TextStyle(
        color: AppColor.textPrimary,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: AppColor.mainColor,
      decoration: InputDecoration(
        hintText: 'اكتب اسم المستخدم أو كود الكوبون...',
        hintStyle: const TextStyle(
          color: AppColor.textSecondary,
          fontSize: 12,
        ),
        prefixIcon: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColor.mainColor.withOpacity(.08),
            borderRadius: BorderRadius.circular(9),
          ),
          child: const Icon(
            Icons.search_rounded,
            color: AppColor.mainColor,
            size: 20,
          ),
        ),
        suffixIcon: searchController.text.isNotEmpty
            ? IconButton(
          onPressed: () {
            searchController.clear();
            onSearchChanged('');
          },
          icon: const Icon(
            Icons.close_rounded,
            color: AppColor.textSecondary,
            size: 19,
          ),
        )
            : null,
        filled: true,
        fillColor: AppColor.background,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(
            color: AppColor.divider.withOpacity(.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(
            color: AppColor.divider.withOpacity(.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(
            color: AppColor.mainColor,
            width: 1.3,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required String value,
    required IconData icon,
  }) {
    final isSelected = selectedFilter == value;

    return InkWell(
      onTap: () => onFilterChanged(value),
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.mainColor
              : AppColor.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppColor.mainColor
                : AppColor.divider.withOpacity(.55),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected
                  ? AppColor.white
                  : AppColor.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? AppColor.white
                    : AppColor.textPrimary,
                fontSize: 12,
                fontWeight: isSelected
                    ? FontWeight.w600
                    : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}