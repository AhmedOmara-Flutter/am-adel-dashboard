import 'package:flutter/material.dart';
import '../utils/app_color.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
    this.backgroundColor = AppColor.mainColor,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FloatingActionButton(
            heroTag: null,
            backgroundColor: backgroundColor,
            shape: const CircleBorder(),
            onPressed: onPressed,
            child: Icon(
              icon,
              color: AppColor.white,
            ),
          ),
        ],
      ),
    );
  }
}