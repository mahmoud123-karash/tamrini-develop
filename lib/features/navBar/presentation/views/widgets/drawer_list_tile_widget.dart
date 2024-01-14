import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/contants/constants.dart';

class DrawerListTileWidget extends StatelessWidget {
  const DrawerListTileWidget(
      {super.key,
      required this.isSelected,
      required this.onPressed,
      required this.icon,
      required this.lable});
  final bool isSelected;
  final VoidCallback onPressed;
  final IconData icon;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isSelected
          ? BoxDecoration(
              color: appColor,
              borderRadius: BorderRadius.circular(15),
            )
          : null,
      child: ListTile(
        hoverColor: greyColor,
        onTap: onPressed,
        leading: Icon(icon),
        title: Text(
          lable,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'cairo',
          ),
        ),
      ),
    );
  }
}
