
import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../generated/assets.dart';

class ManagerInfoCardDesktop extends StatelessWidget {
  const ManagerInfoCardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.cardLight,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColor.divider.withOpacity(0.5),
          ),
        ),
        child: Column(
          children: [
            // بيانات المدير
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    shape: BoxShape.circle
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child:Image.asset(Assets.assets.images.me.path)
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'أحمد عماره',
                        style: StyleManager.font15Weight700(context),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'مدير النظام',
                        style: StyleManager.font11Weight400(context),
                      ),
                    ],
                  ),
                ),

                // حالة الحساب
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.green.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.circle,
                        size: 7,
                        color: AppColor.green,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'نشط',
                        style: StyleManager.font11Weight400(context).copyWith(
                          color: AppColor.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Divider(
              height: 1,
              color: AppColor.divider.withOpacity(0.55),
            ),

            const SizedBox(height: 13),

            // معلومات التواصل
            Row(
              children: [
                Expanded(
                  child: _info(
                    context,
                    icon: Icons.phone_outlined,
                    label: 'رقم الهاتف',
                    value: '01098431538',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _info(
                    context,
                    icon: Icons.shield_outlined,
                    label: 'نوع الحساب',
                    value: 'مسؤول النظام',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _info(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
      }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: AppColor.accentColor,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: StyleManager.font11Weight400(context),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: StyleManager.font12Weight500(context).copyWith(
                  color: AppColor.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
