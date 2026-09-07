import 'package:flutter/material.dart';
import '../../../../core/services/print_service.dart';
import '../../../../core/services/printer_service.dart';
import '../../../../core/utils/app_color.dart';
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
    final copies = await PrinterService.getPrintCopies();

    if (!mounted) return;

    setState(() {
      _copies = copies;
    });
  }

  Future<void> _changeCopies(int value) async {
    await PrinterService.setPrintCopies(value);

    if (!mounted) return;

    setState(() {
      _copies = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColor.border.withOpacity(.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  height: 80,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        bottom: 5,
                        left: 20,
                        right: 20,
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.mainColor.withOpacity(.18),
                                blurRadius: 35,
                                spreadRadius: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/printer.png',
                        fit: BoxFit.contain,
                        width: 155,
                        height: 135,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 34,
                          decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'إعدادات الطباعة',
                            style: StyleManager.font19Weight700(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'اختر عدد الأوراق التي سيتم طباعة الطلب بها',
                      style: StyleManager.font13Weight600(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppColor.mainColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'عدد أوراق الطلب',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColor.mainColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _PrintOption(
                  title: 'ورقة واحدة',
                  subtitle: 'طباعة الطلب مرة واحدة',
                  icon: Icons.description_outlined,
                  selected: _copies == 1,
                  onTap: () => _changeCopies(1),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PrintOption(
                  title: 'ورقتين',
                  subtitle: 'طباعة نسختين من الطلب',
                  icon: Icons.content_copy_rounded,
                  selected: _copies == 2,
                  onTap: () => _changeCopies(2),
                ),
              ),
            ],
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
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected
              ? AppColor.mainColor.withOpacity(.08)
              : AppColor.surface,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: selected ? AppColor.mainColor : AppColor.border,
            width: selected ? 1.4 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColor.mainColor.withOpacity(.10),
                    blurRadius: 18,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 43,
              height: 43,
              decoration: BoxDecoration(
                color: selected
                    ? AppColor.mainColor.withOpacity(.14)
                    : AppColor.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: selected ? AppColor.mainColor : AppColor.textSecondary,
                size: 22,
              ),
            ),
            const SizedBox(width: 10),
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
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColor.textSecondary.withOpacity(.7),
                      fontSize: 9,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColor.mainColor : Colors.transparent,
                border: Border.all(
                  color: selected ? AppColor.mainColor : AppColor.border,
                  width: 1.5,
                ),
              ),
              child: selected
                  ? const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 14,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
