import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';

class CustomNotificationSendButton extends StatelessWidget {
  const CustomNotificationSendButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    this.text = 'إرسال الإشعار',
    this.loadingText = 'جاري إرسال الإشعار...',
    this.icon = Icons.send_rounded,
  });

  final VoidCallback? onPressed;
  final bool isLoading;
  final String text;
  final String loadingText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.mainColor,
          foregroundColor: AppColor.textOnDark,
          disabledBackgroundColor: AppColor.backgroundDark,
          disabledForegroundColor: AppColor.textSecondary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isLoading
              ? _buildLoading(context)
              : _buildSend(context),
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Row(
      key: const ValueKey('notification_loading'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2.3,
            color: AppColor.textOnDark,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          loadingText,
          style: StyleManager.font14Weight600(context).copyWith(
            color: AppColor.textOnDark,
          ),
        ),
      ],
    );
  }

  Widget _buildSend(BuildContext context) {
    return Row(
      key: const ValueKey('notification_send'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 20,
        ),
        const SizedBox(width: 9),
        Text(
          text,
          style: StyleManager.font14Weight600(context).copyWith(
            color: AppColor.textOnDark,
          ),
        ),
      ],
    );
  }
}