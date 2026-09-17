import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../generated/assets.dart';

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
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColor.divider,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.secondaryColor.withOpacity(.10),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              color: AppColor.cardLight,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColor.accentColor.withOpacity(.30),
                width: 1.2,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
            Assets.assets.images.amAdelLogo.path,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.backgroundDark,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'MANAGER',
                        style: TextStyle(
                          color: AppColor.mainColor,
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                          letterSpacing: .5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: AppColor.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColor.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    const Icon(
                      Icons.phone_rounded,
                      color: AppColor.accentColor,
                      size: 15,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      phone,
                      style: const TextStyle(
                        color: AppColor.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColor.backgroundDark,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.verified_rounded,
              color: AppColor.accentColor,
              size: 19,
            ),
          ),
        ],
      ),
    );
  }
}