import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/utils/style_manager.dart';
import '../../../../core/utils/app_color.dart';

class CustomTextField extends StatelessWidget {
final bool readOnly;
final void Function()? onTap;
final void Function(String)? onChanged;

const CustomTextField({
super.key,
this.readOnly = false,
this.onTap,
this.onChanged,
});

@override
Widget build(BuildContext context) {
return Container(
margin: const EdgeInsets.symmetric(horizontal: 10),
decoration: BoxDecoration(
color: AppColor.cardLight,
borderRadius: BorderRadius.circular(12),
border: Border.all(
color: AppColor.backgroundDark,
width: 1,
),
boxShadow: [
BoxShadow(
color: AppColor.mainColor.withOpacity(.06),
blurRadius: 10,
offset: const Offset(0, 4),
),
],
),
child: TextFormField(
onChanged: onChanged,
readOnly: readOnly,
onTap: onTap,
cursorColor: AppColor.mainColor,
style: Theme.of(context).textTheme.bodyMedium!.copyWith(
color: AppColor.textPrimary,
fontWeight: FontWeight.w600,
),
decoration: InputDecoration(
hintText: 'ابحث عن...',
hintStyle: StyleManager.font13Weight600(context).copyWith(
color: AppColor.textSecondary.withOpacity(.65),
),
prefixIcon: Padding(
padding: const EdgeInsetsDirectional.only(
start: 14,
end: 8,
),
child: Icon(
Icons.search_rounded,
color: AppColor.mainColor,
size: 21,
),
),
prefixIconConstraints: const BoxConstraints(
minWidth: 45,
minHeight: 45,
),
filled: true,
fillColor: Colors.transparent,
contentPadding: const EdgeInsets.symmetric(
horizontal: 12,
vertical: 15,
),
border: InputBorder.none,
enabledBorder: InputBorder.none,
focusedBorder: InputBorder.none,
),
),
);
}
}
