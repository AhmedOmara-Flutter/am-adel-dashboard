import 'package:flutter/material.dart';
import '../../../../../core/utils/style_manager.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(.055),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        splashColor: color.withOpacity(.10),
        highlightColor: color.withOpacity(.04),
        child: SizedBox(
          height: 36,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 17, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: StyleManager.font11Weight400(
                  context,
                ).copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
