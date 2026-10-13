
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../order_review/presentation/view_model/view_model/order_review_cubit.dart';

class AdminOrderCommentsButton extends StatelessWidget {
  const AdminOrderCommentsButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderReviewCubit, OrderReviewState>(
      buildWhen: (previous, current) =>
      current is OrderReviewLoading ||
          current is OrderReviewSuccess ||
          current is OrderReviewError,
      builder: (context, state) {
        final commentCount =
            context.read<OrderReviewCubit>().reviews.length;

        return IconButton(
          onPressed: onTap,
          tooltip: 'تقييمات الطلبات',
          splashRadius: 22,
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.rate_review_outlined,
                color: AppColor.mainColor,
                size: 24,
              ),
              if (commentCount > 0)
                Positioned(
                  right: -11,
                  top: -11,
                  child: _AnimatedCountBadge(
                    count: commentCount,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _AnimatedCountBadge extends StatefulWidget {
  const _AnimatedCountBadge({
    required this.count,
  });

  final int count;

  @override
  State<_AnimatedCountBadge> createState() =>
      _AnimatedCountBadgeState();
}

class _AnimatedCountBadgeState extends State<_AnimatedCountBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.5,
          end: 1.25,
        ).chain(
          CurveTween(curve: Curves.easeOutBack),
        ),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.25,
          end: 1,
        ).chain(
          CurveTween(curve: Curves.easeOut),
        ),
        weight: 40,
      ),
    ]).animate(_controller);

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant _AnimatedCountBadge oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.count != widget.count) {
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.count > 99 ? '99+' : '${widget.count}';

    return ScaleTransition(
      scale: _scaleAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        constraints: const BoxConstraints(
          minWidth: 23,
          minHeight: 23,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 3,
        ),
        decoration: BoxDecoration(
          color: AppColor.red,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColor.cardLight,
            width: 1.8,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.red.withValues(alpha: 0.3),
              blurRadius: 7,
              spreadRadius: 1,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
          child: Text(
            text,
            key: ValueKey(widget.count),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}
