import 'package:am_adel_dashboard/core/utils/app_color.dart';
import 'package:am_adel_dashboard/feature/my_products/presentation/widgets/tap_bar_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubit/products_cubit/products_cubit.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../category/domain/entities/category_entity.dart';
import '../../../category/presentation/view_model/category_cubit.dart';

class CategoryTabs extends StatefulWidget {
  const CategoryTabs({super.key});

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs>
    with TickerProviderStateMixin {
  TabController? _tabController;

  int selectedCategoryIndex = 0;

  String? selectedSize;

  CategoryEntity? get selectedCategory {
    final categories = context.read<CategoryCubit>().categories;

    if (categories.isEmpty) {
      return null;
    }

    if (selectedCategoryIndex >= categories.length) {
      return categories.first;
    }

    return categories[selectedCategoryIndex];
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      context.read<CategoryCubit>().getCategories();
    });
  }

  void _createTabController(List<CategoryEntity> categories) {
    if (categories.isEmpty) {
      return;
    }

    if (selectedCategoryIndex >= categories.length) {
      selectedCategoryIndex = 0;
    }

    if (_tabController != null && _tabController!.length == categories.length) {
      return;
    }

    _tabController?.removeListener(_onTabChanged);
    _tabController?.dispose();

    final sizes = categories[selectedCategoryIndex].sizes;

    selectedSize = sizes.isNotEmpty ? sizes.first : null;

    _tabController = TabController(
      length: categories.length,
      vsync: this,
      initialIndex: selectedCategoryIndex,
    );

    _tabController!.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    final controller = _tabController;

    if (controller == null) {
      return;
    }

    if (controller.indexIsChanging) {
      return;
    }

    final categories = context.read<CategoryCubit>().categories;

    if (categories.isEmpty) {
      return;
    }

    final index = controller.index;

    if (index < 0 || index >= categories.length) {
      return;
    }

    final sizes = categories[index].sizes;

    if (!mounted) {
      return;
    }

    setState(() {
      selectedCategoryIndex = index;

      selectedSize = sizes.isNotEmpty ? sizes.first : null;
    });

    _filterProducts();
  }

  void _filterProducts() {
    final category = selectedCategory;

    if (category == null) {
      return;
    }

    context.read<ProductsCubit>().filterProducts(category.name);
  }

  @override
  void dispose() {
    _tabController?.removeListener(_onTabChanged);
    _tabController?.dispose();

    _tabController = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        final categories = context.read<CategoryCubit>().categories;

        if (state is CategoryGetLoading && categories.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.mainColor),
          );
        }

        if (categories.isEmpty) {
          return const Center(
            child: Text(
              'لا توجد تصنيفات',
              style: TextStyle(
                color: AppColor.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        _createTabController(categories);
        return _buildContent(categories);
      },
    );
  }

  Widget _buildContent(List<CategoryEntity> categories) {
    final controller = _tabController;

    if (controller == null) {
      return const SizedBox.shrink();
    }

    if (selectedCategoryIndex >= categories.length) {
      return const SizedBox.shrink();
    }

    final category = categories[selectedCategoryIndex];

    return Column(
      children: [
        const SizedBox(height: 2),

        Container(
          height: 70,
          margin: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 10,
            right: 10,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            color: AppColor.cardLight,
            borderRadius: BorderRadius.circular(
              AppConstants.borderRadius,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColor.mainColor.withOpacity(.10),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 1),
              ),
            ],
            border: const Border(
              bottom: BorderSide(
                color: AppColor.divider,
                width: 1,
              ),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,

          child: TabBar(
            splashFactory: NoSplash.splashFactory,

            controller: controller,

            isScrollable: true,

            tabAlignment: TabAlignment.start,

            indicator: BoxDecoration(
              color: AppColor.mainColor,
              borderRadius: BorderRadius.circular(25),
            ),

            indicatorSize: TabBarIndicatorSize.tab,

            labelColor: AppColor.white,

            unselectedLabelColor: AppColor.textSecondary,

            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),

            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),

            dividerColor: AppColor.transparent,

            overlayColor: WidgetStateProperty.all(
              AppColor.transparent,
            ),

            splashBorderRadius: BorderRadius.circular(25),

            tabs: categories.map((category) {
              return Tab(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  child: Text(category.name),
                ),
              );
            }).toList(),
          ),
        ),

        _buildSizes(category),

        Expanded(
          child: TabBarView(
            controller: controller,

            physics: const NeverScrollableScrollPhysics(),

            children: categories.map((category) {
              return TapBarViewBody(
                category: category.name,

                size: category.name == selectedCategory?.name
                    ? selectedSize
                    : null,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSizes(CategoryEntity category) {
    final sizes = category.sizes;

    if (sizes.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 55,

      margin: const EdgeInsets.symmetric(horizontal: 10),

      child: Row(
        children: sizes.map((size) {
          final isSelected = selectedSize == size;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),

              child: InkWell(
                borderRadius: BorderRadius.circular(20),

                onTap: () {
                  if (selectedSize == size) {
                    return;
                  }

                  setState(() {
                    selectedSize = size;
                  });
                },

                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),

                  alignment: Alignment.center,

                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColor.mainColor
                        : AppColor.cardLight,

                    borderRadius: BorderRadius.circular(20),

                    border: Border.all(
                      color: isSelected
                          ? AppColor.mainColor
                          : AppColor.divider,
                      width: 1,
                    ),

                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: AppColor.mainColor.withOpacity(.12),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ]
                        : null,
                  ),

                  child: Text(
                    size,

                    style: TextStyle(
                      color: isSelected
                          ? AppColor.white
                          : AppColor.textSecondary,

                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
