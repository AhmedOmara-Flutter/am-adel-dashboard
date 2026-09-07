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

class _SplashViewBodyState extends State<SplashViewBody> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    goToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Assets.assets.images.splashBg.path,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void goToHome() {
    _timer = Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
        context,
        RouteManager.main,
      );

    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

