import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:am_adel_dashboard/generated/assets.dart';

import '../utils/app_color.dart';
import '../utils/app_constants.dart';

class CustomBackButton extends StatelessWidget {
  final Color? color;

  const CustomBackButton({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Future.delayed(Duration(milliseconds: 200));
        Navigator.pop(context);
      },
      child: Container(
        height: 55,
        width: 55,
        margin: EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          color: AppColor.cardLight,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColor.secondaryColor.withOpacity(
                AppConstants.borderColor,
              ),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 1),
            ),
          ],
          border: Border(
            bottom: BorderSide(color: AppColor.divider),
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            Assets.assets.images.arrowBack.path,
            color: AppColor.mainColor,
          ),
        ),
      ),
    );
  }
}