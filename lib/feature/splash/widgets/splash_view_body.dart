import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/utils/app_color.dart';
import '../../../core/utils/config_size.dart';
import '../../../core/utils/route_manager.dart';
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
    return MediaQuery.sizeOf(context).width > ConfigSize.phone
        ? _buildDesktopSplash()
        : _buildMobileSplash();
  }

  Widget _buildDesktopSplash() {
    return Container(
      color: AppColor.cardLight,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // =========================
          // Left Large Circle
          // =========================
          Positioned(
            left: -170,
            top: -120,
            child: _buildLargeCircle(
              size: 420,
              opacity: 0.08,
            ),
          ),

          // =========================
          // Left Middle Circle
          // =========================
          Positioned(
            left: -100,
            bottom: -130,
            child: _buildLargeCircle(
              size: 320,
              opacity: 0.06,
            ),
          ),

          // =========================
          // Right Large Circle
          // =========================
          Positioned(
            right: -180,
            top: -100,
            child: _buildLargeCircle(
              size: 450,
              opacity: 0.09,
            ),
          ),

          // =========================
          // Right Bottom Circle
          // =========================
          Positioned(
            right: -120,
            bottom: -160,
            child: _buildLargeCircle(
              size: 380,
              opacity: 0.07,
            ),
          ),

          // =========================
          // Left Decorative Ring
          // =========================
          Positioned(
            left: 70,
            top: 90,
            child: _buildRing(
              size: 90,
              opacity: 0.16,
            ),
          ),

          // =========================
          // Right Decorative Ring
          // =========================
          Positioned(
            right: 85,
            bottom: 100,
            child: _buildRing(
              size: 110,
              opacity: 0.14,
            ),
          ),

          // =========================
          // Small Left Dot
          // =========================
          Positioned(
            left: 170,
            top: 170,
            child: _buildDot(7),
          ),

          // =========================
          // Small Right Dot
          // =========================
          Positioned(
            right: 180,
            top: 220,
            child: _buildDot(6),
          ),

          // =========================
          // Small Bottom Left Dot
          // =========================
          Positioned(
            left: 250,
            bottom: 150,
            child: _buildDot(4),
          ),

          // =========================
          // Small Bottom Right Dot
          // =========================
          Positioned(
            right: 250,
            bottom: 180,
            child: _buildDot(5),
          ),

          // =========================
          // Center Logo
          // =========================
          Center(
            child: _buildDesktopLogo(),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLogo() {
    return SizedBox(
      width: 330,
      height: 330,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Logo Glow
          Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColor.mainColor.withOpacity(0.18),
                  blurRadius: 90,
                  spreadRadius: 15,
                ),
              ],
            ),
          ),

          // Outer Ring
          Container(
            width: 270,
            height: 270,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColor.mainColor.withOpacity(0.10),
                width: 1,
              ),
            ),
          ),

          // Main Circle
          Container(
            width: 245,
            height: 245,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColor.mainColor.withOpacity(0.13),
                  AppColor.mainColor.withOpacity(0.035),
                ],
              ),
              border: Border.all(
                color: AppColor.mainColor.withOpacity(0.35),
                width: 1.5,
              ),
            ),
          ),

          // Inner Ring
          Container(
            width: 215,
            height: 215,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColor.mainColor.withOpacity(0.08),
                width: 1,
              ),
            ),
          ),

          // Logo
          Positioned(
            top: 85,
            right: 25,
            child: Image.asset(
              Assets.assets.images.amAdel.path,
              width: 185,
              height: 125,
              fit: BoxFit.contain,
              color: AppColor.mainColor,
            ),
          ),

          // Person
          Positioned(
            left: 30,
            bottom: 43,
            child: Image.asset(
              Assets.assets.images.amAdelPerson.path,
              width: 125,
              height: 145,
              fit: BoxFit.contain,
            ),
          ),

          // Top Dot
          Positioned(
            top: 28,
            right: 85,
            child: _buildDot(7),
          ),

          // Left Dot
          Positioned(
            left: 20,
            top: 120,
            child: _buildDot(5),
          ),

          // Bottom Dot
          Positioned(
            right: 35,
            bottom: 55,
            child: _buildDot(5),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileSplash() {
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

  Widget _buildLargeCircle({
    required double size,
    required double opacity,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColor.mainColor.withOpacity(opacity),
            AppColor.mainColor.withOpacity(opacity * 0.35),
            Colors.transparent,
          ],
          stops: const [
            0.0,
            0.65,
            1.0,
          ],
        ),
      ),
    );
  }

  Widget _buildRing({
    required double size,
    required double opacity,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColor.mainColor.withOpacity(opacity),
          width: 1.5,
        ),
      ),
    );
  }

  Widget _buildDot(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.mainColor,
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(0.35),
            blurRadius: 12,
          ),
        ],
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