import 'package:flutter/material.dart';

class OrderStatusButton extends StatelessWidget {
  const OrderStatusButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.color,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: color.withOpacity(.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: color.withOpacity(.35),
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(.12),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withOpacity(.18),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 18,
                ),
              ),

              const SizedBox(width: 12),

              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}