import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class IconBadge extends StatelessWidget {
  const IconBadge({super.key, required this.icon,required this.iconColor});

  final IconData icon;
  final Color iconColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColor.accentColor.withOpacity(.18),
            AppColor.accentColor.withOpacity(.06),
          ],
        ),
        shape: BoxShape.circle,
        border: Border.all(color: AppColor.accentColor.withOpacity(.12)),
      ),
      child: Icon(icon, color: iconColor, size: 24),
    );
  }
}
