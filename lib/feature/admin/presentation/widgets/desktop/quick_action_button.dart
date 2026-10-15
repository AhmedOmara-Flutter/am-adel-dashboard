import '../../../../../core/utils/app_imports.dart';

class QuickActionButton extends StatefulWidget {
  const QuickActionButton({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.index,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String index;
  final VoidCallback onTap;

  @override
  State<QuickActionButton> createState() => QuickActionButtonState();
}

class QuickActionButtonState extends State<QuickActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _isHovered ? -3 : 0, 0),
        decoration: BoxDecoration(
          color: _isHovered ? AppColor.background : AppColor.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _isHovered
                ? AppColor.accentColor.withOpacity(.65)
                : AppColor.divider.withOpacity(0.25),
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: AppColor.accentColor.withOpacity(.12),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: _isHovered
                          ? const LinearGradient(
                        colors: [
                          AppColor.accentColor,
                          AppColor.goldLight,
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      )
                          : null,
                      color: _isHovered
                          ? null
                          : AppColor.accentColor.withOpacity(.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.icon,
                      size: 23,
                      color: AppColor.mainColor,
                    ),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleManager.font12Weight500(context).copyWith(
                            color: AppColor.textPrimary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleManager.font11Weight400(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: _isHovered
                          ? AppColor.accentColor.withOpacity(.2)
                          : AppColor.backgroundDark.withOpacity(.65),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 11,
                      color: AppColor.mainColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
