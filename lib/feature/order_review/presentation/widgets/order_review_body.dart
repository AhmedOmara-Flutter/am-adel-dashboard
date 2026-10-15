import 'package:am_adel_dashboard/core/utils/app_imports.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../data/models/order_review_model.dart';
import '../view_model/view_model/order_review_cubit.dart';
import 'order_review_card.dart';
import 'order_review_header.dart';
import 'order_review_statistics.dart';

class OrderReviewBody extends StatefulWidget {
  const OrderReviewBody({super.key});

  @override
  State<OrderReviewBody> createState() => _OrderReviewBodyState();
}

class _OrderReviewBodyState extends State<OrderReviewBody> {
  final TextEditingController _searchController = TextEditingController();

  String _filter = 'الكل';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  List<OrderReviewModel> _filterReviews(List<OrderReviewModel> reviews) {
    final query = _searchController.text.trim().toLowerCase();

    return reviews.where((review) {
      final matchesSearch = [
        review.orderId,
        review.userId,
        review.customerName ?? '',
        review.customerPhone ?? '',
        review.foodReview,
        review.driverReview,
      ].any((value) => value.toLowerCase().contains(query));

      final matchesRating = switch (_filter) {
        '5 نجوم' => review.foodRating == 5 && review.driverRating == 5,
        '4 نجوم' => review.foodRating >= 4 && review.driverRating >= 4,
        'أقل من 3' => review.foodRating <= 3 || review.driverRating <= 3,
        _ => true,
      };

      return matchesSearch && matchesRating;
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<OrderReviewCubit, OrderReviewState>(
        builder: (context, state) {
          final cubit = context.read<OrderReviewCubit>();
          final reviews = cubit.reviews;

          if (state is OrderReviewInitial ||
              (state is OrderReviewLoading && reviews.isEmpty)) {
            return const Center(
              child: CircularProgressIndicator(color: AppColor.accentColor),
            );
          }

          if (state is OrderReviewError && reviews.isEmpty) {
            return _ErrorView(
              message: state.message,
              onRetry: cubit.getReviews,
            );
          }

          final filteredReviews = _filterReviews(reviews);

          return ListView(
            padding: const EdgeInsets.all(10),
            children: [
              OrderReviewHeader(),
              const SizedBox(height: 25),
              OrderReviewStatistics(reviews:reviews),
              const SizedBox(height: 10),
              _buildSearchAndFilter(),
              const SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(width: 10,),
                  Container(
                    width: 4,
                    height: 25,
                    decoration: BoxDecoration(
                      color: AppColor.accentColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'آراء العملاء',
                      style: StyleManager.font16Weight700(context),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.cardLight,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColor.divider.withValues(alpha: 0.6),
                      ),
                    ),
                    child: Text(
                      '${filteredReviews.length} تقييم',
                      style: StyleManager.font13Weight400(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              if (filteredReviews.isEmpty)
                _buildEmptyState()
              else
                ...filteredReviews.map(
                  (review) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: OrderReviewCard(review: review),
                  ),
                ),
              if (state is OrderReviewLoading)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColor.accentColor,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }



  Widget _buildSearchAndFilter() {
    const filters = [
      ('الكل', Icons.grid_view_rounded),
      ('5 نجوم', Icons.star_rounded),
      ('4 نجوم', Icons.star_half_rounded),
      ('أقل من 3', Icons.star_outline_rounded),
    ];

    return CustomContainer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 600;

          final searchField = TextField(
            controller: _searchController,
            textInputAction: TextInputAction.search,
            onChanged: (_) => setState(() {}),
            style: const TextStyle(color: AppColor.textPrimary, fontSize: 13),
            decoration: InputDecoration(
              hintText: 'اسم العميل أو رقم التليفون أو الطلب',
              hintStyle: const TextStyle(
                color: AppColor.textSecondary,
                fontSize: 12,
              ),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: AppColor.textSecondary,
                size: 21,
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: AppColor.textSecondary,
                        size: 18,
                      ),
                    )
                  : null,
              filled: true,
              fillColor: AppColor.cardLight,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColor.divider.withValues(alpha: 0.5),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColor.divider.withValues(alpha: 0.5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColor.divider.withValues(alpha: 0.5),
                ),
              ),
            ),
          );

          final filterSection = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'تصفية حسب التقييم',
                style: TextStyle(
                  color: AppColor.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: filters.map((item) {
                  final selected = _filter == item.$1;

                  return InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      setState(() => _filter = item.$1);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColor.mainColor.withValues(alpha: 0.08)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selected
                              ? AppColor.secondaryColor.withValues(alpha: 0.6)
                              : AppColor.divider.withValues(alpha: 0.8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            item.$2,
                            size: 16,
                            color: selected
                                ? AppColor.secondaryColor
                                : AppColor.textSecondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            item.$1,
                            style: TextStyle(
                              color: selected
                                  ? AppColor.secondaryColor
                                  : AppColor.textSecondary,
                              fontSize: 12,
                              fontWeight: selected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );

          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: searchField),
                const SizedBox(width: 20),
                Expanded(flex: 6, child: filterSection),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [searchField, const SizedBox(height: 20), filterSection],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return CustomContainer(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height*0.5,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.reviews_outlined, color: AppColor.accentColor, size: 52),
          SizedBox(height: 16),
          Text(
            'لا توجد تقييمات',
            style:StyleManager.font15Weight800(context).copyWith(
              color: AppColor.black
            )
          ),
          SizedBox(height: 8),
          Text(
            'جرّب تغيير كلمات البحث أو الفلتر المحدد.',
            textAlign: TextAlign.center,
            style:StyleManager.font11Weight400(context)
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppColor.cardLight,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColor.divider),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColor.red.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.error_outline_rounded,
                  color: AppColor.red,
                  size: 34,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'تعذر تحميل التقييمات',
                style: TextStyle(
                  color: AppColor.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColor.textSecondary,
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('إعادة المحاولة'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.mainColor,
                  foregroundColor: AppColor.textOnDark,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
