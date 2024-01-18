import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/contants/constants.dart';

class MyFlooatingButton extends StatelessWidget {
  final IconData myIcon;
  final Function() onPressed;
  const MyFlooatingButton(
      {super.key, required this.myIcon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(width: 25.h, height: 25.h),
      fillColor: appColor,
      shape: const CircleBorder(),
      elevation: 0,
      onPressed: onPressed,
      child: Icon(
        myIcon,
        color: Colors.white,
      ),
    );
  }
}
