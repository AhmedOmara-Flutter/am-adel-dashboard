import 'package:am_adel_dashboard/core/extension/responsive_extension.dart';
import 'package:am_adel_dashboard/feature/reviews/presentation/widgets/reviews_view_body_desktop.dart';
import 'package:am_adel_dashboard/feature/reviews/presentation/widgets/reviews_view_body_mobile.dart';
import 'package:flutter/material.dart';

class ReviewsViewBody extends StatelessWidget {
  const ReviewsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return context.isDesktop
        ? const ReviewsViewBodyDesktop()
        : const ReviewsViewBodyMobile();
  }
}
