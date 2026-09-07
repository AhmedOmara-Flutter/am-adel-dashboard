import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';

class ManagerInfoCard extends StatelessWidget {
  final String name;
  final String phone;

  const ManagerInfoCard({
    super.key,
    required this.name,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF242424),
            Color(0xFF1D1D1D),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColor.border.withOpacity(.8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.18),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColor.mainColor.withOpacity(.12),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: AppColor.mainColor.withOpacity(.25),
              ),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: AppColor.accentColor,
              size: 28,
            ),
          ),

          const SizedBox(width: 14),

          // Information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'معلومات المدير',
                      style: TextStyle(
                        color: AppColor.textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(width: 7),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.mainColor.withOpacity(.12),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'MANAGER',
                        style: TextStyle(
                          color: AppColor.accentColor,
                          fontSize: 7,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColor.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      size: 13,
                      color: AppColor.textSecondary.withOpacity(.8),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      phone,
                      style: const TextStyle(
                        color: AppColor.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}