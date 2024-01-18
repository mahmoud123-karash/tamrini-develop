import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamrini/core/contants/constants.dart';

class ChooseMealContainerWidget extends StatelessWidget {
  const ChooseMealContainerWidget(
      {super.key, required this.onPressed, required this.text});
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.w,
      height: 35.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: appColor,
      ),
      child: CupertinoButton(
        padding: const EdgeInsets.all(0),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              size: 25.sp,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
