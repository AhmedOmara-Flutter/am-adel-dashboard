import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';

class DailyReportStatCard extends StatelessWidget {
const DailyReportStatCard({
super.key,
required this.title,
required this.value,
required this.subtitle,
required this.icon,
this.isTotal = false,
});

final String title;
final String value;
final String subtitle;
final IconData icon;
final bool isTotal;

@override
Widget build(BuildContext context) {
return Container(
padding: const EdgeInsets.all(14),
decoration: BoxDecoration(
color: AppColor.cardLight,
borderRadius: BorderRadius.circular(18),
border: Border.all(
color: AppColor.border.withOpacity(.28),
),
),
child: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Container(
width: 36,
height: 36,
decoration: BoxDecoration(
color: isTotal
? AppColor.mainColor.withOpacity(.12)
    : AppColor.backgroundDark,
borderRadius: BorderRadius.circular(12),
),
child: Icon(
icon,
size: 19,
color: AppColor.mainColor,
),
),
if (isTotal)
Container(
width: 7,
height: 7,
decoration: BoxDecoration(
color: AppColor.mainColor,
shape: BoxShape.circle,
),
),
],
),
const SizedBox(height: 12),
Row(
crossAxisAlignment: CrossAxisAlignment.end,
children: [
Flexible(
child: Text(
value,
maxLines: 1,
overflow: TextOverflow.ellipsis,
style: TextStyle(
color: AppColor.textPrimary,
fontSize: 21,
fontWeight: FontWeight.w800,
height: 1,
),
),
),
const SizedBox(width: 5),
Padding(
padding: const EdgeInsets.only(bottom: 1),
child: Text(
subtitle,
style: TextStyle(
color: AppColor.textSecondary,
fontSize: 10,
fontWeight: FontWeight.w500,
),
),
),
],
),
const SizedBox(height: 7),
Text(
title,
maxLines: 1,
overflow: TextOverflow.ellipsis,
style: TextStyle(
color: AppColor.textSecondary,
fontSize: 12,
fontWeight: FontWeight.w500,
),
),
],
),
);
}
}
