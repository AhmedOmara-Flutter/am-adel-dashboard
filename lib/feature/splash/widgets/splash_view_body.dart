import 'dart:async';

import 'package:flutter/material.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/route_manager.dart';
import '../../../core/utils/style_manager.dart';
import '../../../generated/assets.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with TickerProviderStateMixin {
  Timer? _timer;

  late AnimationController _controller;

  late Animation<Offset> logoSlide;
  late Animation<double> logoFade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    logoSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    logoFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();

    goToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.assets.images.splashBg.path),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 150,width: double.infinity,),
          FadeTransition(
            opacity: logoFade,
            child: SlideTransition(
              position: logoSlide,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Hero(
                    tag: 'appLogo',
                    child: Image.asset(
                      Assets.assets.images.appLogo2.path,
                      height: 250,
                      width: 280,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 25),
                  Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.star_rounded,
                            color: AppColor.mainColor,
                            size: 16,
                          ),
                        ),
                        const TextSpan(text: '  '),
                        TextSpan(
                          text: 'طعم على أصوله.. وحكاية في كل لقمة',
                          style: StyleManager.font14Weight600(context).copyWith(
                            color: AppColor.mainColor,
                          ),
                        ),
                        const TextSpan(text: '  '),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.star_rounded,
                            color: AppColor.mainColor,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 165),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: AppColor.mainColor,
                  strokeWidth: 3,
                ),
                SizedBox(height: 10),
                Text(
                  'جاري التحميل',
                  style: StyleManager.font14Weight600(context).copyWith(
                    color: AppColor.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void goToHome() {
    _timer = Timer(
      const Duration(seconds: 3),
          () {
        if (!mounted) return;

        Navigator.pushReplacementNamed(
          context,
          RouteManager.main,
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();

    super.dispose();
  }
}