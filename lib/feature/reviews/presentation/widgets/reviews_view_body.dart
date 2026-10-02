import 'package:am_adel_dashboard/feature/reviews/presentation/widgets/reviews_view_body_desktop.dart';
import 'package:am_adel_dashboard/feature/reviews/presentation/widgets/reviews_view_body_mobile.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/config_size.dart';

class ReviewsViewBody extends StatelessWidget {
  const ReviewsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery
        .sizeOf(context)
        .width > ConfigSize.phone
        ? const ReviewsViewBodyDesktop()
        : const ReviewsViewBodyMobile();
  }
}
