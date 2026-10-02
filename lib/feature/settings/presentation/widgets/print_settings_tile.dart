import 'package:flutter/material.dart';
import '../../../../core/services/print_service.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/style_manager.dart';

class PrintSettingsTile extends StatefulWidget {
  const PrintSettingsTile({super.key});

  @override
  State<PrintSettingsTile> createState() => _PrintSettingsTileState();
}

class _PrintSettingsTileState extends State<PrintSettingsTile> {
  int _copies = 1;

  @override
  void initState() {
    super.initState();
    _loadCopies();
  }

  Future<void> _loadCopies() async {
    final copies = await PrintService.getPrintCopies();

    if (!mounted) return;

    setState(() {
      _copies = copies;
    });
  }

  Future<void> _changeCopies(int value) async {
    await PrintService.setPrintCopies(value);

    if (!mounted) return;

    setState(() {
      _copies = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppColor.border.withOpacity(.32)),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(.035),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColor.mainColor.withOpacity(.08),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(
                  'assets/images/printer.png',
                  fit: BoxFit.contain,
                  width: 32,
                  height: 32,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'إعدادات الطباعة',
                      style: StyleManager.font18Weight700(context),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'حدد عدد نسخ الطلب المطبوعة',
                      style: StyleManager.font11Weight400(
                        context,
                      ).copyWith(color: AppColor.textSecondary),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColor.backgroundDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.print_rounded,
                      color: AppColor.mainColor,
                      size: 14,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$_copies ${_copies == 1 ? 'نسخة' : 'نسخ'}',
                      style: const TextStyle(
                        color: AppColor.mainColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 4,
                height: 17,
                decoration: BoxDecoration(
                  color: AppColor.mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'عدد أوراق الطلب',
                style: StyleManager.font13Weight700(context),
              ),
            ],
          ),
          const SizedBox(height: 11),
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: AppColor.backgroundDark.withOpacity(0.5),
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              boxShadow: [
                BoxShadow(
                  color: AppColor.mainColor.withOpacity(.035),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: _PrintOption(
                    title: 'ورقة',
                    subtitle: 'نسخة واحدة',
                    icon: Icons.description_outlined,
                    selected: _copies == 1,
                    onTap: () => _changeCopies(1),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: _PrintOption(
                    title: 'ورقتين',
                    subtitle: 'نسختان',
                    icon: Icons.content_copy_rounded,
                    selected: _copies == 2,
                    onTap: () => _changeCopies(2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrintOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _PrintOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          color: selected ? AppColor.cardLight : Colors.transparent,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: selected
                ? AppColor.mainColor.withOpacity(.22)
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: selected
                    ? AppColor.mainColor.withOpacity(.10)
                    : AppColor.cardLight.withOpacity(.55),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(
                icon,
                color: selected ? AppColor.mainColor : AppColor.textSecondary,
                size: 19,
              ),
            ),

            const SizedBox(width: 9),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: selected
                          ? AppColor.textPrimary
                          : AppColor.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppColor.textSecondary.withOpacity(.7),
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 6),

            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColor.mainColor : Colors.transparent,
                border: Border.all(
                  color: selected ? AppColor.mainColor : AppColor.divider,
                  width: 1.4,
                ),
              ),
              child: selected
                  ? const Icon(
                      Icons.check_rounded,
                      color: AppColor.textOnDark,
                      size: 13,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
