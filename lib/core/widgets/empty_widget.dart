import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../generated/assets.dart';


class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 700,
        height: 700,
        child: Lottie.asset(
          Assets.assets.json.empty,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}