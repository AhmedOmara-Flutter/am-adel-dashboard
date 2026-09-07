import 'package:flutter/material.dart';

class CustomIsOrganic extends StatelessWidget {
  final bool isOrganic;
  final Function()? onTap;

  const CustomIsOrganic({super.key, required this.isOrganic, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isOrganic ? Color(0xff2D9F5D) : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xffDDDFDF)),
            ),
            child: isOrganic
                ? Icon(Icons.done, size: 17, color: Colors.white)
                : null,
          ),

          Text(
            'المنتج عضوي',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
