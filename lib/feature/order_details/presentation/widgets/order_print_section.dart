import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';

class OrderPrintSection extends StatelessWidget {
final VoidCallback? onPressed;

const OrderPrintSection({
super.key,
this.onPressed,
});

@override
Widget build(BuildContext context) {
return Container(
width: double.infinity,
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: AppColor.cardLight,
borderRadius: BorderRadius.circular(18),
border: Border.all(
color: AppColor.divider.withOpacity(.55),
),
),
child: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
Row(
children: [
Container(
width: 40,
height: 40,
decoration: BoxDecoration(
color: AppColor.mainColor.withOpacity(.09),
borderRadius: BorderRadius.circular(10),
),
child: Icon(
Icons.print_outlined,
color: AppColor.mainColor,
size: 20,
),
),
const SizedBox(width: 12),
Expanded(
child: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'طباعة الطلب',
style: StyleManager.font14Weight600(context)
    .copyWith(color: AppColor.textPrimary),
),
const SizedBox(height: 4),
Text(
'طباعة الفاتورة وتفاصيل الطلب',
maxLines: 2,
overflow: TextOverflow.ellipsis,
style: StyleManager.font11Weight400(context)
    .copyWith(color: AppColor.textSecondary),
),
],
),
),
],
),
const SizedBox(height: 14),
SizedBox(
height: 42,
child: ElevatedButton.icon(
onPressed: onPressed,
icon: const Icon(Icons.print_rounded, size: 18),
label: Text(
'طباعة الطلب',
style: StyleManager.font13Weight600(context).copyWith(
color: AppColor.textOnDark,
),
),
style: ElevatedButton.styleFrom(
backgroundColor: AppColor.mainColor,
foregroundColor: AppColor.textOnDark,
elevation: 0,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
),
),
),
),
],
),
);
}
}
