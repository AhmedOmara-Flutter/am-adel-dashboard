
import 'package:flutter/material.dart';
import 'package:am_adel_dashboard/core/widgets/custom_back_button.dart';

import '../utils/app_color.dart';

class InfoActionRow extends StatelessWidget {
  final String text;
  final bool isBack;
  final bool isNotification;
  final double bottomPadding;


  const InfoActionRow(
      {super.key, required this.text, this.isBack = false, this.isNotification = false, this.bottomPadding = 20,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 20, right: 20, top: 40, bottom: bottomPadding),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          !isBack?SizedBox(
            height: 60,
            width: 60,
          ):CustomBackButton(),

          Text(text, style: Theme.of(context).textTheme.displaySmall),

          !isNotification ? SizedBox(
            height: 60,
            width: 60,
          ) : ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Material(
              color: Color(0xffEEF8ED),
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Icon(
                        Icons.notifications_none_outlined,
                        size: 30,
                        color: AppColor.mainColor,
                      ),
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: Color(0xffF24135),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
